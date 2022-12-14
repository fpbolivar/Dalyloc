import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class TaskNameTFView extends StatelessWidget {
  TaskNameTFView({super.key, required this.controller});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 44,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColor.blueColor
                    //                   <--- border width here
                    ),
                borderRadius: BorderRadius.circular(8),
                color: AppColor.blueColor),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    "🅰",
                    style: TextStyle(fontSize: 23, color: AppColor.theme),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: TextField(
                      controller: controller,
                      style: TextStyle(fontSize: 15),
                      onChanged: (text) {},
                      keyboardType: TextInputType.text,
                      // ignore: prefer_const_constructors

                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: LocalString.plcName),
                      autofocus: false,
                      enabled: true,
                      obscureText: false,
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
