import 'package:daly_doc/utils/exportWidgets.dart';

import '../../utils/exportPackages.dart';

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
            Navigator.of(
                    LocalString.navigatorKey.currentState!.overlay!.context)
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
      context: LocalString.navigatorKey.currentState!.overlay!.context,
      builder: (BuildContext context) {
        return alert;
      });
}
//part of commons;

dismissWaitDialog() {
  var context = LocalString.navigatorKey.currentState!.overlay!.context;

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
          Navigator.of(LocalString.navigatorKey.currentState!.overlay!.context)
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
      context: LocalString.navigatorKey.currentState!.overlay!.context,
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
  var context = LocalString.navigatorKey.currentState!.overlay!.context;

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
