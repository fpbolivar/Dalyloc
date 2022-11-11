import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/pagesGetStarted/introduction_animation_screen.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:flutter/material.dart';
import '../utils/exportPackages.dart';
import 'pages/onboardingScreen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      token = await LocalStore().getToken();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DalyDoc',
        navigatorKey: LocalString.navigatorKey,
        theme: ThemeData(
          fontFamily: "NotoSans",
          primarySwatch: Colors.blue,
        ),
        home: SplashScreenView(
          navigateRoute: token != ""
              ? ScheduleCalendarScreen()
              : IntroductionAnimationScreen(),
          duration: 3000,
          imageSize: 30,
          imageSrc: "assets/icons/logo.png",
          backgroundColor: AppColor.newBgcolor,
        )

        //IntroductionAnimationScreen(),
        );
  }
}
