import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/widgets/segmentControl/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

enum SegmentType { first, second, third, fourth, fifth, sixth }

enum TestType { segmentation, max, news }

extension SegmentTypeRawValue on SegmentType {
  String get rawValue {
    switch (this) {
      case SegmentType.first:
        return '1m';
      case SegmentType.second:
        return '15m';
      case SegmentType.third:
        return '30m';
      case SegmentType.fourth:
        return '45m';
      case SegmentType.fifth:
        return '1h';
      case SegmentType.sixth:
        return '1.5h';
    }
  }

  int get interval {
    switch (this) {
      case SegmentType.first:
        return 1;
      case SegmentType.second:
        return 15;
      case SegmentType.third:
        return 30;
      case SegmentType.fourth:
        return 45;
      case SegmentType.fifth:
        return 60;
      case SegmentType.sixth:
        return 90;
    }
  }
}

extension SegmentTypeValue on String {
  SegmentType get segmenttype {
    switch (this) {
      case "1m":
        return SegmentType.first;
      case "15m":
        return SegmentType.second;
      case "30m":
        return SegmentType.third;
      case "45m":
        return SegmentType.fourth;
      case "1h":
        return SegmentType.fifth;
      case "1.5h":
        return SegmentType.sixth;
      default:
        return SegmentType.first;
    }
  }
}

// ignore: must_be_immutable
class HowLongViewTask extends StatefulWidget {
  Function(int, String)? howLong;
  SegmentType selectedData = SegmentType.first;
  HowLongViewTask(
      {super.key, this.howLong, this.selectedData = SegmentType.first});

  @override
  State<HowLongViewTask> createState() => _HowLongViewTaskState();
}

class _HowLongViewTaskState extends State<HowLongViewTask> {
  SegmentType selectedData = SegmentType.first;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedData = widget.selectedData;
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
            initialValue: selectedData,
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
              widget.howLong!(selectedData.interval, selectedData.rawValue);
              // switch (selectedData) {
              //   case SegmentType.first:
              //     widget.howLong!(1);
              //     break;
              //   case SegmentType.second:
              //     widget.howLong!(15);
              //     break;
              //   case SegmentType.third:
              //     widget.howLong!(30);
              //     break;
              //   case SegmentType.fourth:
              //     widget.howLong!(45);
              //     break;
              //   case SegmentType.fifth:
              //     widget.howLong!(60);
              //     break;
              //   case SegmentType.sixth:
              //     widget.howLong!(90);
              //     break;
              //   default:
              // }
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
