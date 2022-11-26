import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class InstructionItemView extends StatelessWidget {
  InstructionType type;
  String index = "0";
  String? description;
  String? gmDescription;
  InstructionItemView(
      {this.type = InstructionType.check,
      this.index = "0",
      this.description = "",
      this.gmDescription = ""});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20, vertical: type == InstructionType.numeric ? 2 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (type == InstructionType.check)
            Container(
              width: 30,
              height: 30,
              child: Image.asset(
                "assets/icons/ic_itemCheck.png",
                fit: BoxFit.contain,
              ),
            ),
          if (type == InstructionType.numeric)
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: AppColor.textGrayBlue)),
              child: Center(
                  child: Text(
                index.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.textGrayBlue),
              )),
            ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  description ?? "",
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
