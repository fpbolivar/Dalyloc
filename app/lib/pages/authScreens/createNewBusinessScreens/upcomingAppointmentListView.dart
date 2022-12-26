import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/appoinmentPlan/components/appointmentDetailPopup.dart';
import 'package:daly_doc/pages/appoinmentPlan/manager/appointmentApi.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/bookedAppoinmentModel.dart';
import 'package:daly_doc/pages/appoinmentPlan/provider/bizAppointmentProvider.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/components/alertAcceptRejectView.dart';

import 'package:daly_doc/widgets/noDataWidget/noDataWidget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/components/upcomingAppointmentItemView.dart';

class UpcomingApointmentListView extends StatefulWidget {
  UpcomingApointmentListView({
    Key? key,
  }) : super(key: key);

  @override
  State<UpcomingApointmentListView> createState() =>
      _UpcomingApointmentListViewState();
}

class _UpcomingApointmentListViewState
    extends State<UpcomingApointmentListView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Constant.bizAppointmentProvider.getAppointment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navBarWhite,
      appBar: CustomAppBarPresentCloseButton(
        title: "Apointment",
        subtitle: "List",
        fontSize: 18,
        subfontSize: 20,
        topSubPadding: 3,
        needShadow: false,
        needHomeIcon: false,
        colorNavBar: AppColor.textWhiteColor,
        subtitleColor: AppColor.textGrayBlue,
      ),
      body: BackgroundCurveView(
          color: AppColor.navBarWhite,
          child: SafeArea(
            child: Consumer<BizAppointmentProvider>(
                builder: (context, object, child) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Constant.bizAppointmentProvider.isLoading
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: loaderList(),
                              )
                            : Constant.bizAppointmentProvider.bookingList
                                        .length ==
                                    0
                                ? Expanded(
                                    child: NoDataItemWidget(
                                    refresh: () {
                                      Constant.bizAppointmentProvider
                                          .getAppointment();
                                    },
                                    msg: 'Appointment bucket is empty.',
                                  ))
                                : Expanded(child: bodyDesign()),
                        // const SizedBox(
                        //   height: 20,
                        // ),
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
        controller: Constant.bizAppointmentProvider.refreshController,
        physics: BouncingScrollPhysics(),
        enablePullDown: true,
        header: MaterialClassicHeader(
          color: Colors.white,
          backgroundColor: AppColor.theme,
        ),
        enablePullUp: false,
        onRefresh: () {
          Constant.bizAppointmentProvider.getAppointment();
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
      itemCount: Constant.bizAppointmentProvider.bookingList.length,
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
            ctx, Constant.bizAppointmentProvider.bookingList[index],
            onCancel: () {
          showConfirmAlertWithBtnName("Do you want to cancel appointment?",
              btnName: "Continue", onTap: () async {
            var status = await AppointmentApi().cancelBooking(
                Constant.bizAppointmentProvider.bookingList[index].id);
            if (status != null) {
              if (status) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Constant.bizAppointmentProvider.getAppointment();
              }
            }
          });
        }, onReject: () async {
          var status = await AppointmentApi().rejectBooking(
              Constant.bizAppointmentProvider.bookingList[index].id);
          if (status != null) {
            if (status) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Constant.bizAppointmentProvider.getAppointment();
            }
          }
        }, onAccept: () async {
          var status = await AppointmentApi().acceptBooking(
              Constant.bizAppointmentProvider.bookingList[index].id);
          if (status != null) {
            if (status) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Constant.bizAppointmentProvider.getAppointment();
            }
          }
        }, onComplete: () async {
          var status = await AppointmentApi().completeBooking(
              Constant.bizAppointmentProvider.bookingList[index].id);
          if (status != null) {
            if (status) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Constant.bizAppointmentProvider.getAppointment();
            }
          }
        }, onAskForPayment: () async {
          var status = await AppointmentApi().askForPayment(
              Constant.bizAppointmentProvider.bookingList[index].id);
          if (status != null) {
            if (status) {
              // Navigator.of(context).pop();
              // Navigator.of(context).pop();
              // getAppointment();
            }
          }
        });
        //  Routes.pushSimple(context: context, child: ViewServiceOfBusiness());
      },
      child: UpcomingAppointmentItemView(
        itemData: Constant.bizAppointmentProvider.bookingList[index],
      ),
    );
  }

  void _showMultiSelectServices(
      BuildContext context, BookedAppointmentModel data,
      {onCancel, onAccept, onReject, onComplete, onAskForPayment}) {
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
                  child: AlertAcceptRejetView(
                      bookedData: data,
                      onAccept: onAccept,
                      onReject: onReject,
                      onCancel: onCancel,
                      onAskForPayment: onAskForPayment,
                      onComplete: onComplete)),
            );
          });
        });
  }
}
