import 'package:daly_doc/pages/appoinmentPlan/manager/appointmentApi.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/bookedAppoinmentModel.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/timeSlotModel.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:daly_doc/widgets/noDataWidget/noDataWidget.dart';
import 'package:daly_doc/widgets/swipeAction/flutter_swipe_action_cell.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class RescheduleAppointmentView extends StatefulWidget {
  RescheduleAppointmentView({Key? key, this.bookingData, this.title = ""})
      : super(key: key);
  BookedAppointmentModel? bookingData;
  String title = "";
  @override
  State<RescheduleAppointmentView> createState() =>
      _RescheduleAppointmentViewState();
}

class _RescheduleAppointmentViewState extends State<RescheduleAppointmentView> {
  List<TimeSlotItemModel> tags = [];
  TextEditingController dateTF = TextEditingController();
  TextEditingController timeTF = TextEditingController();
  TextEditingController messageTF = TextEditingController();
  var selectedIndex = -1;
  //var manager = PaymentManager();
  var isFirstLoad = true;
  var selectedTime = "";
  var oldTime = "";

  late SwipeActionController controller;
  DateTime calendarSelectedDate = DateTime.now();
  var manager = AppointmentApi();
  var isLoadingTimeSlot = false;
  var isLoading = false;
  BookedAppointmentModel? appointmentData = null;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getBookingDetailByID();
    });
  }

  getBookingDetailByID() async {
    isLoading = true;
    setState(() {});
    appointmentData =
        await manager.getAppointmentDataByID(id: widget.bookingData!.id);
    isLoading = false;
    setState(() {});
    if (appointmentData != null) {
      dateTF.text = appointmentData!.onlyformateDate ?? "";
      oldTime = appointmentData!.appt_local_start_time ?? "";
      setState(() {});
    }
  }

  getTimeSlots() async {
    var myDate = TaskManager().dateParseyyyyMMdd(calendarSelectedDate);
    isLoadingTimeSlot = true;
    tags = [];
    selectedTime = "";
    selectedIndex = -1;
    isFirstLoad = false;
    setState(() {});

    List<TimeSlotItemModel>? tagsTemp = await manager.getAppointmentTimeSlot(
        context: context,
        date: myDate,
        business_id: widget.bookingData!.business_id!.toString());
    isLoadingTimeSlot = false;
    setState(() {});
    if (tagsTemp == null) {
      tags = [];
    } else {
      tags = tagsTemp;
      tags.removeWhere((element) => element.isDisable == true);
    }
    // if(){

    // }
    print("tags${tags}");
    setState(() {});
  }

  rescheduleAppointment() async {
    if (selectedTime == "" || selectedIndex < 0) {
      ToastMessage.showErrorwMessage(msg: "Please Select date and time slot");
      return;
    }

    var myDate = TaskManager().dateParseyyyyMMdd(calendarSelectedDate);
    bool? status = await manager.rescheduleBooking(
        appt_date: myDate,
        appt_start_time: tags[selectedIndex].utcTime ?? "",
        appointmentID: widget.bookingData!.id.toString());
    if (status == true) {
      selectedIndex = -1;
      selectedTime = "";
      dateTF.text = "";
      tags = [];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navBarWhite,
      appBar: CustomAppBarPresentCloseButton(
          colorNavBar: AppColor.navBarWhite,
          title: "Reschedule Appointment",
          needShadow: false,
          subtitle: "",
          subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
          color: AppColor.navBarWhite,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: isLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: loaderList(),
                    )
                  : appointmentData == null
                      ? Center(
                          child: NoDataItemWidget(
                          refresh: () {
                            getBookingDetailByID();
                          },
                          msg: 'Unable to found appointment detail.',
                        ))
                      : bodyDesign(),
            ),
          )),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 20,
              ),
              appointmentFirmView()
              //
            ]),
      ),
    );
  }

  Widget appointmentFirmView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: prefer_const_constructors

        InkWell(
          onTap: () {
            if (isLoadingTimeSlot) {
              ToastMessage.showErrorwMessage(
                  msg: "Please wait  time slots are fetching.");
              return;
            }
            showCalendarModalSheet();
          },
          child: CustomTF(
            controllr: dateTF,
            enabled: false,
            placeholder: LocalString.plcDate,
            rightIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                "assets/icons/ic_calendar.png",
              ),
            ),
          ),
        ),
        if (isLoadingTimeSlot)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 10,
              width: 10,
              child: loaderList(),
            ),
          ),
        if (!isLoadingTimeSlot)
          const SizedBox(
            height: 20,
          ),
        if (oldTime != "" && selectedTime == "")
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "Old Time : " + oldTime,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
        if (selectedTime != "")
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "Time : " + selectedTime,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),

        tagList(),
        const SizedBox(
          height: 20,
        ),

        CustomButton.regular(
          title: "Reschedule Appointment",
          onTap: () {
            rescheduleAppointment();
          },
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget writeReview() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: AppColor.textBlackColor
            //                   <--- border width here
            ),

        // color: AppColor.segmentBarBgColor.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          style: TextStyle(fontSize: 20, color: AppColor.textBlackColor),
          minLines: 5,
          maxLines: 5,
          autocorrect: false,
          controller: messageTF,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Message",
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 16, color: AppColor.textBlackColor),
          ),
        ),
      ),
    );
  }

  showCalendarModalSheet() {
    FocusManager.instance.primaryFocus?.unfocus();
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Container(
            color: Colors.transparent,
            height: 350,
            child: Column(
              children: [
                Expanded(
                  child: CalendarAlertView(
                    intialDate: calendarSelectedDate,
                    enablePastDates: false,
                    onDateSelect: (dt) {
                      calendarSelectedDate = dt;

                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  child: CustomButton.regular(
                    title: "Submit",
                    onTap: () {
                      Navigator.of(context).pop();
                      dateTF.text = TaskManager()
                          .dateParseMMMDDYYYY(calendarSelectedDate);
                      getTimeSlots();
                    },
                  ),
                )
              ],
            ));
      },
    );
  }

  getErrorMessageNoTimeSlot() {
    return isFirstLoad
        ? Container()
        : dateTF.text.isEmpty
            ? Container()
            : tags.length == 0 && dateTF.text.isNotEmpty
                ? Text(
                    "Time slots are not  available of selected date. Please check on  other date.",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  )
                : Container();
  }

  tagList() {
    return tags.length == 0 && dateTF.text.isNotEmpty
        ? getErrorMessageNoTimeSlot()
        : dateTF.text.isEmpty
            ? getErrorMessageNoTimeSlot()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Slot available:",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Wrap(
                          spacing: 10.0,
                          runSpacing: 5.0,
                          alignment: WrapAlignment.start,
                          children:
                              List<Widget>.generate(tags.length, (int index) {
                            return Container(
                              height: 38,
                              width: (MediaQuery.of(context).size.width / 3) -
                                  10 -
                                  20,
                              child: ActionChip(
                                  label: Text(
                                    tags[index].localTime ?? "",
                                    style: TextStyle(
                                        color: tags[index].isSelected ?? false
                                            ? Colors.white
                                            : AppColor.theme),
                                  ),
                                  backgroundColor: tags[index].isDisable!
                                      ? Colors.grey.withOpacity(0.4)
                                      : tags[index].isSelected ?? false
                                          ? AppColor.theme
                                          : AppColor.stripGreen
                                              .withOpacity(0.2),
                                  elevation: 1.0,
                                  //shadowColor: Colors.grey[60],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                  padding: const EdgeInsets.all(0.0),
                                  onPressed: () {
                                    if (tags[index].isDisable!) {
                                      return;
                                    }
                                    if (selectedIndex > -1) {
                                      tags[selectedIndex].isSelected = false;
                                    }
                                    tags[index].isSelected =
                                        !tags[index].isSelected!;
                                    selectedIndex = index;
                                    selectedTime =
                                        tags[selectedIndex].localTime ?? "";
                                    oldTime = "";
                                    setState(() {});
                                  }),
                            );
                          }),
                        ),
                      ),
                    ]),
              );
  }
}
