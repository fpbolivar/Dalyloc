import 'package:daly_doc/core/constant/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../utils/exportPackages.dart';

class Routes {
  static gotoLogin(BuildContext context, {Map<String, dynamic>? data}) async {}
  static pushSimple(
      {required BuildContext context,
      required Widget child,
      Function(String)? onBackPress}) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => child),
    );

    // Navigator.of(context)
    //     .push(CupertinoPageRoute(builder: (context) => child))
    //     .then((value) {
    //   if (onBackPress != null) {
    //     onBackPress(value);
    //   }
    // });
  }

  static Widget setScheduleScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          var taskProvider = Constant.taskProvider;

          return taskProvider;
        }),
        // ChangeNotifierProvider(create: (_) => TaskManager()),
      ],
      child: ScheduleCalendarScreen(),
    );
  }

  static presentSimple(
      {required BuildContext context,
      required Widget child,
      Function(String)? onBackPress}) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => child, fullscreenDialog: true),
    );

    // Navigator.of(context)
    //     .push(CupertinoPageRoute(builder: (context) => child))
    //     .then((value) {
    //   if (onBackPress != null) {
    //     onBackPress(value);
    //   }
    // });
  }

  static pushSimpleAndReplaced(
      {required BuildContext context,
      required Widget child,
      Function(String)? onBackPress}) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => child),
    );
  }
}
