import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/forgotPassword.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';

import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import '../../allowLocation/allowLocation.dart';

class OtpVerifyScreen extends StatefulWidget {
  String? red;
  bool forgotPassword;
  OtpVerifyScreen({Key? key, this.red, this.forgotPassword = false})
      : super(key: key);

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  var userOTP = "";

  TextEditingController otpTFC = TextEditingController();
  @override
  @override
  void initState() {
    super.initState();
    print("object=LocalString.forgotPasswordOtp");
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        userOTP = await LocalStore().getotp();
        setState(() {});
      },
    );
  }

  otp() async {
    userOTP = await LocalStore().getotp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: LocalString.lblOTPVerify,
      ),
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
                height: 20,
              ),
              Text(
                LocalString.lblOTPVerifyDescription,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColor.textBlackColor),
              ),
              const SizedBox(
                height: 20,
              ),
              otpTF(),
              const SizedBox(
                height: 10,
              ),
              resendWidget(),
              const SizedBox(
                height: 50,
              ),
              CustomButton.regular(
                title: LocalString.lblVerify,
                onTap: () {
                  widget.forgotPassword == false
                      ? RegisterApis().otpApi(otp: otpTFC.text)
                      : ForgotPasswordApi().otpApi(otp: otpTFC.text);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Your six digit Otp is $userOTP",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: AppColor.subTitleColor),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ]),
      ),
    );
  }

  Widget otpTF() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TextButton(
        //     onPressed: () {
        //       otp();
        //     },
        //     child: Text("Otp")),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            LocalString.lblotpTFHint,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: AppColor.subTitleColor),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColor.blueColor
                  //                   <--- border width here
                  ),
              borderRadius: BorderRadius.circular(8),
              color: AppColor.blueColor),
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: TextField(
              controller: otpTFC,
              style: TextStyle(fontSize: 16),
              onChanged: (text) {},
              keyboardType: TextInputType.number,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: LocalString.plcOTP),
              autofocus: false,
              enabled: true,
              obscureText: false,
            ),
          ),
        ),
      ],
    );
  }

  resendWidget() {
    return Container(
      height: 20,
      child: Row(
        children: [
          const Spacer(),
          InkWell(
            onTap: () {
              widget.forgotPassword == false
                  ? RegisterApis().resendOtp()
                  : ForgotPasswordApi().resendOtp();
              Future.delayed(const Duration(seconds: 2), () {
                otp();
                setState(() {});
              });
            },
            child: Text(
              LocalString.lblResend,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColor.borderColor,
                  fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
