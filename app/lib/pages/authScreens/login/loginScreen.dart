import '../../../socialLoginManager/socialLoginManager.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import 'dart:math';

import '../../allowLocation/allowLocation.dart';

class LoginScreen extends StatefulWidget {
  String? red;
  LoginScreen({Key? key, this.red}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileTFC = TextEditingController();
  TextEditingController passwordTFC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: bodyDesign(),
        ),
      )),
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
                LocalString.lblLetsStarLoginDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColor.textBlackColor),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTF(
                  controllr: mobileTFC, placeholder: LocalString.plcMobileNo),
              const SizedBox(
                height: 20,
              ),
              CustomTF(
                password: true,
                obscureText: true,
                controllr: passwordTFC,
                placeholder: LocalString.plcPassword,
              ),
              const SizedBox(
                height: 10,
              ),
              forgotWidget(),
              const SizedBox(
                height: 20,
              ),
              CustomButton.regular(
                title: LocalString.lblSignIn,
                onTap: () {
                  LoginApi().userLogin(
                      mobileNumber: mobileTFC.text, password: passwordTFC.text);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              orContinueWithWidget(),
              const SizedBox(
                height: 30,
              ),
              SocialLoginButton(
                height: 50,
                type: SocialButtonType.facebook,
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
                width: MediaQuery.of(context).size.width,
                type: SocialButtonType.google,
                title: LocalString.lblContinueWithGoogle,
                background: Colors.transparent,
                onTap: () {
                  SocialLoginManager().googleSignIn(context);
                },
              ),
              const SizedBox(
                height: 50,
              ),
              dontHaveAccoutWidget(),
              const SizedBox(
                height: 100,
              ),
            ]),
      ),
    );
  }

  dontHaveAccoutWidget() {
    return InkWell(
      onTap: () {
        Routes.pushSimple(context: context, child: SignUpScreen());
      },
      child: Container(
        child: RichText(
          text: TextSpan(
            text: LocalString.lblDontHaveAccnt,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColor.borderColor,
                fontSize: 15),
            children: <TextSpan>[
              TextSpan(
                  text: LocalString.lblSignUp,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.textBlackColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  forgotWidget() {
    return InkWell(
      onTap: () {
        Routes.pushSimple(context: context, child: ForgotPasswordScreen());
      },
      child: Container(
        height: 20,
        child: Row(
          children: [
            const Spacer(),
            Text(
              LocalString.lblForgotPassword,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColor.borderColor,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  orContinueWithWidget() {
    return Container(
      height: 20,
      width: 270,
      //  width: MediaQuery.of(context).size.width * 0.7,
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
