import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/mealPlan/components/mealItemView.dart';
import 'package:daly_doc/pages/mealPlan/components/noMealWidget.dart';
import 'package:daly_doc/pages/mealPlan/components/pickDietItemView.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealcontroller.dart';
import 'package:daly_doc/pages/mealPlan/model/foodDietVarientModel.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:provider/provider.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class MyMealPlanView extends StatefulWidget {
  String? red;
  MyMealPlanView({Key? key, this.red}) : super(key: key);

  @override
  State<MyMealPlanView> createState() => _MyMealPlanViewState();
}

class _MyMealPlanViewState extends State<MyMealPlanView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Constant.mealProvider.categoryList = [];
      getReceipeList();
    });
  }

  getReceipeList() async {
    Constant.mealProvider.getAllUserData();
    // Constant.mealProvider.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
        title: "My Meal",
        subtitle: "Plan?",
        subtitleColor: AppColor.textGrayBlue,
        rightWidget: Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: InkWell(
            onTap: () {
              Routes.pushSimpleRootNav(
                  context: context, child: MealSettingView());
            },
            child: Image.asset(
              "assets/icons/ic_setting.png",
              width: 25,
              height: 25,
            ),
          ),
        ),
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<MealController>(builder: (context, object, child) {
                    return Expanded(child: listCategory(context));
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton.regular(
                      title: "Start your next meal plan",
                      background: AppColor.theme,
                      fontSize: 15,
                      onTap: () {
                        Constant.mealProvider.categoryCookList = [];
                        Constant.mealProvider.selecteOrderItems = [];
                        Routes.pushSimpleRootNav(
                          context: context,
                          child: MealCookListView(),
                        );
                      },
                    ),
                  ),
                  // Consumer<MealController>(builder: (context, object, child) {
                  //   return (Constant.mealProvider.categoryList.length != 0)
                  //       ?
                  //       : Container();
                  // }),
                  const SizedBox(
                    height: 20,
                  ),
                ])),
      )),
    );
  }

  Widget listCategory(context) {
    return Constant.mealProvider.categoryList.length == 0
        ? NoMealWidget(
            refresh: () {
              getReceipeList();
            },
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(right: 00),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              MealCategoryModel cat = Constant.mealProvider.categoryList[index];
              return mealList(context, categoryItem: cat);
            },
            separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Divider(),
                ),
            itemCount: Constant.mealProvider.categoryList.length);
  }

  Widget mealList(context, {MealCategoryModel? categoryItem}) {
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryItem!.categoryName.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            // GestureDetector(
            //   onTap: () {
            //     print("sss");

            //     // Get.toNamed(Routes.Matches);
            //   },
            //   child: Text("View All", style: TextStyle(fontSize: 10)),
            // )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
        child: Row(
          children: [
            Expanded(child: gridItemList(context, categoryItem: categoryItem)),
          ],
        ),
      ),
    ]);
  }

  gridItemList(context, {MealCategoryModel? categoryItem}) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        right: 0,
      ),
      itemBuilder: (context, index) {
        MealItemModel item = categoryItem.data![index];
        return InkWell(
          onTap: () async {
            Routes.pushSimpleRootNav(
                context: context,
                child: ReceipeDetailView(
                  fromMyMealScrren: true,
                  id: item.id.toString(),
                ));
          },
          child: Container(
            // width: 100,
            height: 100,
            child: MealItemViewWidget(
              categoryId: categoryItem.categoryId ?? 0,
              item: item,
            ),
          ),
        );
      },
      itemCount: categoryItem!.data!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: MediaQuery.of(context).size.width / (100 * 4),
      ),
    );
  }
}
