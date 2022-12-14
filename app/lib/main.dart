import 'dart:io';
import 'package:daly_doc/pages/paymentPages/savedCardListView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/core/stripe/stripeHelper.dart';

import 'package:daly_doc/pages/pagesGetStarted/introduction_animation_screen.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/exportPackages.dart';
import 'firebase/firebase_options.dart';

import 'package:splash_screen_view/SplashScreenView.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await setupFlutterNotifications();
  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await StripeService.app.setup();
  runApp(const DalyDocApp());
}

class DalyDocApp extends StatefulWidget {
  const DalyDocApp({super.key});

  @override
  State<DalyDocApp> createState() => _DalyDocAppState();
}

class _DalyDocAppState extends State<DalyDocApp> {
  // This widget is the root of your application.
  String tokenBearer = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //DBIntializer.sharedInstance.initDb();
    //FirebaseMessagingHelper().setup();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      String? token = await FirebaseMessaging.instance.getAPNSToken();
      print("FCMMM $token}");
      FirebaseMessaging.instance.getInitialMessage().then((value) {});

      FirebaseMessaging.onMessage.listen((d) {});

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
      });
      FirebaseMessaging.instance.getToken().then(setToken);
      _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
      _tokenStream.listen(setToken);
      tokenBearer = await LocalStore().getToken();
      setState(() {});
    });
  }

  late Stream<String> _tokenStream;

  void setToken(String? token) async {
    print('FCM Token2: $token');
    await LocalStore().setFCMToken(token ?? "");
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
        ChangeNotifierProvider(create: (_) {
          var videoProvider = Constant.videoProvider;

          return videoProvider;
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
            navigateRoute: tokenBearer != ""
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

  Widget bottomNextButtonView(context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: InkWell(
          onTap: () {},
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              //height: 50,
              decoration: BoxDecoration(
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 4,
                      offset: Offset(4, 8),
                      color: Color.fromRGBO(0, 0, 0, 0.16),
                    )
                  ],
                  borderRadius: BorderRadius.circular(7),
                  color: AppColor.textGrayBlue),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Text(
                          "Items selected",
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "12 items",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 13),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                      ],
                    ),
                  ),
                  CustomButton.regular(
                    width: 70,
                    fontSize: 15,
                    height: 30,
                    title: "Next",
                    onTap: () {
                      // List<MealItemModel> data =
                      //     mealController.getSelectedAllListItem(categoryList);
                      // Routes.pushSimple(
                      //     context: context,
                      //     child: ReviewAllMealPlanView(
                      //       data: data,
                      //     ));
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
