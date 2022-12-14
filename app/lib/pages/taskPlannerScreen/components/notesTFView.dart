import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class NoteTFViewTask extends StatelessWidget {
  NoteTFViewTask(
      {super.key,
      this.maxLine = 5,
      this.minLine = 3,
      this.textController,
      this.keybordType = TextInputType.text,
      this.placeholder = "Write"});
  int maxLine;
  int minLine;
  TextEditingController? textController;
  TextInputType keybordType;
  String placeholder;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Note: *",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: AppColor.textBlackColor),
        ),
        const SizedBox(
          height: 20,
        ),
        writeReview()
      ],
    );
  }

  Widget writeReview() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.segmentBarBgColor.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          style: TextStyle(fontSize: 20, color: AppColor.textBlackColor),
          minLines: minLine,
          maxLines: maxLine,
          autocorrect: false,
          controller: textController,
          keyboardType: keybordType,
          decoration: InputDecoration(
            hintText: placeholder,
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 16, color: AppColor.textBlackColor),
          ),
        ),
      ),
    );
  }
}
