import 'package:daly_doc/pages/authScreens/authManager/api/forgotPassword.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  String? red;
  String? country_code;
  CreateNewPasswordScreen({Key? key, this.red, this.country_code = ""})
      : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  TextEditingController mobileTFC = TextEditingController();
  TextEditingController passwordTFC = TextEditingController();
  TextEditingController cnfPasswordTFC = TextEditingController();
  TextEditingController nameTFC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        needHomeIcon: false,
        title: LocalString.lblCreateNewPasswordNavTitle,
        icon: true,
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

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  LocalString.lblCreateNewPasswordDescription,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: AppColor.textBlackColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/icons/ic_create_pass.png',
                  fit: BoxFit.contain,
                  height: 170,
                  width: 170,
                ),
                CustomTF(
                  password: true,
                  obscureText: true,
                  controllr: passwordTFC,
                  placeholder: "New " + LocalString.plcPassword,
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
                  title: LocalString.lblSubmit,
                  onTap: () {
                    ForgotPasswordApi().createPassword(
                        password: passwordTFC.text,
                        country_code: widget.country_code ?? "",
                        passwordConfirmation: cnfPasswordTFC.text);
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
              ]),
        ),
      ),
    );
  }
}
