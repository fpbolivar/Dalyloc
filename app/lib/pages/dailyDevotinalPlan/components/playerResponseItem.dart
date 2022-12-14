import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/models/prayerModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class PlayerResponseItem extends StatelessWidget {
  PrayerResponse? item;
  int index;
  PlayerResponseItem({required this.item, required this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "${index.toString()}) ${item!.user_prayer_response ?? ""}",
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
