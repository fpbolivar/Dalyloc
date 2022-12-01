import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/mealPlan/model/mealCategoryModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class ReviewCalendarButton extends StatelessWidget {
  ReviewCalendarButton(
      {required this.onCalender, required this.onConfirm, required this.date});
  Function() onCalender;
  Function() onConfirm;
  String date;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: InkWell(
          onTap: () {},
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              padding: const EdgeInsets.all(10),
              //height: 50,
              decoration: BoxDecoration(
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 4,
                      offset: Offset(4, 8),
                      color: Color.fromRGBO(0, 0, 0, 0.16),
                    )
                  ],
                  borderRadius: BorderRadius.circular(7),
                  color: AppColor.textGrayBlue),
              clipBehavior: Clip.antiAlias,
              child: Row(
//mainAxisAlignment: MainAxisAlignment.start,
                //              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        onCalender();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            "Meal Date",
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            date,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton.regular(
                    width: 70,
                    fontSize: 15,
                    height: 30,
                    title: "Confirm",
                    onTap: () {
                      onConfirm();
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
