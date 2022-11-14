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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: LocalString.lblCreateAnAccount,
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
                  //        Routes.pushSimple(
                  // context: Constant.navigatorKey.currentState!.context,
                  // child: OtpVerifyScreen());
                  RegisterApis().userRegister(
                      mobileNumber: mobileTFC.text,
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
}
