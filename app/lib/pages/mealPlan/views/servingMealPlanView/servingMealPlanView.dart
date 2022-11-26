import 'package:daly_doc/pages/mealPlan/components/pickDietItemView.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import 'package:daly_doc/pages/mealPlan/model/foodDietVarientModel.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class ServingMealPlanView extends StatefulWidget {
  String? red;
  var gotoNext = false;
  ServingMealPlanView({Key? key, this.red, this.gotoNext = false})
      : super(key: key);

  @override
  State<ServingMealPlanView> createState() => _ServingMealPlanViewState();
}

class _ServingMealPlanViewState extends State<ServingMealPlanView> {
  List<FoodDietModel> allDiet = [];
  MealApis manager = MealApis();
  var goToNext = true;
  var selecteIndex = -1;
  @override
  void initState() {
    super.initState();
    goToNext = widget.gotoNext;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMealSize();
    });
  }

  getMealSize() async {
    List<FoodDietModel>? tempResponse = await manager.getMealSize();
    if (tempResponse != null) {
      allDiet = [];
      allDiet = tempResponse;
      for (int i = 0; i < allDiet.length; i++) {
        if (allDiet[i].isSelected == true) {
          selecteIndex = i;
          break;
        }
      }
      setState(() {});
    } else {
      allDiet = [];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "Servings  per",
          subtitle: "Meal?",
          subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: allDiet.length == 0
                ? simpleMessageShow("Currently,Item not found.")
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(child: bodyDesign()),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton.regular(
                          title: "Continue",
                          background: selecteIndex == -1
                              ? Colors.grey[400]
                              : AppColor.theme,
                          onTap: () async {
                            if (selecteIndex == -1) {
                              return;
                            }
                            bool? result = await manager.createMeal(
                                meal_size_id: allDiet[selecteIndex].id);
                            if (result != null && goToNext) {
                              if (result == true) {
                                Routes.pushSimple(
                                    context: context,
                                    child: AllergiesFoodListView(
                                      gotoNext: true,
                                    ));
                              }
                            } else {
                              if (result == true) {
                                ToastMessage.showSuccessMessage(
                                    msg: "Your serving item has been updated.",
                                    color: AppColor.purple);
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
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
      itemCount: allDiet.length,
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
            child: PickDietItemView(
              itemData: allDiet[index],
              needImage: false,
              onSelected: () {
                allDiet.forEach((element) {
                  element.isSelected = false;
                });
                allDiet[index].isSelected = !allDiet[index].isSelected;
                selecteIndex = index;
                setState(() {});
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
}
