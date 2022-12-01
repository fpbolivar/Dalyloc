import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportScreens.dart';
import '../../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

class IntroMealPlanView extends StatefulWidget {
  IntroMealPlanView({Key? key}) : super(key: key);

  @override
  State<IntroMealPlanView> createState() => _IntroMealPlanViewState();
}

class _IntroMealPlanViewState extends State<IntroMealPlanView> {
  var status = false;
  MealApis manager = MealApis();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getStatus();
    });
  }

  getStatus() async {
    bool? statusTemp = await manager.getSelectedMealIDs();
    print(statusTemp);
    if (statusTemp == null) {
      status = false;
      return;
    }
    status = statusTemp;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          needShadow: false,
          title: "",
          subtitle: "",
          subtitleColor: AppColor.textGrayBlue),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            "Delicious recipies and personalized mealplans",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: AppColor.textGrayBlue),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset(
                'assets/icons/ic_mealPlan.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Spacer(),
          CustomButton.regular(
            title: "Continue",
            background: AppColor.theme,
            onTap: () {
              if (status) {
                Routes.pushSimpleRootNav(
                    context: context, child: MyMealPlanView());
              } else {
                Routes.pushSimpleRootNav(
                    context: context,
                    child: PickYourDientVarientView(
                      gotoNext: true,
                    ));
              }
            },
          ),
          SizedBox(
            height: 30,
          ),
        ]);
  }
}
