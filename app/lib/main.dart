import 'dart:io';

import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/pagesGetStarted/introduction_animation_screen.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/exportPackages.dart';
import 'core/Sql/DBIntializer.dart';
import 'pages/onboardingScreen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'widgets/floatingActionButton/flutter_speed_dial.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const DalyDocApp());
}

class DalyDocApp extends StatefulWidget {
  const DalyDocApp({super.key});

  @override
  State<DalyDocApp> createState() => _DalyDocAppState();
}

class _DalyDocAppState extends State<DalyDocApp> {
  // This widget is the root of your application.
  String token = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //DBIntializer.sharedInstance.initDb();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      token = await LocalStore().getToken();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = ValueNotifier(ThemeMode.dark);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          var taskProvider = Constant.taskProvider;

          return taskProvider;
        }),
        ChangeNotifierProvider(create: (_) {
          var mealProvider = Constant.mealProvider;

          return mealProvider;
        }),
        ChangeNotifierProvider(create: (_) {
          var settingProvider = Constant.settingProvider;

          return settingProvider;
        }),

        // ChangeNotifierProvider(create: (_) => TaskManager()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DalyDoc',
          navigatorKey: Constant.navigatorKey,
          theme: ThemeData(
            fontFamily: "NotoSans",
            primarySwatch: Colors.blue,
          ),
          home: SplashScreenView(
            navigateRoute: token != ""
                ? Routes.setScheduleScreen()
                : IntroductionAnimationScreen(),
            duration: 3000,
            imageSize: 30,
            imageSrc: "assets/icons/logo.png",
            backgroundColor: AppColor.newBgcolor,
          )

          //IntroductionAnimationScreen(),
          ),
    );
  }
}
