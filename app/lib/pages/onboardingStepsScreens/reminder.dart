import 'package:daly_doc/utils/exportScreens.dart';
import 'package:daly_doc/utils/exportWidgets.dart';

import '../../utils/exportPackages.dart';

class Reminder extends StatelessWidget {
  String? imagePath, title, desc;

  Reminder({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(gradient: GradientColor.getGradient()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 70),
            child: Text(
              "Daly Doc",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 50,
                  color: Colors.white),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Would you like to keep reminders about task ? '),
                  ],
                ),
              )),
          Image.asset(
            imagePath!,
            height: 250,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            title: "Allow",
            height: 50,
            width: 250,
            radius: 30,
            shadow: true,
            onTap: () {
              //print(imagePath!);
              Routes.pushSimple(context: context, child: CalendarEventScreen());
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Routes.pushSimple(
                  context: context, child: ScheduleOptionScreen());
            },
            child: Text(
              "Skip",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
