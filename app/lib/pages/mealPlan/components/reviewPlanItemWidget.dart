import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class ReviewMealPlanItemView extends StatelessWidget {
  ReviewMealPlanItemView({required this.item, required this.onDeleted});
  MealItemModel? item;
  Function()? onDeleted;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(4, 8),
            color: Color.fromRGBO(0, 0, 0, 0.16),
          )
        ],
        color: Colors.white,
        border: Border.all(
            width: 0.5, color: AppColor.halfGrayTextColor.withOpacity(0.5)),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    item!.meal_name.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "Preheat oven to 425 degrees Fahrenheit and line a baking sheet with parchment paper for easy cleanup. Carefully halve the pumpkin and scoop out the seeds.",
                  //   textAlign: TextAlign.left,
                  // ),
                  // optionView()

                  Row(
                    children: [
                      optionView(
                          iconName: "clock", title: item!.meal_cooking_timing),
                      const SizedBox(
                        width: 10,
                      ),
                      optionView(iconName: "fire", title: item!.meal_calories),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
                width: 100,
                height: 80,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image.asset(
                    //   "assets/icons/ic_dishes.png",
                    //   fit: BoxFit.cover,
                    // ),
                    ImageLoadFromURL(
                      fit: BoxFit.cover,
                      imgURL: item!.full_meal_image_url,
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: InkWell(
                        onTap: () {
                          onDeleted!();
                        },
                        child: Image.asset(
                          "assets/icons/ic_red_close.png",
                          fit: BoxFit.cover,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget optionView({iconName = "", title = ""}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          child: Image.asset(
            "assets/icons/${iconName}.png",
            width: 20,
            height: 20,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "${title}",
          style: const TextStyle(
              fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        // ignore: prefer_const_constructors
      ],
    );
  }
}
