import 'package:flutter/material.dart';

import 'pages/onboardingScreen.dart';

//Test
void main() {
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnboardingScreen(),
    );
  }
}
