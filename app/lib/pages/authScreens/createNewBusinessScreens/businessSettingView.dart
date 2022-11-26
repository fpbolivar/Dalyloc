import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/bookingLinkScreen.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/serviceListScreen.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/timeSlotsAvailabilty.dart';
import 'package:daly_doc/pages/settingsScreen/components/sectionRowListView.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportScreens.dart';
import '../../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

import '../authManager/models/businessCatModel.dart';
import '../authManager/models/userBusinesModel.dart';
import '../createNewbusinessScreens/createNewBusiness.dart';
import 'createNewBusinessService.dart';
import 'depositsScreen.dart';

class BusinessSettingView extends StatefulWidget {
  String? red;
  BusinessSettingView(
      {Key? key, this.red, this.UserBusinessData, this.weekDays})
      : super(key: key);
  UserBusinessModel? UserBusinessData;
  List<WeekDaysModel>? weekDays;

  @override
  State<BusinessSettingView> createState() => _BusinessSettingViewState();
}

class _BusinessSettingViewState extends State<BusinessSettingView> {
  bool getData = false;
  bool borderEnable = true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getOnlinePaymentStatus();
    });
  }

  List<SettingOption> onlineItemOption = [
    SettingOption(
        title: "Online booking", section: 0, type: SettingType.toggle),
  ];

  List<SettingOption> businessOption = [
    SettingOption(
      title: "Booking link",
      section: 1,
    ),
    SettingOption(title: "Business details", section: 1),
    SettingOption(title: "Business timing", section: 1),
  ];
  List<SettingOption> businessServiceOption = [
    SettingOption(
      title: LocalString.lblServiceDetail,
      section: 1,
    ),
  ];
  List<SettingOption> paymentOption = [
    SettingOption(
        title: "Activate payment ", section: 2, type: SettingType.toggle),
    SettingOption(title: "Deposits ", section: 2),
  ];
  List<SettingOption> businessOtherOption = [
    SettingOption(title: "Booking acceptance", section: 3),
    SettingOption(title: "Time slots availabilty", section: 3),
  ];
  getOnlinePaymentStatus() async {
    bool? status = await BusinessApis().getOnlinePaymentStatus();
    if (status == null || status == false) {
      onlineItemOption[0].value = false;
    } else {
      onlineItemOption[0].value = true;
    }
    setState(() {});
  }

  updateOnlinePaymentStatus(String value) async {
    bool? status = await BusinessApis()
        .getOnlinePaymentStatus(needUpdate: true, value: value);
    if (status == null || status == false) {
      onlineItemOption[0].value = false;
    } else {
      onlineItemOption[0].value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarWithBackButton(
        title: LocalString.lblBizSettingNavTitle,
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: bodyDesign(),
        ),
      )),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: onlineItemOption,
                  borderEnable: borderEnable,
                  onSelectionBool: ((boolValue, p1, p2) {
                    onlineItemOption[p2].value = boolValue;
                    setState(() {});
                    updateOnlinePaymentStatus(boolValue == true ? "1" : "0");
                  }),
                  onTap: (sectionIndex, rowIndex) {
                    switch (rowIndex) {
                      case 0:
                        break;
                      case 1:
                        break;

                      default:
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: businessOption,
                  onTap: (sectionIndex, rowIndex) {
                    rowIndex == 0
                        ? Routes.pushSimple(
                            context: context, child: BookingLinkScreen())
                        : rowIndex == 1
                            ? Routes.pushSimple(
                                context: context,
                                child: CreateNewBusinessScreen(
                                  update: true,
                                  userBusinessData: widget.UserBusinessData,
                                  weekDays: widget.weekDays,
                                ))
                            : Routes.pushSimple(
                                context: context,
                                child: CreateNewBusinessScreen(
                                  userBusinessData: widget.UserBusinessData,
                                  timing: true,
                                  weekDays: widget.weekDays,
                                ));
                  }),
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: businessServiceOption,
                  onTap: (sectionIndex, rowIndex) {
                    Routes.pushSimple(
                        context: context,
                        child: CreateNewBusinessServiceScreen(
                          update: true,
                        ));
                  }),
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: paymentOption,
                  onSelectionBool: ((boolValue, p1, p2) {
                    paymentOption[p2].value = boolValue;
                    setState(() {});
                  }),
                  onTap: (sectionIndex, rowIndex) {
                    if (rowIndex == 1) {
                      Routes.pushSimple(
                          context: context, child: DepositScreens());
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              SectionRowListView(
                  itemList: businessOtherOption,
                  onTap: (sectionIndex, rowIndex) {
                    rowIndex == 0
                        ? Routes.pushSimple(
                            context: context,
                            child: TimeSlotsAvailabiltyScreens(
                              timeSlotsAvailabilty: false,
                            ))
                        : Routes.pushSimple(
                            context: context,
                            child: TimeSlotsAvailabiltyScreens());
                  }),
              const SizedBox(
                height: 20,
              ),
            ]),
      ),
    );
  }
}
