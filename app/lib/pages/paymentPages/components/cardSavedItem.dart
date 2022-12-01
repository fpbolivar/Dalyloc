import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/paymentPages/model/SavedCardModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class CardSavedItemView extends StatelessWidget {
  CardSavedItemView(
      {required this.item,
      required this.onDeleted,
      required this.onDefaultSet});
  SavedCardModel? item;
  Function()? onDeleted;
  Function()? onDefaultSet;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 4,
        //     offset: Offset(4, 8),
        //     color: Color.fromRGBO(0, 0, 0, 0.16),
        //   )
        // ],
        color: Colors.white,
        border: Border.all(
            width: 0.5, color: AppColor.halfGrayTextColor.withOpacity(0.5)),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
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
                    "${item!.brand.toString()} \t •••• \t •••• " +
                        item!.last4.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
                width: 40,
                height: 80,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image.asset(
                    //   "assets/icons/ic_dishes.png",
                    //   fit: BoxFit.cover,
                    // ),

                    Positioned(
                      top: 13,
                      right: 9,
                      child: InkWell(
                          onTap: () {
                            onDefaultSet!();
                          },
                          child: "${item!.defaultStatus.toString()}" == "1"
                              ? Icon(
                                  Icons.check_circle,
                                  color: AppColor.theme,
                                )
                              : Icon(
                                  Icons.circle_outlined,
                                  color: Colors.grey,
                                )),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
