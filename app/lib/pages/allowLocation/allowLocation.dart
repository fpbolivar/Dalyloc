import 'package:daly_doc/pages/authScreens/authManager/api/getUserDetails.dart';
import 'package:daly_doc/pages/notificationScreen/components/sectionRowlistView.dart';
import 'package:daly_doc/pages/notificationScreen/model/SectionItemModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/wakeUptimeView/wakeupTimeView.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

class AllowLocationScreen extends StatefulWidget {
  String? red;
  AllowLocationScreen({Key? key, this.red}) : super(key: key);

  @override
  State<AllowLocationScreen> createState() => _AllowLocationScreenState();
}

class _AllowLocationScreenState extends State<AllowLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarWithBackButton(
        title: "Allow Location",
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
              child: Image.asset(
                'assets/icons/ic_allowLocation.png',
                fit: BoxFit.contain,
                // height: 170,
                width: MediaQuery.of(context).size.width - 100,
              ),
            ),
            Spacer(),
            CustomButton.regular(
              title: "Allow",
              onTap: () {
                Routes.pushSimple(
                    context: context, child: WakeUpTimeViewScreen());
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton.regular(
              title: "Skip",
              onTap: () {
                Routes.pushSimple(
                    context: context, child: WakeUpTimeViewScreen());
              },
              titleColor: AppColor.theme,
              background: Colors.transparent,
            ),
            const SizedBox(
              height: 50,
            ),
            //
          ]),
    );
  }
}
