import 'package:daly_doc/pages/mealPlan/components/reviewPlanItemWidget.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/pages/mealPlan/views/successOrderPage/successOrderPage.dart';
import 'package:daly_doc/pages/settingsScreen/ApiManager/AllPlansApiManager.dart';
import 'package:daly_doc/pages/settingsScreen/model/allPlanMode.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/planMonthlyYearlyView.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class ReviewAllMealPlanView extends StatefulWidget {
  ReviewAllMealPlanView({Key? key, required this.data}) : super(key: key);
  List<MealItemModel>? data;
  @override
  State<ReviewAllMealPlanView> createState() => _ReviewAllMealPlanViewState();
}

class _ReviewAllMealPlanViewState extends State<ReviewAllMealPlanView> {
  List<MealItemModel> allList = [];
  MealApis manager = MealApis();
  bool isActive = false;
  bool isCheckingPlanLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      allList = widget.data!;
      setState(() {});
    });
  }

  getActiveStatus() async {
    // noPlanWidget();
    // return;
    isCheckingPlanLoading = true;
    setState(() {});
    bool? status = await manager.getActivePlanStatus();
    if (status == null) {
      isActive = false;
    } else {
      isActive = status;
      if (isActive) {
        orderMealSubmit();
      }
      if (isActive == false) {
        noPlanWidget();
      }
    }
    isCheckingPlanLoading = false;
    setState(() {});
  }

  orderMealSubmit() async {
    bool? status = await manager.bookOrCreateMeal(allList);

    if (status != null) {
      if (status) {
        Routes.pushSimple(context: context, child: SuccessOrderPageView());
        // Constant.mealProvider.getAllUserData();
        // Navigator.of(context).popUntil((route) =>
        //     route.settings.name ==
        //     MyMealPlanView().toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "Review Meal",
          subtitle: "Plan?",
          subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: bodyDesign()),
                  const SizedBox(
                    height: 20,
                  ),
                  isCheckingPlanLoading
                      ? const Center(
                          child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              )),
                        )
                      : CustomButton.regular(
                          title: "Confirm",
                          background: AppColor.theme,
                          onTap: () async {
                            getActiveStatus();
                          },
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                ])),
      )),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),

              listView(),

              const SizedBox(
                height: 20,
              ),

              //
            ]),
      ),
    );
  }

  Widget listView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allList.length,
      itemBuilder: (conext, index) {
        return InkWell(
            onTap: () {
              // Routes.presentSimple(
              //     context: context,
              //     child: PlanDetailView(
              //       data: freePlan[index],
              //     ));
              //onTap!(itemList[index].section ?? 0, index);
            },
            child: ReviewMealPlanItemView(
              item: allList[index],
              onDeleted: () {
                print("onDeleted");
                List<MealItemModel> allListTemp = [];
                allListTemp.addAll(allList);
                allListTemp.removeAt(index);
                allList = [];
                allList.addAll(allListTemp);
                setState(() {});
                if (allList.length == 0) {
                  Navigator.of(context).pop();
                }
              },
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        // ignore: prefer_const_constructors
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
        );
      },
    );
  }

  noPlanWidget() {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5.0),
          ),
        ),
        builder: (context) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You are not member of Meal subscription.",
                    textAlign: TextAlign.center,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Text(
                    "For take meal feature, join Meal subscription.",
                    textAlign: TextAlign.center,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton.regular(
                          title: "Dismiss",
                          width: 100,
                          height: 30,
                          fontSize: 13,
                          background: Colors.red,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomButton.regular(
                          title: "Buy",
                          width: 70,
                          height: 30,
                          fontSize: 13,
                          onTap: () {
                            Navigator.of(context).pop();
                            getplanList();
                          },
                        )
                      ]),
                ],
              ),
            ),
          );
        });
  }

  getplanList() {
    isCheckingPlanLoading = true;
    setState(() {});
    AllPlansApiManager().getAllPlans(
        onSuccess: (List<GetAllPlansModel> data) {
          isCheckingPlanLoading = false;
          setState(() {});
          GetAllPlansModel? mealplan;

          data.forEach((element) {
            if (element.typeOfOperation == "meal") {
              mealplan = element;

              // Routes.pushSimple(context: context, child: MealSettingView());
            }
          });
          if (mealplan != null) {
            Routes.pushSimple(
                context: context,
                child: PlanMonthlyYearlyView(
                  title: "Meal",
                  subscriptionSubPlans: mealplan!.subscriptionSubPlans!,
                ));
          }
        },
        onError: () {});
  }
}
