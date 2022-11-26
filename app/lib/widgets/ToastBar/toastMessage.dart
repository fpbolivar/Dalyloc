import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/utils/exportPackages.dart';

import 'flushbar.dart';

class ToastMessage {
  static bool isShow = false;
  static showMessage({msg = ""}) {
    // if (ToastMessage.isShow) {
    //   Navigator.of(Constant.navigatorKey.currentState!.context).pop();
    // }
    return Flushbar(
      title: LocalString.lblDalyDoc,
      message: msg,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(6.0),
      borderRadius: BorderRadius.circular(12),
      flushbarStyle: FlushbarStyle.FLOATING,
      leftBarIndicatorColor: Colors.red[300],
      backgroundGradient: LinearGradient(colors: [Colors.blue, Colors.teal]),
      backgroundColor: Colors.red,
      // onStatusChanged: ((status) {
      //   print(status);
      //   ToastMessage.isShow = true;
      //   if (status == FlushbarStatus.DISMISSED) {
      //     ToastMessage.isShow = false;
      //   }
      // }),
      boxShadows: [
        BoxShadow(
          color: Colors.blue[800]!,
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
    )..show(Constant.navigatorKey.currentState!.context);
  }

  static showSuccessMessage(
      {msg = "",
      Color color = Colors.green,
      Color leftColor = Colors.black87}) {
    // if (ToastMessage.isShow) {
    //   Navigator.of(Constant.navigatorKey.currentState!.context).pop();
    // }
    return Flushbar(
      title: LocalString.lblDalyDoc,
      message: msg,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(6.0),
      borderRadius: BorderRadius.circular(12),
      flushbarStyle: FlushbarStyle.FLOATING,
      leftBarIndicatorColor: leftColor == null ? Colors.black87 : leftColor,
      //  backgroundGradient: LinearGradient(colors: [Colors.blue, Colors.teal]),
      backgroundColor: color == null ? Colors.green : color,
      // onStatusChanged: ((status) {
      //   print(status);
      //   ToastMessage.isShow = true;
      //   if (status == FlushbarStatus.DISMISSED) {
      //     ToastMessage.isShow = false;
      //   }
      // }),
      // boxShadows: [
      //   BoxShadow(
      //     color: Colors.blue[800]!,
      //     offset: Offset(0.0, 2.0),
      //     blurRadius: 3.0,
      //   )
      // ],
    )..show(Constant.navigatorKey.currentState!.context);
  }

  static deletedTaskToast({msg = "", OnTap}) {
    if (ToastMessage.isShow) {
      Navigator.of(Constant.navigatorKey.currentState!.context).pop();
    }
    return Flushbar(
      title: LocalString.lblDalyDoc,
      message: msg,

      //duration: Duration(seconds: 3600),
      messageColor: Colors.black,
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(6.0),
      borderRadius: BorderRadius.circular(12),
      flushbarStyle: FlushbarStyle.FLOATING,
      titleColor: Colors.black,
      mainButton: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          color: Colors.transparent,
          width: 100,
          height: 30,
          child: CustomButton.regular(
            title: "Continue",
            fontSize: 15,
            onTap: () {
              Navigator.of(Constant.navigatorKey.currentState!.context).pop();
              OnTap();
            },
          ),
        ),
      ),
      leftBarIndicatorColor: Colors.red,
      //  backgroundGradient: LinearGradient(colors: [Colors.blue, Colors.teal]),
      backgroundColor: Color(0xFFf7d2d2),
      onStatusChanged: ((status) {
        print(status);
        ToastMessage.isShow = true;
        if (status == FlushbarStatus.DISMISSED) {
          ToastMessage.isShow = false;
        }
      }),
      // boxShadows: [
      //   BoxShadow(
      //     color: Colors.blue[800]!,
      //     offset: Offset(0.0, 2.0),
      //     blurRadius: 3.0,
      //   )
      // ],
    )..show(Constant.navigatorKey.currentState!.context);
  }

  static confrimationToast({msg = "", OnTap}) {
    if (ToastMessage.isShow) {
      Navigator.of(Constant.navigatorKey.currentState!.context).pop();
    }
    return Flushbar(
      title: LocalString.lblDalyDoc,
      message: msg,
      //duration: Duration(seconds: 3600),

      messageColor: Colors.black,
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(6.0),
      borderRadius: BorderRadius.circular(12),
      flushbarStyle: FlushbarStyle.FLOATING,
      titleColor: Colors.black,
      mainButton: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          color: Colors.transparent,
          width: 100,
          height: 30,
          child: CustomButton.regular(
            title: "Continue",
            fontSize: 15,
            onTap: () {
              Navigator.of(Constant.navigatorKey.currentState!.context).pop();
              OnTap();
            },
          ),
        ),
      ),
      leftBarIndicatorColor: Colors.red,
      //  backgroundGradient: LinearGradient(colors: [Colors.blue, Colors.teal]),
      backgroundColor: Color(0xFFf7d2d2),
      onStatusChanged: ((status) {
        print(status);
        ToastMessage.isShow = true;
        if (status == FlushbarStatus.DISMISSED) {
          ToastMessage.isShow = false;
        }
      }),
      // boxShadows: [
      //   BoxShadow(
      //     color: Colors.blue[800]!,
      //     offset: Offset(0.0, 2.0),
      //     blurRadius: 3.0,
      //   )
      // ],
    )..show(Constant.navigatorKey.currentState!.context);
  }
}
