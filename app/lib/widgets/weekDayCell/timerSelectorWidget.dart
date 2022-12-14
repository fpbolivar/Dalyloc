import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';

import '../../pages/authScreens/authManager/models/businessCatModel.dart';
import '../../utils/exportPackages.dart';

import 'package:intl/intl.dart';

import '../dialogs/CommonDialogs.dart';

class TimeSelectorWidget extends StatefulWidget {
  Function(PickUpDateTime) onChangeStartTime;
  Function(PickUpDateTime) onChangeEndTime;
  Function() onClose;
  WeekDaysModel data;
  TimeSelectorWidget(
      {required this.onChangeStartTime,
      required this.onChangeEndTime,
      required this.data,
      required this.onClose});
  @override
  _TimeSelectorWidgetState createState() => _TimeSelectorWidgetState();
}

class _TimeSelectorWidgetState extends State<TimeSelectorWidget> {
  var startTimeTF = TextEditingController();
  var endTimeTF = TextEditingController();
  PickUpDateTime endSelectedTime = PickUpDateTime();
  PickUpDateTime startSelectedTime = PickUpDateTime();
  @override
  void initState() {
    super.initState();

    dataSet();
  }

  dataSet() {
    print('didChangeDependencies(), counter');
    if (widget.data != null) {
      startSelectedTime = widget.data.startime!;
      endSelectedTime = widget.data.endtime!;
      print(
          "widget.data.startime ${widget.data.startime!.timeStr} . ${widget.data.name}");
      print("widget.data.endtime ${widget.data.endtime!.timeStr}");
    }
    startTimeTF.text = startSelectedTime.timeStr;
    endTimeTF.text = endSelectedTime.timeStr;
    widget.onChangeStartTime(startSelectedTime);
    widget.onChangeEndTime(endSelectedTime);
  }

  @override
  Widget build(BuildContext context) {
    dataSet();
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              if (widget.data.selected == false) {
                showAlert("Select Week Days");
                return;
              }
              if (startTimeTF.text.isEmpty) {
                var timeFinal = DateFormat("HH:mm").format(DateTime.now());
                setState(() {
                  // startSelectedTime.timeStr = timeFinal;
                  startTimeTF = TextEditingController(text: timeFinal);
                  // widget.data.startime!.pickupTime = timeFinal.toString();
                });
                widget.onChangeStartTime(startSelectedTime);
              }
              TimeOfDay? picked = await timePickerAlert(context);
              print(picked);
              if (picked != null) {
                var time = picked.format(context);
                if (Constant.HRS24FORMAT) {
                  time = TaskManager().timeObj12to24Str(time);
                }

                print("time $time");
                setState(() {
                  startSelectedTime.timeStr = time;
                  startTimeTF = TextEditingController(text: time);
                  // widget.data.startime!.pickupTime = timeFinal.toString();
                });
                widget.onChangeStartTime(startSelectedTime);
              }
              // alertTimePicker(context, initialTime: startSelectedTime.time,
              //     onSelected: (picked) {
              //   if (picked != null) {
              //     var timeFinal = DateFormat("HH:mm").format(picked);
              //     print(DateFormat("HH:mm").format(picked));
              //     setState(() {
              //       startSelectedTime.timeStr = timeFinal;
              //       startTimeTF = TextEditingController(text: timeFinal);
              //       // widget.data.startime!.pickupTime = timeFinal.toString();
              //     });
              //     widget.onChangeStartTime(startSelectedTime);
              //   }
              // }, onClose: () {
              //   widget.onClose();
              // });
            },
            child: writeReview(
                maxLine: 1,
                minLine: 1,
                textController: startTimeTF,
                enabled: false,
                title: "Start Time",
                placeholder: "Start Time"),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () async {
              if (widget.data.selected == false) {
                showAlert("Select Week Days");
                return;
              }
              if (endTimeTF.text.isEmpty) {
                var timeFinal = DateFormat("HH:mm").format(DateTime.now());
                setState(() {
                  // endSelectedTime.timeStr = timeFinal;
                  endTimeTF = TextEditingController(text: timeFinal);
                });
                widget.onChangeEndTime(endSelectedTime);
              }
              TimeOfDay? picked = await timePickerAlert(context);
              print(picked);
              if (picked != null) {
                var time = picked.format(context);
                if (Constant.HRS24FORMAT) {
                  time = TaskManager().timeObj12to24Str(time);
                }

                print("time $time");
                setState(() {
                  endSelectedTime.timeStr = time;
                  endTimeTF = TextEditingController(text: time);
                  // widget.data.startime!.pickupTime = timeFinal.toString();
                });
                widget.onChangeStartTime(startSelectedTime);
              }
              // alertTimePicker(context, initialTime: endSelectedTime.time,
              //     onSelected: (picked) {
              //   if (picked != null) {
              //     var timeFinal = DateFormat("HH:mm").format(picked);
              //     print(DateFormat("HH:mm").format(picked));
              //     setState(() {
              //       endSelectedTime.timeStr = timeFinal;
              //       endTimeTF = TextEditingController(text: timeFinal);
              //     });
              //     widget.onChangeEndTime(endSelectedTime);
              //   }
              // }, onClose: () {
              //   widget.onClose();
              // });
            },
            child: writeReview(
                maxLine: 1,
                minLine: 1,
                textController: endTimeTF,
                enabled: false,
                title: "End Time",
                placeholder: "End Time"),
          ),
        ),
      ],
    );
  }

  Widget writeReview(
      {maxLine = 5,
      minLine = 5,
      title = "",
      textController,
      enabled = true,
      keybordType = TextInputType.text,
      onChange,
      placeholder = "Description"}) {
    return Container(
      //color: Colors.white,
      width: 100,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(title),
            ),
            TextField(
              style: TextStyle(fontSize: 18, color: Colors.black),
              minLines: minLine,
              maxLines: maxLine,
              autocorrect: false,
              controller: textController,
              keyboardType: keybordType,
              onChanged: (text) {
                onChange(text);
              },
              decoration: InputDecoration(
                hintText: placeholder,
                contentPadding: EdgeInsets.only(top: 4, left: 5),
                hintStyle: TextStyle(fontSize: 10, color: Colors.black),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(width: 0.5, color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(width: 0.5, color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              enabled: enabled,
            ),
          ],
        ),
      ),
    );
  }
}
