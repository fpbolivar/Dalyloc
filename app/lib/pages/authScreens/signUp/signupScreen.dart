import 'package:daly_doc/widgets/customTF/phoneTF.dart';

import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';

class SignUpScreen extends StatefulWidget {
  String? red;
  SignUpScreen({Key? key, this.red}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController mobileTFC = TextEditingController();
  TextEditingController passwordTFC = TextEditingController();
  TextEditingController cnfPasswordTFC = TextEditingController();
  TextEditingController nameTFC = TextEditingController();
  String countryCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        needHomeIcon: false,
        title: LocalString.lblCreateAnAccount,
      ),
      bottomNavigationBar: SafeArea(child: haveAccoutWidget()),
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
              // const SizedBox(
              //   height: 20,
              // ),
              Text(
                LocalString.lblSignUpDescription,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColor.textBlackColor),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTF(
                controllr: nameTFC,
                placeholder: LocalString.plcName,
              ),
              const SizedBox(
                height: 20,
              ),

              PhoneTF(
                controllr: mobileTFC,
                keyBoardType: TextInputType.phone,
                placeholder: LocalString.plcMobileNo,
                onCountryCodeChange: (code) {
                  countryCode = code;
                  print("Choose $countryCode}");
                },
              ),
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
                height: 20,
              ),
              CustomTF(
                password: true,
                obscureText: true,
                controllr: cnfPasswordTFC,
                placeholder: LocalString.plcCNFPassword,
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton.regular(
                title: LocalString.lblSignUp,
                onTap: () {
                  // Routes.pushSimple(context: context, child: OtpVerifyScreen());
                  RegisterApis().userRegister(
                      mobileNumber: mobileTFC.text,
                      country_code: countryCode,
                      name: nameTFC.text,
                      password: passwordTFC.text,
                      confirmPassword: cnfPasswordTFC.text);
                },
              ),
              const SizedBox(
                height: 100,
              ),
            ]),
      ),
    );
  }

  haveAccoutWidget() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: 44,
        child: Center(
          child: RichText(
            text: TextSpan(
              text: LocalString.lblHaveAccnt,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColor.borderColor,
                  fontSize: 15),
              children: <TextSpan>[
                TextSpan(
                    text: LocalString.lblSignIn,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBlackColor,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
