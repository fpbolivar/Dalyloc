import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';

import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import 'dart:math';

import '../authScreens/authManager/api/changePasswordapi.dart';

class ChangePassswordView extends StatefulWidget {
  String? red;
  ChangePassswordView({Key? key, this.red}) : super(key: key);

  @override
  State<ChangePassswordView> createState() => _ChangePassswordViewState();
}

class _ChangePassswordViewState extends State<ChangePassswordView> {
  TextEditingController currentTFC = TextEditingController();
  TextEditingController passwordTFC = TextEditingController();
  TextEditingController cnfPasswordTFC = TextEditingController();
  TextEditingController nameTFC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: LocalString.lblChangePassword,
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
              CustomTF(
                  password: true,
                  controllr: currentTFC,
                  obscureText: true,
                  placeholder: LocalString.plcCurrentPassword),
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
                title: LocalString.lblSubmit,
                onTap: () {
                  ChangePasswordApi().ChangePassword(
                      oldPassword: currentTFC.text,
                      password: passwordTFC.text,
                      passwordConfirmation: cnfPasswordTFC.text);
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
