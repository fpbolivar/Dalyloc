import 'package:daly_doc/pages/appoinmentPlan/components/consultantItemView.dart';
import 'package:daly_doc/pages/appoinmentPlan/components/noDataWidget.dart';
import 'package:daly_doc/pages/appoinmentPlan/components/serviceItemView.dart';
import 'package:daly_doc/pages/appoinmentPlan/manager/appointmentApi.dart';

import 'package:daly_doc/pages/appoinmentPlan/model/timeSlotModel.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/getUserDetails.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userDataModel.dart';
import 'package:daly_doc/pages/paymentPages/singlePaymentView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/pages/userProfile/userProfile.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:daly_doc/widgets/swipeAction/flutter_swipe_action_cell.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class AddAppointmentFormView extends StatefulWidget {
  AddAppointmentFormView({Key? key, this.serviceDetail, this.title = ""})
      : super(key: key);
  ServiceItemDataModel? serviceDetail;
  String title = "";
  @override
  State<AddAppointmentFormView> createState() => _AddAppointmentFormViewState();
}

class _AddAppointmentFormViewState extends State<AddAppointmentFormView> {
  List<TimeSlotItemModel> tags = [];
  TextEditingController dateTF = TextEditingController();
  TextEditingController timeTF = TextEditingController();
  TextEditingController messageTF = TextEditingController();
  var selectedIndex = -1;
  //var manager = PaymentManager();
  var userName = "";
  var selectedTime = "";
  var userMobile = "";
  var userEmail = "";
  var userCountryCode = "";
  late SwipeActionController controller;
  DateTime calendarSelectedDate = DateTime.now();
  var manager = AppointmentApi();
  var isLoadingTimeSlot = false;
  var isLoadingAdvancePayment = false;
  var advancePayment = 0.0;
  @override
  void initState() {
    super.initState();

    initSwipeController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserDetail();
      getServiceAdvancePay();
    });
  }

  getServiceAdvancePay() async {
    isLoadingAdvancePayment = true;
    setState(() {});
    double? value = await manager.getAdvancedPriceByServiceByID(
        serviceID: widget.serviceDetail!.id);
    isLoadingAdvancePayment = false;
    setState(() {});
    if (value == null) {
      advancePayment = 0;
    } else if (value != 0) {
      advancePayment = value;
      setState(() {});
    }
  }

  initSwipeController() {}
  getTimeSlots() async {
    var myDate = TaskManager().dateParseyyyyMMdd(calendarSelectedDate);
    isLoadingTimeSlot = true;
    tags = [];
    selectedTime = "";
    selectedIndex = -1;
    setState(() {});
    List<TimeSlotItemModel>? tagsTemp = await manager.getAppointmentTimeSlot(
        context: context,
        date: myDate,
        business_id: widget.serviceDetail!.business_id!.toString());
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

  getUserDetail() async {
    UserDetailModel? data = await UserDetailsApi().getUserData();
    userName = data?.name ?? "";
    userMobile = data?.mobile_no ?? "";
    userEmail = data?.email ?? "";
    userCountryCode = data?.country_code ?? "";
    setState(() {});
  }

  isProfileComplete() {
    return !(userName == "" || userMobile == "" || userEmail == "");
  }

  bookAppointment() async {
    if (!isProfileComplete()) {
      ToastMessage.showErrorwMessage(msg: "Please add contact details");
      return;
    }
    if (selectedTime == "" || selectedIndex < 0) {
      ToastMessage.showErrorwMessage(msg: "Please Select date and time slot");
      return;
    }
    var myDate = TaskManager().dateParseyyyyMMdd(calendarSelectedDate);
    bool? status = await manager.addAppointment(
        context: context,
        business_id: widget.serviceDetail!.business_id ?? "",
        business_user_id: widget.serviceDetail!.user_id ?? "",
        booked_user_name: userName,
        booked_user_phone_no: userCountryCode + userMobile,
        booked_user_email: userEmail,
        appt_date: myDate,
        appt_start_time: tags[selectedIndex].utcTime ?? "",
        booked_user_message: messageTF.text,
        t_id: DateTime.now().microsecondsSinceEpoch.toString(),
        service_id: widget.serviceDetail!.id.toString());
    if (status == true) {
      selectedIndex = -1;
      selectedTime = "";
      messageTF.text = "";
      dateTF.text = "";
      tags = [];
      setState(() {});
    }
  }

  bookAdvancePaymentAppointment() async {
    if (!isProfileComplete()) {
      ToastMessage.showErrorwMessage(msg: "Please add contact details");
      return;
    }
    if (selectedTime == "" || selectedIndex < 0) {
      ToastMessage.showErrorwMessage(msg: "Please Select date and time slot");
      return;
    }

    Routes.pushSimple(
        context: context,
        child: SinglePaymentView(
          fromAddAppointmentForm: true,
          appointmentID: "",
          onPaymentDetail: (CardDetailModel cardDetail) {
            Navigator.of(context).pop();
            advancePayProccedApi(cardDetail);
          },
        ));
  }

  advancePayProccedApi(CardDetailModel cardDetail) async {
    var myDate = TaskManager().dateParseyyyyMMdd(calendarSelectedDate);
    bool? status = await manager.addAppointmentWithAdvancePrice(
        context: context,
        card_number: cardDetail.cardNumber,
        exp_month: cardDetail.month,
        exp_year: cardDetail.year,
        cvc: cardDetail.cvv,
        business_id: widget.serviceDetail!.business_id ?? "",
        business_user_id: widget.serviceDetail!.user_id ?? "",
        booked_user_name: userName,
        booked_user_phone_no: userCountryCode + userMobile,
        booked_user_email: userEmail,
        appt_date: myDate,
        advance_payment: advancePayment.toString(),
        appt_start_time: tags[selectedIndex].utcTime ?? "",
        booked_user_message: messageTF.text,
        t_id: DateTime.now().microsecondsSinceEpoch.toString(),
        service_id: widget.serviceDetail!.id.toString());
    if (status == true) {
      selectedIndex = -1;
      selectedTime = "";
      messageTF.text = "";
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
          title: "${widget.title}",
          needShadow: false,
          subtitle: "",
          subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
          color: AppColor.navBarWhite,
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: bodyDesign()),
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
              chooseServiceView(),

              const SizedBox(
                height: 20,
              ),

              contactDetail(),
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

        textHeaderWithRightButton(
            title: "Schedule an appointment ", btnName: ""),
        const SizedBox(
          height: 20,
        ),
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

        // CustomTF(
        //   controllr: timeTF,
        //   enabled: false,
        //   placeholder: LocalString.plcTime,
        //   rightIcon: Padding(
        //       padding: EdgeInsets.all(15),
        //       child: Icon(Icons.keyboard_arrow_down_sharp)),
        // ),

        tagList(),
        const SizedBox(
          height: 20,
        ),
        writeReview(),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "To book an appointment, you must have to pay the  deposit fee asper business guidelines.",
          style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 160, 5, 5),
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 50,
        ),
        // CustomButton.regular(
        //   title: "Book Now (\$ 5.00)",
        // ),

        (isLoadingAdvancePayment)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: loaderList(),
                ),
              )
            : CustomButton.regular(
                title: advancePayment != 0
                    ? "Book Now (\$ ${advancePayment})"
                    : "Book Now",
                onTap: () {
                  if (advancePayment == 0.0) {
                    bookAppointment();
                  }
                  if (advancePayment != 0.0) {
                    bookAdvancePaymentAppointment();
                  }
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

  Widget contactDetail() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: prefer_const_constructors

        textHeaderWithRightButton(
            title: "Contact Details ",
            btnName: "Update",
            onChangeTap: () {
              Routes.pushSimple(
                  context: context,
                  child: UserProfileViewScreen(),
                  onBackPress: () {
                    getUserDetail();
                  });
            }),
        const SizedBox(
          height: 10,
        ),
        if (!isProfileComplete())
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              "Please Update User Profile",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
        Text(
          userName == "" ? "Missing Username" : "${userName}",
          style: TextStyle(
              fontSize: 14,
              color: userName != "" ? Colors.black : Colors.grey,
              fontWeight: FontWeight.w500),
        ),
        Text(
          userMobile == ""
              ? "Missing Mobile no."
              : "${userCountryCode + userMobile}",
          style: TextStyle(
              fontSize: 14,
              color: userMobile != "" ? Colors.black : Colors.grey,
              fontWeight: FontWeight.w500),
        ),
        Text(
          userEmail == "" ? "Missing Email-ID" : "${userEmail}",
          style: TextStyle(
              fontSize: 14,
              color: userEmail != "" ? Colors.black : Colors.grey,
              fontWeight: FontWeight.w500),
        ),

        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget chooseServiceView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: prefer_const_constructors
        textHeaderWithRightButton(
            title: "Choosed service ",
            btnName: "Change",
            onChangeTap: () {
              Navigator.of(context).pop();
            }),
        const SizedBox(
          height: 10,
        ),
        Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              "${widget.serviceDetail!.service_name}",
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(
              "\$ ${widget.serviceDetail!.service_price}",
              // ignore: prefer_const_constructors
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget textHeaderWithRightButton({title = "", btnName = "", onChangeTap}) {
    return Container(
      height: 25,
      child: Row(
        children: [
          Text(
            "${title}",
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              if (onChangeTap == null) {
                return;
              }
              onChangeTap();
            },
            child: Text(
              "${btnName}",
              style: TextStyle(color: AppColor.applinkColor, fontSize: 16),
            ),
          )
        ],
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
    return dateTF.text.isEmpty
        ? Container()
        : const Text(
            "Time slots are not  available of selected date. Please check on  other date.",
            style: TextStyle(
                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
          );
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
