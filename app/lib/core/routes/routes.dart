import 'package:flutter/cupertino.dart';
import '../../utils/exportPackages.dart';

class Routes {
  static gotoLogin(BuildContext context, {Map<String, dynamic>? data}) async {}
  static pushSimple(
      {required BuildContext context,
      required Widget child,
      Function(String)? onBackPress}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => child),
    );

    // Navigator.of(context)
    //     .push(CupertinoPageRoute(builder: (context) => child))
    //     .then((value) {
    //   if (onBackPress != null) {
    //     onBackPress(value);
    //   }
    // });
  }
}
