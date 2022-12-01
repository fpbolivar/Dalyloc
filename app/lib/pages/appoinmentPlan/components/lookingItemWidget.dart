import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/LookingItemModel.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/paymentPages/model/SavedCardModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class LookingItemView extends StatelessWidget {
  LookingItemView(
      {required this.item,
      required this.onDeleted,
      required this.onDefaultSet});
  LookingItemModel? item;
  Function()? onDeleted;
  Function()? onDefaultSet;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.only(left: 5, right: 5),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
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
                    height: 5,
                  ),
                  Text(
                    "${item!.title}",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
