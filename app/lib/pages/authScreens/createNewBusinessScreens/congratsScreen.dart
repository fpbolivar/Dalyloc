import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/createNewBusinessService.dart';
import 'package:daly_doc/utils/exportWidgets.dart';

import '../../../core/localStore/localStore.dart';
import '../../../utils/exportPackages.dart';
import '../../../widgets/backgroundCurveView/backgroundCurveView.dart';
import '../createNewbusinessScreens/createNewBusiness.dart';

class CongratsScreenBusiness extends StatefulWidget {
  CongratsScreenBusiness({super.key});

  @override
  State<CongratsScreenBusiness> createState() => _CongratsScreenBusinessState();
}

class _CongratsScreenBusinessState extends State<CongratsScreenBusiness> {
  String businessId = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    businessId = await LocalStore().getBusinessId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: bodyDesign(context),
        ),
      )),
    );
  }

  Widget bodyDesign(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          divider(45),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Center(
          //       child: InkWell(
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //         child: SizedBox(
          //           width: 35,
          //           child: Image.asset(
          //             'assets/icons/CloseCircle.png',
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          divider(45),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image.asset(
                  'assets/icons/congratstick.png',
                  fit: BoxFit.cover,
                ),
              ),
              divider(15),
              Text(
                LocalString.lblCongratulation,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: AppColor.textBlackColor),
              ),
              divider(20),
              Text(
                LocalString.lblBusinessCongratsDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: AppColor.textBlackColor),
              ),
              divider(60),
              CustomButton.regular(
                title: "Create Business service?",
                onTap: () async {
                  // businessId = await LocalStore().getBusinessId();
                  print(businessId);
                  Routes.pushSimple(
                      context: context,
                      child: CreateNewBusinessServiceScreen(
                        update: false,
                      ));
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton.regular(
                title: "Skip",
                width: 100,
                height: 30,
                background: Colors.transparent,
                fontSize: 14,
                titleColor: AppColor.theme,
                onTap: () async {
                  // businessId = await LocalStore().getBusinessId();
                  print(businessId);

                  //   Routes.pushSimple(
                  //       context: context, child: BusinessSettingView());
                  Navigator.of(context).popUntil((route) =>
                      route.settings.name ==
                      SettingScreen().runtimeType.toString());
                  Constant.settingProvider.getUserBusinessDetail();
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  divider(double height) {
    return SizedBox(
      height: height,
    );
  }
}
