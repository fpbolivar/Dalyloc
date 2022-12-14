import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class UserHeaderView extends StatelessWidget {
  String mobile_no = "";
  String userName = "";
  Function()? onChange;
  UserHeaderView(
      {super.key,
      this.onChange,
      required this.userName,
      required this.mobile_no});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColor.textBlackColor),
              ),
              Text(
                "$userName",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColor.halfGrayTextColor),
              ),
              Text(
                "$mobile_no",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColor.halfGrayTextColor),
              ),
            ],
          ),
          Positioned(bottom: 10, right: 10, child: editButton())
        ],
      ),
    );
  }

  Widget editButton() {
    return InkWell(
      onTap: () {
        onChange!();
      },
      child: Container(
        height: 25,
        width: 100,
        decoration: BoxDecoration(
          color: AppColor.theme,
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/ic_edit.png",
              width: 10,
              height: 10,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Edit Username",
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
