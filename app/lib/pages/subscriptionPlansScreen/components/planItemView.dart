import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class PlanItemView extends StatelessWidget {
  PlanInfoModel itemData;
  PlanItemView({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColor.stripOrange,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
            child: Stack(
              children: [
                bodyView(),
                // Positioned(
                //     right: 0,
                //     top: 0,
                //     child: Container(
                //       width: 80,
                //       height: 80,
                //       child: Image.asset(
                //         "assets/icons/${itemData.image}",
                //         width: 25,
                //         height: 25,
                //       ),
                //     ))
              ],
            )),
      ),
    );
  }

  Widget bodyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: prefer_const_constructors
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              "${itemData.planList?.first.title} Plan",
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            Spacer(),
            Text(
              "\$ ${itemData.planList?.first.price}/",
              // ignore: prefer_const_constructors
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            Text(
              itemData.periodDuration.rawValue,
              // ignore: prefer_const_constructors
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(children: [
          Text(
            "Next billing date " + itemData.end_dateFormat,
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
          ),
          Spacer(),
          CustomButton.regular(
            width: 60,
            height: 20,
            title: "Manage",
            fontSize: 14,
            fontweight: FontWeight.w500,
            background: Colors.transparent,
            titleColor: AppColor.textGrayBlue,
            radius: 3,
          ),
        ])
      ],
    );
  }
}
