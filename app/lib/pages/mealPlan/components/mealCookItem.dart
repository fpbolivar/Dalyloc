import 'dart:ui';

import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/widgets/ToastBar/flushbar.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';

class MealCookItemWidget extends StatelessWidget {
  MealItemModel? item;

  int categoryId;
  Function()? onAdd;
  MealCookItemWidget({Key? key, this.item, this.categoryId = 0, this.onAdd})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  spreadRadius: -4,
                )
              ],
            ),
            child: Card(
                // margin: EdgeInsets.zero,
                // // color: Colors.redAccent,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(5),
                // ),
                child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // if (item?.meal_image != "" && item?.meal_image == "null")
                  ImageLoadFromURL(
                    fit: BoxFit.cover,
                    imgURL: item?.full_meal_image_url,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black.withAlpha(0),
                          Colors.black12,
                          Colors.black
                        ],
                      ),
                    ),
                  ),
                  Positioned(bottom: 10, right: 10, child: blurButtonView())
                ],
              ),
            )),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              item!.meal_name.toString(),
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }

  Widget blurButtonView() {
    return InkWell(
      onTap: () {
        onAdd!();
      },
      child: Center(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                // color: item!.isSelected!
                //     ? Colors.transparent
                //     : Colors.grey.shade200.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: item!.isSelected!
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 30,
                      )
                    : Icon(Icons.add),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
