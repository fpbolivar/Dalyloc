import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/bookingLinkScreen.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/timeSlotsAvailabilty.dart';
import 'package:daly_doc/pages/settingsScreen/components/sectionRowListView.dart';
import 'package:daly_doc/pages/settingsScreen/model/SettingOption.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportScreens.dart';
import '../../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

class DevotionalPlanSetting extends StatefulWidget {
  String? red;
  DevotionalPlanSetting({
    Key? key,
    this.red,
  }) : super(key: key);

  @override
  State<DevotionalPlanSetting> createState() => _DevotionalPlanSettingState();
}

class _DevotionalPlanSettingState extends State<DevotionalPlanSetting> {
  bool getData = false;
  bool borderEnable = true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  List<SettingOption> onlineItemOption = [
    SettingOption(title: "Notifications", section: 0, type: SettingType.toggle),
  ];

  List<SettingOption> businessOption = [
    SettingOption(title: " Daily", section: 1, type: SettingType.counter),
    SettingOption(
        title: "Business details", section: 1, type: SettingType.time),
    SettingOption(
        title: LocalString.lblServiceDetail,
        section: 1,
        type: SettingType.time),
  ];

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
                    // rowIndex == 0
                    //     ? Routes.pushSimple(
                    //         context: context,
                    //         child: (

                    //         ))
                    //     : Routes.pushSimple(
                    //         context: context,
                    //         child: TimeSlotsAvailabiltyScreens());
                  }),
              const SizedBox(
                height: 20,
              ),
            ]),
      ),
    );
  }
}
