import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/widgets/segmentControl/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

enum SegmentOftebType { once, daily, weekly, monthly }

// ignore: must_be_immutable
class HowOftenViewTask extends StatefulWidget {
  HowOftenViewTask({
    super.key,
  });

  @override
  State<HowOftenViewTask> createState() => _HowOftenViewTaskState();
}

class _HowOftenViewTaskState extends State<HowOftenViewTask> {
  SegmentOftebType selectedData = SegmentOftebType.once;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How Often?",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColor.textBlackColor),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              child: CustomSlidingSegmentedControl<SegmentOftebType>(
            isStretch: true,
            children: {
              SegmentOftebType.once: Text(
                'Once',
                style: normalStyle(SegmentOftebType.once),
              ),
              SegmentOftebType.daily: Text(
                'Daily',
                style: normalStyle(SegmentOftebType.daily),
              ),
              SegmentOftebType.weekly: Text(
                'Weekly',
                style: normalStyle(SegmentOftebType.weekly),
              ),
              SegmentOftebType.monthly: Text(
                'Monthly',
                style: normalStyle(SegmentOftebType.monthly),
              ),
            },
            innerPadding: EdgeInsets.all(3.0),
            thumbDecoration: BoxDecoration(
              color: AppColor.segmentBarSelectedColor,
              borderRadius: BorderRadius.circular(7),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.segmentBarBgColor.withOpacity(0.5)),
            onValueChanged: (v) {
              print(v);
              setState(() {
                selectedData = v;
              });
            },
          )),
        ],
      ),
    );
  }

  normalStyle(SegmentOftebType type) {
    return type == selectedData
        ? selectedStyle()
        : TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: AppColor.textBlackColor);
  }

  selectedStyle() {
    return TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        color: AppColor.textWhiteColor);
  }
}
