import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/excercisePlan/excercisePlanScreen.dart';
import 'package:daly_doc/pages/excercisePlan/exercisePlanMainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../pages/pagesGetStarted/introduction_animation_screen.dart';
import '../../utils/exportPackages.dart';
import '../localStore/localStore.dart';

class Routes {
  static gotoLogin(
    BuildContext context, {
    Map<String, dynamic>? data,
  }) async {}
  static pushSimple({
    required BuildContext context,
    required Widget child,
    Function()? onBackPress,
  }) {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => WillPopScope(
                child: child,
                onWillPop: () async {
                  if (Navigator.of(context).userGestureInProgress) {
                    return false;
                  } else {
                    return true;
                  }
                },
              ),
          settings: RouteSettings(name: child.runtimeType.toString())),
    ).then((value) => {onBackPress!()});

    // Navigator.of(context)
    //     .push(CupertinoPageRoute(builder: (context) => child))
    //     .then((value) {
    //   if (onBackPress != null) {
    //     onBackPress(value);
    //   }
    // });
  }

  static pushSimpleRootNav({
    required BuildContext context,
    required Widget child,
    Function(String)? onBackPress,
  }) {
    Navigator.of(context).push(
      CupertinoPageRoute(
          builder: (context) => WillPopScope(
                child: child,
                onWillPop: () async {
                  if (Navigator.of(context).userGestureInProgress) {
                    return false;
                  } else {
                    return true;
                  }
                },
              ),
          settings: RouteSettings(name: child.runtimeType.toString())),
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
    return ScheduleCalendarScreen();

    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) {
    //       var taskProvider = Constant.taskProvider;

    //       return taskProvider;
    //     }),
    //     // ChangeNotifierProvider(create: (_) => TaskManager()),
    //   ],
    //   child: ScheduleCalendarScreen(),
    // );
  }

  static presentSimple(
      {required BuildContext context,
      required Widget child,
      Function(String)? onBackPress}) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => child, fullscreenDialog: true),
    ).then((value) {
      if (onBackPress != null) {
        onBackPress(value);
      }
    });

    // Navigator.of(context)
    //     .push(CupertinoPageRoute(builder: (context) => child))
    //     .then((value) {
    //   if (onBackPress != null) {
    //     onBackPress(value);
    //   }
    // });
  }

  static gotoExerciseFlow({
    required BuildContext context,
  }) async {
    var value = await LocalStore().getExerciseIntro();
    Widget child = Container();
    if (value == '') {
      child = ExcercisePlanScreen();
    } else {
      child = ExcercisePlanMainScreen(); //ExcercisePlanMainScreen();
    }
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => WillPopScope(
                child: child,
                onWillPop: () async {
                  if (Navigator.of(context).userGestureInProgress) {
                    return false;
                  } else {
                    return true;
                  }
                },
              ),
          settings: RouteSettings(name: child.runtimeType.toString())),
    );
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

  static gotoMainScreen() async {
    await LocalStore().setToken("");
    Routes.pushSimpleAndReplaced(
        context: Constant.navigatorKey.currentState!.context,
        child: IntroductionAnimationScreen());
  }

  static gotoHomeScreen() async {
    Routes.pushSimpleAndReplaced(
        context: Constant.navigatorKey.currentState!.context,
        child: ScheduleCalendarScreen());
  }
}
