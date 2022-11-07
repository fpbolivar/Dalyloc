import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  SplashView({Key? key, required this.animationController}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Image.asset(
                'assets/introduction_animation/introduction_image.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                LocalString.lblGoalSetting,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            const Padding(
              padding: EdgeInsets.only(left: 64, right: 64),
              child: Text(
                LocalString.lblGoalSettingDes,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            InkWell(
              onTap: () {
                widget.animationController.animateTo(0.2);
              },
              child: Container(
                height: 44,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xff132137),
                ),
                child: const Center(
                  child: Text(
                    LocalString.lblGetStarted,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
