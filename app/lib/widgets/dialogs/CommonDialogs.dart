import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/exportPackages.dart';

alertTimePicker(BuildContext context,
    {TimeOfDay? initialTime,
    onSelected,
    heading = "Select time",
    onClose}) async {
  print("_selectDate");
  var now = DateTime.now();
  var today = new DateTime(now.year, now.month, now.day, now.hour, 0);
  showCupertinoModalPopup(
      context: context,
      builder: (_) => Material(
            child: Container(
                height: 260,
                child: Column(
                  children: [
                    Container(child: Text(heading), color: Colors.white),
                    Expanded(
                      child: Container(
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: CupertinoDatePicker(
                              // minimumDate: DateTime.now().add(Duration(days: 1)),
                              mode: CupertinoDatePickerMode.time,
                              use24hFormat: true,
                              minuteInterval: 10,
                              initialDateTime: today,
                              // minuteInterval: 30,
                              //initialDateTime: DateTime.now().add(Duration(days: 1)),
                              onDateTimeChanged: (picked) {
                                onSelected(picked);
                              })),
                    )
                  ],
                )),
          )).then((value) {
    print("CLOSES");
    if (onClose != null) {
      onClose();
    }
  });
  //DateTime selectedDate = DateTime.now();
  // final TimeOfDay picked = await showTimePicker(
  //   initialEntryMode: TimePickerEntryMode.dial,
  //   context: context,
  //   initialTime: initialTime,
  //   builder: (BuildContext context, Widget child) {
  //     return MediaQuery(
  //       data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
  //       child: child,
  //     );
  //   },
  // );

  // onSelected(picked);
}

showLocationSelection(msg, context,
    {bool pop = false, Function(String)? onSelection}) {
  var alert = AlertDialog(
    title: Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          TextButton(
            child: new Text(
              "Automatic",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onSelection!("Automatic");
            },
          ),
          SizedBox(
            height: 5,
          ),
          TextButton(
            child: new Text(
              "Manually",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onSelection!("Manually");
            },
          ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

showAlert(msg,
    {bool pop = false,
    VoidCallback? onTap,
    barrierDismiss = false,
    String btnName = "OK"}) {
  var alert = AlertDialog(
    title: Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(msg)
        ],
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
    actions: <Widget>[
      Center(
        child: new CustomButton.regular(
          title: btnName,
          onTap: () {
            Navigator.of(Constant.navigatorKey.currentState!.overlay!.context)
                .pop();
            if (onTap != null) {
              onTap();
            }
          },
        ),
      ),
    ],
  );

  showDialog(
      barrierDismissible: false, //barrierDismiss,
      context: Constant.navigatorKey.currentState!.overlay!.context,
      builder: (BuildContext context) {
        return alert;
      });
}
//part of commons;

dismissWaitDialog() {
  var context = Constant.navigatorKey.currentState!.overlay!.context;

  if (LocalString.isRunningLoader) {
    LocalString.isRunningLoader = false;
    Navigator.of(context).pop();
  }
}

showErrorAlert(error, {context, bool pop = false, VoidCallback? onTap}) {
  var alert = AlertDialog(
    title: Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text('Something went wrong.Please try again later.')
        ],
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
    actions: <Widget>[
      // usually buttons at the bottom of the dialog

      new ElevatedButton(
        child: new Text(
          "OK",
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          Navigator.of(Constant.navigatorKey.currentState!.overlay!.context)
              .pop();
          if (onTap != null) {
            onTap();
          }
        },
      ),
    ],
  );

  showDialog(
      barrierDismissible: false,
      context: Constant.navigatorKey.currentState!.overlay!.context,
      builder: (BuildContext context) {
        return alert;
      });
}

shadowOnView(Widget view) {
  return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: view);
}

waitDialog({message = "   Please wait...", Duration? duration}) {
  var context = Constant.navigatorKey.currentState!.overlay!.context;

  LocalString.isRunningLoader = true;
  var dialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    elevation: 0.0,
    backgroundColor: Theme.of(context).dialogBackgroundColor,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              child: CircularProgressIndicator(
                strokeWidth: 2,
              )),
          Text(message),
        ],
      ),
    ),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => WillPopScope(onWillPop: () async => false, child: dialog),
  );

  if (duration != null) {
    Future.delayed(
      duration,
      () {
        Navigator.of(context).pop();
      },
    );
  }
}
