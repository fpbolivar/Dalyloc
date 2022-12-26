import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/authScreens/deleteAccount/manager/deleteAccountManager.dart';

import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class DeleteAccountView extends StatefulWidget {
  DeleteAccountView({
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  var manager = DeleteAccountManager();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  deleteAccount() async {
    showConfirmAlertWithBtnName(
        "Are you sure you want to delete the account?\n\nNote:Due to deleting the account,Your all tasks, exercises, prayers, businesses, services, appointments etc. will be permanantly deleted.\nAlso Your all payment details, transactions, payouts will be permanantly deleted. ",
        btnName: "Continue", onTap: () async {
      await manager.deleteAccountUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navBarWhite,
      appBar: CustomAppBarPresentCloseButton(
        title: "Delete",
        subtitle: "Account",
        fontSize: 18,
        subfontSize: 20,
        topSubPadding: 3,
        needShadow: false,
        needHomeIcon: false,
        colorNavBar: AppColor.textWhiteColor,
        subtitleColor: AppColor.textGrayBlue,
      ),
      body: BackgroundCurveView(
          color: AppColor.navBarWhite,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    bodyDesign(context),
                    const SizedBox(
                      height: 15,
                    ),
                  ]))),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign(context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              Text(
                "Do you want to Delete this account?",
                style: TextStyle(
                    color: AppColor.textBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Image.asset("assets/icons/placeholderDalyDoc.png",
                    height: 60, width: 60),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${Constant.taskProvider.userName}",
                style: TextStyle(
                    color: AppColor.textBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Deleting your account is permanent?",
                style: TextStyle(
                    color: AppColor.textBlackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Your all tasks, exercises, prayers, businesses, services, appointments etc. will be permanantly deleted.\nAlso Your all payment details, transactions, payouts will be permanantly deleted.",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              CustomButton.regular(
                title: "Delete Account",
                background: AppColor.theme,
                onTap: () async {
                  deleteAccount();
                },
              ),
              //
            ]),
      ),
    );
  }
}
