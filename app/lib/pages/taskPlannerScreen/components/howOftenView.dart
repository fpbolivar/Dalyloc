import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/widgets/segmentControl/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

enum SegmentOftenType { once, daily, weekly, monthly }

extension SegmentOftenRawValue on SegmentOftenType {
  String get rawValue {
    switch (this) {
      case SegmentOftenType.once:
        return 'once';
      case SegmentOftenType.daily:
        return 'daily';
      case SegmentOftenType.weekly:
        return 'weekly';
      case SegmentOftenType.monthly:
        return 'monthly';
    }
  }
}

extension SegmentOftenTypeValue on String {
  SegmentOftenType get typeValue {
    switch (this) {
      case "once":
        return SegmentOftenType.once;
      case "daily":
        return SegmentOftenType.daily;
      case "weekly":
        return SegmentOftenType.weekly;
      case "monthly":
        return SegmentOftenType.monthly;
      default:
        return SegmentOftenType.once;
    }
  }
}

// ignore: must_be_immutable
class HowOftenViewTask extends StatefulWidget {
  HowOftenViewTask(
      {super.key,
      this.howOften = "",
      this.onSelected,
      this.selectedOften = SegmentOftenType.once});
  String howOften = "";
  Function(String)? onSelected;
  SegmentOftenType selectedOften = SegmentOftenType.once;
  @override
  State<HowOftenViewTask> createState() => _HowOftenViewTaskState();
}

class _HowOftenViewTaskState extends State<HowOftenViewTask> {
  SegmentOftenType selectedData = SegmentOftenType.once;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedData = widget.selectedOften;
  }

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
              child: CustomSlidingSegmentedControl<SegmentOftenType>(
            isStretch: true,
            initialValue: selectedData,
            children: {
              SegmentOftenType.once: Text(
                'Once',
                style: normalStyle(SegmentOftenType.once),
              ),
              SegmentOftenType.daily: Text(
                'Daily',
                style: normalStyle(SegmentOftenType.daily),
              ),
              SegmentOftenType.weekly: Text(
                'Weekly',
                style: normalStyle(SegmentOftenType.weekly),
              ),
              SegmentOftenType.monthly: Text(
                'Monthly',
                style: normalStyle(SegmentOftenType.monthly),
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
              widget.onSelected!(selectedData.rawValue);
              //  selectedData
            },
          )),
        ],
      ),
    );
  }

  normalStyle(SegmentOftenType type) {
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
