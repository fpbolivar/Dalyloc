import 'package:daly_doc/pages/createNewTask.dart';
import 'package:daly_doc/widgets/appBar/customAppBar.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/exportPackages.dart';
import '../../widgets/timeWidget/timewidget.dart';

class wakeUpTime extends StatefulWidget {
  String? imagePath;
  Function()? ontap;

  wakeUpTime({this.imagePath, this.ontap});

  @override
  State<wakeUpTime> createState() => _wakeUpTimeState();
}

class _wakeUpTimeState extends State<wakeUpTime> {
  DateTime? _chosenDateTime;
  List time = [
    "1:00",
    "1:30",
    "1:45",
    "1:50",
    "2:00",
  ];

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                padding: const EdgeInsets.only(top: 100),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                    children: <TextSpan>[
                      TextSpan(text: 'What time do you wake Up ?'),
                    ],
                  ),
                )),
            Align(
              child: InkWell(onTap: widget.ontap, child: const TimeWidget()),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateNewTask()),
                );
              },
              child: const Text(
                "Add new task ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
