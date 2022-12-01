import 'package:daly_doc/pages/appoinmentPlan/model/consultantModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class ConsultantItemView extends StatelessWidget {
  ConsultantItemModel itemData;
  ConsultantItemView({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.5, color: Colors.black26),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
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
              "${itemData.title}",
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Text(
              "\$ ${itemData.price}",
              // ignore: prefer_const_constructors
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemData.description ?? "",
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
              CustomButton.regular(
                width: 70,
                height: 20,
                title: "Book Now",
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
