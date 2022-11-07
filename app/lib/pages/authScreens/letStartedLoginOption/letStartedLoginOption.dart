import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';

import '../../../socialLoginManager/socialLoginManager.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import 'dart:math';

class LetStartedLoginOption extends StatefulWidget {
  String? red;
  LetStartedLoginOption({Key? key, this.red}) : super(key: key);

  @override
  State<LetStartedLoginOption> createState() => _LetStartedLoginOptionState();
}

class _LetStartedLoginOptionState extends State<LetStartedLoginOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      body: BackgroundCurveView(child: SafeArea(child: bodyDesign())),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                LocalString.lblLetsStart,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: AppColor.textBlackColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                LocalString.lblLetsStartDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColor.textBlackColor),
              ),
              const SizedBox(
                height: 40,
              ),
              SocialLoginButton(
                height: 50,
                type: SocialButtonType.facebook,
                width: 270,
                title: LocalString.lblContinueWithFB,
                background: Colors.transparent,
                onTap: () {
                  SocialLoginManager().loginFaceBook(context);
                },
              ),
              const SizedBox(
                height: 25,
              ),
              SocialLoginButton(
                height: 50,
                width: 270,
                type: SocialButtonType.google,
                // width: MediaQuery.of(context).size.width * 0.65,
                title: LocalString.lblContinueWithGoogle,
                background: Colors.transparent,
                onTap: () {
                  SocialLoginManager().googleSignIn(context);
                },
              ),
              const SizedBox(
                height: 25,
              ),
              orContinueWithWidget(),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                  title: LocalString.lblLogin,
                  height: 50,
                  fontSize: 18,
                  borderWidth: 1.5,
                  fontweight: FontWeight.w400,
                  width: 270,
                  // width: MediaQuery.of(context).size.width * 0.65,
                  radius: 8,
                  shadow: false,
                  background: Colors.transparent,
                  titleColor: AppColor.textBlackColor,
                  onTap: () {
                    Routes.pushSimple(context: context, child: LoginScreen());
                  }),
              const SizedBox(
                height: 100,
              ),
            ]),
      ),
    );
  }

  orContinueWithWidget() {
    return Container(
      height: 20,
      width: 270,
      // width: MediaQuery.of(context).size.width * 0.7,
      child: Row(
        children: [
          const Spacer(),
          Image.asset(
            "assets/icons/leftStrip.png",
            height: 10,
            width: 70,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            LocalString.lblOrContinueWith,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColor.borderColor,
                fontSize: 15),
          ),
          const SizedBox(
            width: 4,
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: Image.asset(
              "assets/icons/leftStrip.png",
              width: 70,
              height: 10,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
