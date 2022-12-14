import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportScreens.dart';
import '../../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

class SuccessOrderPageView extends StatefulWidget {
  SuccessOrderPageView({Key? key}) : super(key: key);

  @override
  State<SuccessOrderPageView> createState() => _SuccessOrderPageViewState();
}

class _SuccessOrderPageViewState extends State<SuccessOrderPageView> {
  var status = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

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
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(
          //   height: 60,
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset(
                'assets/icons/congratstick.png',
                fit: BoxFit.contain,
                width: 100,
                height: 100,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Congratulations,\nYour Meal has been created.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColor.textGrayBlue),
          ),
          Spacer(),
          CustomButton.regular(
            title: "Done",
            background: AppColor.theme,
            width: 130,
            height: 40,
            fontSize: 18,
            radius: 4,
            onTap: () {
              Constant.mealProvider.getAllUserData();
              Navigator.of(context).popUntil((route) =>
                  route.settings.name ==
                  MyMealPlanView().runtimeType.toString());
            },
          ),
          SizedBox(
            height: 30,
          ),
        ]);
  }
}
