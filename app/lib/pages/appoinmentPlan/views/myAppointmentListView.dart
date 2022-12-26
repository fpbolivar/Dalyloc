import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/appoinmentPlan/components/appointmentDetailPopup.dart';
import 'package:daly_doc/pages/appoinmentPlan/manager/appointmentApi.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/bookedAppoinmentModel.dart';
import 'package:daly_doc/pages/appoinmentPlan/provider/appointmentProvider.dart';
import 'package:daly_doc/pages/appoinmentPlan/views/lookingForView.dart';

import 'package:daly_doc/pages/paymentPages/singlePaymentView.dart';
import 'package:daly_doc/widgets/noDataWidget/noDataWidget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/components/upcomingAppointmentItemView.dart';

class MyApointmentListView extends StatefulWidget {
  MyApointmentListView({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApointmentListView> createState() => _MyApointmentListViewState();
}

class _MyApointmentListViewState extends State<MyApointmentListView> {
  @override
  void initState() {
    super.initState();

    Constant.appointmentProvider.initialize();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Constant.appointmentProvider.getAppointment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navBarWhite,
      appBar: CustomAppBarPresentCloseButton(
        title: "My Apointment",
        subtitle: "",
        fontSize: 18,
        subfontSize: 20,
        topSubPadding: 3,
        needShadow: false,
        needHomeIcon: false,
        colorNavBar: AppColor.textWhiteColor,
        subtitleColor: AppColor.textGrayBlue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!

          Routes.pushSimple(
              context: context, child: LookingForView(), onBackPress: () {});
        },
        backgroundColor: AppColor.theme,
        child: const Icon(Icons.add),
      ),
      body: BackgroundCurveView(
          color: AppColor.navBarWhite,
          child: SafeArea(
            child: Consumer<AppointmentProvider>(
                builder: (context, object, child) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Constant.appointmentProvider.isLoading
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: loaderList(),
                              )
                            : Constant.appointmentProvider.bookingList.length ==
                                    0
                                ? Expanded(
                                    child: NoDataItemWidget(
                                    refresh: () {
                                      Constant.appointmentProvider
                                          .getAppointment();
                                    },
                                    msg: 'My Appointment bucket is empty.',
                                  ))
                                : Expanded(child: bodyDesign()),
                        const SizedBox(
                          height: 20,
                        ),
                        // CustomButton.regular(
                        //   title: "Submit",
                        //   background: AppColor.theme,
                        //   onTap: () async {},
                        // ),
                        const SizedBox(
                          height: 15,
                        ),
                      ]));
            }),
          )),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SmartRefresher(
        controller: Constant.appointmentProvider.refreshController,
        physics: BouncingScrollPhysics(),
        enablePullDown: true,
        header: MaterialClassicHeader(
          color: Colors.white,
          backgroundColor: AppColor.theme,
        ),
        enablePullUp: false,
        onRefresh: () {
          Constant.appointmentProvider.getAppointment();
        },
        onLoading: () {},
        child: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  listView(),

                  const SizedBox(
                    height: 20,
                  ),

                  //
                ]),
          ),
        ));
  }

  Widget listView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Constant.appointmentProvider.bookingList.length,
      itemBuilder: (conext, index) {
        return InkWell(
            onTap: () {
              // Routes.presentSimple(
              //     context: context,
              //     child: PlanDetailView(
              //       data: freePlan[index],
              //     ));
              //onTap!(itemList[index].section ?? 0, index);
            },
            child: _item(conext, index));
      },
      separatorBuilder: (BuildContext context, int index) {
        // ignore: prefer_const_constructors
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
        );
      },
    );
  }

  Widget _item(BuildContext ctx, int index) {
    return InkWell(
      onTap: () {
        _showMultiSelectServices(
          ctx,
          Constant.appointmentProvider.bookingList[index],
          onCancel: () {
            showConfirmAlertWithBtnName("Do you want to cancel appointment?",
                btnName: "Continue", onTap: () async {
              var status = await AppointmentApi().cancelBooking(
                  Constant.appointmentProvider.bookingList[index].id);
              if (status != null) {
                if (status) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Constant.appointmentProvider.getAppointment();
                }
              }
            });
          },
          onPayNow: () {
            Routes.pushSimple(
                context: context,
                child: SinglePaymentView(
                  appointmentID:
                      Constant.appointmentProvider.bookingList[index].id ?? "",
                  onSuccessPayment: () {
                    Navigator.of(context).pop();
                    Constant.appointmentProvider.getAppointment();
                  },
                ));
          },
          onSubmitRate: (text, rate) {
            print(text);
            print(rate);
            Navigator.of(context).pop();
            setState(() {});
            Constant.appointmentProvider.getAppointment();
          },
        );
        //
      },
      child: UpcomingAppointmentItemView(
        fromUser: true,
        itemData: Constant.appointmentProvider.bookingList[index],
      ),
    );
  }

  void _showMultiSelectServices(
      BuildContext context, BookedAppointmentModel data,
      {onCancel, onPayNow, onSubmitRate}) {
    var isLoadingRating = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (contextt, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,

              // shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.all(Radius.circular(2.0))),
              // insetPadding: EdgeInsets.fromLTRB(25, 0.0, 25.0, 0.0),
              // title: Text('Select Services'),
              // contentPadding: EdgeInsets.only(top: 12.0),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 10,
                      minWidth: MediaQuery.of(context).size.width - 10,
                      maxHeight: MediaQuery.of(context).size.height - 100,
                      minHeight: 200),
                  child: AlertAppointmentDetailPopup(
                    bookedData: data,
                    onCancel: onCancel,
                    onPayNow: onPayNow,
                    isLoadingRating: isLoadingRating,
                    onSubmitRate: (text, rate) async {
                      isLoadingRating = true;
                      setState(() {});
                      await AppointmentApi().submitRating(
                          appointmentID: data.id,
                          service_id: data.serviceList!.first.id,
                          comment: text,
                          rating: rate.toInt());

                      data.is_rating = "1";
                      isLoadingRating = false;
                      setState(() {});
                      onSubmitRate(text, rate);
                    },
                  )),
            );
          });
        });
  }
}
