import 'package:daly_doc/pages/notificationScreen/components/sectionRowlistView.dart';
import 'package:daly_doc/pages/notificationScreen/model/SectionItemModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

class WakeUpTimeViewScreen extends StatefulWidget {
  String? red;
  WakeUpTimeViewScreen({Key? key, this.red}) : super(key: key);

  @override
  State<WakeUpTimeViewScreen> createState() => _WakeUpTimeViewScreenState();
}

class _WakeUpTimeViewScreenState extends State<WakeUpTimeViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarWithBackButton(
        title: "What time do you wake up?",
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
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newDateTime) {
                  // var newTod = TimeOfDay.fromDateTime(newDateTime);
                  // _updateTimeFunction(newTod);
                },
                use24hFormat: false,
                minuteInterval: 1,
              ),
            ),
            Spacer(),
            CustomButton.regular(
              title: "Set WakeUp Time",
              onTap: () {
                Routes.pushSimple(
                    context: context, child: Routes.setScheduleScreen());
              },
            ),
            const SizedBox(
              height: 50,
            ),
            //
          ]),
    );
  }
}
