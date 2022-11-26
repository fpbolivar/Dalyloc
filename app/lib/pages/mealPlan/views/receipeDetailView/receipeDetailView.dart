import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/pages/mealPlan/components/intructionItemView.dart';
import 'package:daly_doc/pages/mealPlan/components/receipeBasicDetailView.dart';
import 'package:daly_doc/pages/mealPlan/components/receipeBottomButtonView.dart';
import 'package:daly_doc/pages/mealPlan/components/receipeHeaderImageView.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealcontroller.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/pages/mealPlan/model/receipeDetailModel.dart';
import 'package:daly_doc/utils/exportScreens.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/customRoundButton/customButton.dart';
import 'package:flutter/material.dart';

enum InstructionType { check, numeric }

class ReceipeDetailView extends StatefulWidget {
  bool fromMyMealScrren = false;
  String id = "";
  ReceipeDetailView({required this.fromMyMealScrren, required this.id});
  @override
  State<ReceipeDetailView> createState() => _ReceipeDetailViewState();
}

class _ReceipeDetailViewState extends State<ReceipeDetailView>
    with SingleTickerProviderStateMixin {
  List<String> list = [
    'Cookware',
    'Ingredients',
    'Instructions',
  ];
  MealController mealController = MealController();
  MealApis manager = MealApis();
  late TabController _tabController;
  ReceipeDetailModel? data = null;
  MealItemModel? mealItem = null;
  var id = "1";
  @override
  void initState() {
    super.initState();
    id = widget.id;
    _tabController = TabController(vsync: this, length: list.length);
    setState() => _tabController.index = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      tabControllerListner();
      getMenu();
    });
  }

  tabControllerListner() {
    _tabController.addListener(() {
      if (_tabController.index == _tabController.animation?.value) {
        print(_tabController.index);
        setState(() {});
      }
    });
  }

  getMenu() async {
    if (widget.fromMyMealScrren) {
      data = await manager.getMyReceipeDataByID(id);
    } else {
      data = await manager.getReceipeDataByID(id);
    }

    if (data != null) {
      if (data != null) {
        mealItem = MealItemModel(
            full_meal_image_url: data!.full_meal_image_url ?? "",
            id: data!.id,
            meal_calories: data!.meal_calories,
            meal_cooking_timing: data!.meal_cooking_timing,
            meal_name: data!.meal_name,
            meal_image: data!.meal_image,
            menu_type_id: data!.menu_type_id);
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      body: SafeArea(
        child: data == null
            ? Center(
                child: CustomButton.regular(
                title: "Back",
                width: 100,
                fontSize: 14,
                height: 30,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ))
            : Column(
                children: [
                  Expanded(
                    child: DefaultTabController(
                      length: 3,
                      child: CustomScrollView(
                        slivers: <Widget>[
                          ReceipeHeaderImagView(
                            data: data,
                          ),
                          ReceipeBasicDetailView(
                            data: data,
                          ),
                          SliverAppBar(
                            expandedHeight: 50,
                            automaticallyImplyLeading: false,
                            //collapsedHeight: 50,
                            pinned: true,
                            floating: true,
                            backgroundColor: AppColor.newBgcolor,
                            title: TabBar(
                              //automaticIndicatorColorAdjustment: true,
                              controller: _tabController,
                              labelColor: AppColor.textBlackColor,
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                              unselectedLabelColor: AppColor.showAllColor,
                              unselectedLabelStyle: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                              isScrollable: false,
                              indicatorWeight: 3,
                              indicatorColor: AppColor.tabIndicatorColor,
                              // indicator: widget.tabIndicator,
                              //indicatorSize: TabBarIndicatorSize.label,

                              tabs: list
                                  .map((e) => Tab(
                                          child: Text(
                                        e,
                                        style: const TextStyle(
                                            height: 1), //解决中文垂直居中问题
                                      )))
                                  .toList(),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 20,
                            ),
                          ),
                          if (_tabController.index == 0)
                            if (data != null)
                              data!.cookWareList!.isNotEmpty
                                  ? SliverAnimatedList(
                                      itemBuilder: (_, index, ___) {
                                        return InstructionItemView(
                                          type: InstructionType.check,
                                          description: data!
                                              .cookWareList![index].description
                                              .toString(),
                                        );
                                      },
                                      initialItemCount:
                                          data!.cookWareList!.length,
                                    )
                                  : dataNotAvailable(),
                          if (_tabController.index == 1)
                            if (data != null)
                              data!.ingredientList!.isNotEmpty
                                  ? SliverAnimatedList(
                                      itemBuilder: (_, index, ___) {
                                        return InstructionItemView(
                                          type: InstructionType.check,
                                          description: data!
                                              .ingredientList![index]
                                              .description
                                              .toString(),
                                        );
                                      },
                                      initialItemCount:
                                          data!.ingredientList!.length,
                                    )
                                  : dataNotAvailable(),
                          if (_tabController.index == 2)
                            if (data != null)
                              data!.instructionList!.isNotEmpty
                                  ? SliverAnimatedList(
                                      itemBuilder: (_, index, ___) {
                                        return InstructionItemView(
                                          type: InstructionType.numeric,
                                          index: data!.instructionList![index]
                                                  .step_no ??
                                              "0",
                                          description: data!
                                              .instructionList![index]
                                              .description,
                                        );
                                      },
                                      initialItemCount:
                                          data!.instructionList!.length,
                                    )
                                  : dataNotAvailable(),
                        ],
                      ),
                    ),
                  ),
                  ReceipeBottomButtonView(
                    fromMyMealScrren: widget.fromMyMealScrren,
                    addMealAction: () {
                      if (mealItem == null) return;
                      List<MealItemModel> data = [mealItem!];
                      Routes.pushSimple(
                          context: context,
                          child: ReviewAllMealPlanView(data: data));
                    },
                  )
                ],
              ),
      ),
    );
  }

  Widget dataNotAvailable() {
    return SliverFillRemaining(
        child: Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "There is no data available.",
            // ignore: prefer_const_constructors
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
    ));
  }
}
