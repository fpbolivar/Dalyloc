import 'dart:async';

import 'package:daly_doc/pages/mealPlan/components/mealCookItem.dart';
import 'package:daly_doc/pages/mealPlan/components/mealItemView.dart';
import 'package:daly_doc/pages/mealPlan/components/pickDietItemView.dart';
import 'package:daly_doc/pages/mealPlan/components/searchTF.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealcontroller.dart';
import 'package:daly_doc/pages/mealPlan/model/foodDietVarientModel.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class ShowAllMealCookListView extends StatefulWidget {
  MealCategoryModel? category;
  ShowAllMealCookListView({Key? key, this.category}) : super(key: key);

  @override
  State<ShowAllMealCookListView> createState() =>
      _ShowAllMealCookListViewState();
}

class _ShowAllMealCookListViewState extends State<ShowAllMealCookListView> {
  MealCategoryModel? categoryList = null;
  var serachTF = TextEditingController();
  var textSearch = "";
  MealApis manager = MealApis();
  MealController mealController = MealController();
  Timer timerSearch = Timer(const Duration(seconds: 0), () {
    print("Yeah, searching timer");
  });
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getReceipeList();
    });
  }

  getReceipeList() async {
    MealCategoryModel? tempResponse = await manager.getReceipeListByCategoryID(
        id: widget.category?.categoryId);
    if (tempResponse != null) {
      categoryList = tempResponse;
      setState(() {});
    } else {
      categoryList = null;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "${widget.category?.categoryName}",
          subtitle: "",
          fontSize: 16,
          subfontSize: 17,
          topPadding: 5,
          topContainerPadding: 3,
          needShadow: false,
          subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  if (categoryList == null)
                    Expanded(
                      child: Container(),
                    ),
                  if (categoryList != null)
                    Expanded(
                        child: mealList(context, categoryItem: categoryList)),
                  const SizedBox(
                    height: 20,
                  ),
                  if (categoryList != null)
                    mealController.getSelectedAllListItem(
                                [categoryList!]).length ==
                            0
                        ? Container()
                        : bottomNextButtonView(),
                  const SizedBox(
                    height: 15,
                  ),
                ])),
      )),
    );
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
                  .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
            ),
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
      const SizedBox(
        height: 20,
      ),
    ]);
  }

  gridItemList(context, {MealCategoryModel? categoryItem}) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        right: 0,
      ),
      itemBuilder: (context, index) {
        MealItemModel item = categoryItem.data![index];
        return InkWell(
          onTap: () async {
            Routes.pushSimple(
                context: context,
                child: ReceipeDetailView(
                  fromMyMealScrren: true,
                  id: item.id.toString(),
                ));
          },
          child: Container(
            // width: 100,
            height: 100,
            child: MealCookItemWidget(
              categoryId: categoryItem.categoryId ?? 0,
              item: item,
              onAdd: () {
                print("add");
                mealController.selectedItem(categoryItem.data!, index);
                setState(() {});
              },
            ),
          ),
        );
      },
      itemCount: categoryItem!.data!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 10,
        childAspectRatio: MediaQuery.of(context).size.width / (140 * 2),
      ),
    );
  }

  Widget bottomNextButtonView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: InkWell(
        onTap: () {},
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            //height: 50,
            decoration: BoxDecoration(
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
                    blurRadius: 4,
                    offset: Offset(4, 8),
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                  )
                ],
                borderRadius: BorderRadius.circular(7),
                color: AppColor.textGrayBlue),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: 10,
                      // ),
                      const Text(
                        "Items selected",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${mealController.getSelectedAllListItem([
                              categoryList!
                            ]).length} items",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                    ],
                  ),
                ),
                CustomButton.regular(
                  width: 70,
                  fontSize: 15,
                  height: 30,
                  title: "Next",
                  onTap: () {
                    List<MealItemModel> data =
                        mealController.getSelectedAllListItem([categoryList!]);
                    Routes.pushSimple(
                        context: context,
                        child: ReviewAllMealPlanView(data: data));
                  },
                )
              ],
            )),
      ),
    );
  }

  clearTextSearch() {
    cancelTimer();
    setState(() {
      textSearch = "";
      serachTF.clear();
    });
  }

  cancelTimer() {
    timerSearch.cancel();

    setState(() {});
  }
}
