import 'package:daly_doc/core/colors/colors.dart';
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

class DalyDocApp extends StatelessWidget {
  const DalyDocApp({super.key});

  // This widget is the root of your application.
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
          navigateRoute: IntroductionAnimationScreen(),
          duration: 3000,
          imageSize: 30,
          imageSrc: "assets/icons/logo.png",
          backgroundColor: AppColor.newBgcolor,
        )

        //IntroductionAnimationScreen(),
        );
  }
}
