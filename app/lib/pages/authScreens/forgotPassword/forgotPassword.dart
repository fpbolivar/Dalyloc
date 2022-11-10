import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';

import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import '../authManager/api/forgotPassword.dart';

class ForgotPasswordScreen extends StatefulWidget {
  String? red;
  ForgotPasswordScreen({Key? key, this.red}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController mobileTFC = TextEditingController();
  TextEditingController passwordTFC = TextEditingController();
  TextEditingController cnfPasswordTFC = TextEditingController();
  TextEditingController nameTFC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: LocalString.lblForgotPasswordNavTitle,
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
                LocalString.lblForgotPasswordDescription,
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
                'assets/icons/ic_vector_otp.png',
                fit: BoxFit.contain,
                height: 170,
                width: 170,
              ),
              CustomTF(
                  controllr: mobileTFC,
                  placeholder: LocalString.plcEnterMobileNo),
              const SizedBox(
                height: 50,
              ),
              CustomButton.regular(
                title: LocalString.lblSend,
                onTap: () async {
                  await LocalStore().set_MobileNumberOfUser(mobileTFC.text);
                  ForgotPasswordApi().forgotPassword(mobileTFC.text);
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
