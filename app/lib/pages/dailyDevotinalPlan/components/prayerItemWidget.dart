import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/models/prayerModel.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/paymentPages/model/SavedCardModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class PrayerItemWidget extends StatelessWidget {
  PrayerItemWidget({
    required this.item,
  });
  PrayerModel? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: MediaQuery.of(context).size.width,
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
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            item!.prayerStatus.toString().toLowerCase() == "answered"
                ? const Icon(
                    Icons.circle,
                    color: Color(0XFF2E7316),
                    size: 20,
                  )
                : const Icon(
                    Icons.circle,
                    color: Color(0XFFD82121),
                    size: 20,
                  ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item!.prayerTitle.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    item!.prayerNote ?? "",
                    textAlign: TextAlign.left,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
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
