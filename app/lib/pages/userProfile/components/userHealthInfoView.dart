import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class UserHealthInfoView extends StatelessWidget {
  String leftTitle;
  Widget? child;
  bool? heightNeed;
  String feet;
  String inches;
  UserHealthInfoView(
      {super.key,
      this.feet = "0",
      this.inches = "0",
      this.heightNeed = false,
      this.leftTitle = "",
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 3,
            height: 18,
            color: AppColor.halfGrayTextColor,
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            leftTitle,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: AppColor.textBlackColor),
          ),
          Spacer(),
          heightNeed!
              ? Column(
                  children: [
                    Container(
                      width: 130,
                      height: 35,
                      decoration: BoxDecoration(
                        color: AppColor.blueColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Center(
                        child: child,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 130,
                      height: 35,
                      decoration: BoxDecoration(
                        color: AppColor.blueColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Center(
                        child: Text("${feet} Feet ${inches} Inches"),
                      ),
                    ),
                  ],
                )
              : Container(
                  width: 130,
                  height: 35,
                  decoration: BoxDecoration(
                    color: AppColor.blueColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Center(
                    child: child,
                  ),
                )
        ],
      ),
    );
  }
}
