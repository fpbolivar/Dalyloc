import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/widgets/segmentControl/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

enum SegmentType { first, second, third, fourth, fifth, sixth }

enum TestType { segmentation, max, news }

// ignore: must_be_immutable
class HowLongViewTask extends StatefulWidget {
  HowLongViewTask({
    super.key,
  });

  @override
  State<HowLongViewTask> createState() => _HowLongViewTaskState();
}

class _HowLongViewTaskState extends State<HowLongViewTask> {
  SegmentType selectedData = SegmentType.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How long?",
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
              child: CustomSlidingSegmentedControl<SegmentType>(
            isStretch: true,
            children: {
              SegmentType.first: Text(
                '1m',
                style: normalStyle(SegmentType.first),
              ),
              SegmentType.second: Text(
                '15m',
                style: normalStyle(SegmentType.second),
              ),
              SegmentType.third: Text(
                '30m',
                style: normalStyle(SegmentType.third),
              ),
              SegmentType.fourth: Text(
                '45m',
                style: normalStyle(SegmentType.fourth),
              ),
              SegmentType.fifth: Text(
                '1h',
                style: normalStyle(SegmentType.fifth),
              ),
              SegmentType.sixth: Text(
                '1.5h',
                style: normalStyle(SegmentType.sixth),
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

  normalStyle(SegmentType type) {
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
