import 'package:daly_doc/utils/exportWidgets.dart';

import '../utils/exportPackages.dart';

class ScheduleOptionScreen extends StatefulWidget {
  ScheduleOptionScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleOptionScreen> createState() => _ScheduleOptionScreenState();
}

class _ScheduleOptionScreenState extends State<ScheduleOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.curveViewBgColor, body: bodyDesign());
  }

  //METHOD: - BodyDesign
  Widget bodyDesign() {
    return BackgroundCurveView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  BackButton(),
            CustomBackButton(),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                LocalString.lblChooseSchedule,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ScheduleOptionCardView(
                    height: 130,
                    title: LocalString.lblSendEmail,
                    icon: Icons.mail,
                  ),
                  ScheduleOptionCardView(
                    height: 130,
                    title: LocalString.lblSendText,
                    icon: Icons.message_outlined,
                  )
                ]),
            const SizedBox(
              height: 40,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ScheduleOptionCardView(
                    height: 130,
                    title: LocalString.lblCopyLink,
                    icon: Icons.copy_outlined,
                  ),
                  ScheduleOptionCardView(
                    height: 130,
                    title: LocalString.lblBookInterView,
                    icon: Icons.date_range_outlined,
                  ),
                ]),
            const SizedBox(
              height: 50,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  title: LocalString.lblSend,
                  onTap: () {
                    print("send");
                  },
                  titleColor: Colors.black,
                  background: Colors.white,
                  height: 50,
                  radius: 30,
                  width: 250,
                ))
          ]),
    );
  }
}
