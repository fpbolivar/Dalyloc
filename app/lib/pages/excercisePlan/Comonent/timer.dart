import 'dart:async';

import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TimerWidget extends StatefulWidget {
  int? time = 0;
  TimerWidget({
    this.time,
    Key? key,
  }) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  String state = 'Animation start';
  double percent = 0;
  int time = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    setState(() {
      time = widget.time!;
    });
  }

  _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      int timetemp = widget.time!;
      double add = 0;
      setState(() {
        if (timetemp == 30) {
          percent += 100 / timetemp + 0.1;
        } else {
          percent += 100 / timetemp;
        }
        time -= 1;

        if (percent >= 100) {
          timer.cancel();
          percent = 0;
          time = timetemp;
          print("objectobject");
        }
      });
      print(percent);
      print(time);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("objectobjectobjectobject");
        _startTimer();
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.timerbg, borderRadius: BorderRadius.circular(75)),
        child: CircularPercentIndicator(
          radius: 75.0,
          lineWidth: 6.0,
          animation: true,
          animationDuration: 3000,
          backgroundColor: AppColor.weightScrollColor,
          percent: percent / 100,
          animateFromLastPercent: true,
          center: Text(
            time.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: AppColor.timerbg,
        ),
      ),
    );
  }
}
