import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class ReceipeBottomButtonView extends StatelessWidget {
  bool fromMyMealScrren = false;
  ReceipeBottomButtonView({this.fromMyMealScrren = false, this.addMealAction});
  VoidCallback? addMealAction;
  @override
  Widget build(BuildContext context) {
    return (!fromMyMealScrren) ? bottomNextButtonView(context) : Container();
  }

  Widget bottomNextButtonView(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          color: AppColor.newBgcolor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0.0, -2.5), //(x,y)
              blurRadius: 1.0,
            ),
          ]),
      padding: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //     // width: 130,
              //     height: 30,
              //     decoration: BoxDecoration(
              //         // ignore: prefer_const_literals_to_create_immutables
              //         // boxShadow: [
              //         //   const BoxShadow(
              //         //     blurRadius: 4,
              //         //     offset: Offset(4, 8),
              //         //     color: Color.fromRGBO(0, 0, 0, 0.16),
              //         //   )
              //         // ],
              //         borderRadius: BorderRadius.circular(7),
              //         color: AppColor.servingBgColor),
              //     clipBehavior: Clip.antiAlias,
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 10, right: 5),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Text(
              //             "2 serving",
              //             // ignore: prefer_const_constructors
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w500,
              //                 color: Colors.black,
              //                 fontSize: 13),
              //           ),
              //           Icon(Icons.keyboard_arrow_down_rounded)
              //         ],
              //       ),
              //     )),
              if (!fromMyMealScrren)
                CustomButton.regular(
                  width: 130,
                  fontSize: 15,
                  height: 30,
                  title: "Add to meal",
                  background: AppColor.textGrayBlue,
                  onTap: () {
                    addMealAction!();
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
