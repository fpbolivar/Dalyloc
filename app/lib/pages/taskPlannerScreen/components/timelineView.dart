import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';
import '../../../widgets/dashedLine/dashedView.dart';
import '../../../widgets/timeline/timelines.dart';
import 'dashConnectorView.dart';

// ignore: must_be_immutable
class TimelineView extends StatelessWidget {
  TimelineView({
    super.key,
  });

  // @override
  // Widget build(BuildContext context) {
  //   return Text("");
  // }
  @override
  Widget build(BuildContext context) {
    return viewNodeList2();
  }

  viewNodeList2() {
    return ListView.separated(
        padding: EdgeInsets.only(top: 20),
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (cxt, index) {
          double top = index == 0 ? 18.0 : 0.0;
          return Stack(
            children: [
              Container(
                  child: Padding(
                padding: EdgeInsets.only(left: 100, top: 0),
                child: Container(
                  color: AppColor.textGrayBlue,
                  margin: EdgeInsets.only(top: 0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1.5),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: taskListGroupByTime(index, cxt),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
              Positioned(
                top: 30,
                left: 0,
                child: dotStepper(index: index),
              ),
              //WhiteColor Top Line Dot Steeper
              if (index == 0)
                Positioned(
                  top: 0,
                  left: 100,
                  child: Container(
                    width: 5,
                    height: 30,
                    color: Colors.white,
                  ),
                )
            ],
          );
        },
        separatorBuilder: (cxt, index) {
          return Container(
            height: 0,
          );
        },
        itemCount: 5);
  }

  dotStepper({int index = 0}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 0),
      child: Stack(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "08:00 AM",
                  style: TextStyle(color: AppColor.halfGrayTextColor),
                ),
                SizedBox(
                  width: 5,
                ),
                indicator(),
              ]),
        ],
      ),
    );
  }

  taskListGroupByTime(int section, context) {
    return section == 4
        ? SizedBox(height: 60, width: MediaQuery.of(context).size.width + 100)
        : ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (cxt, index) {
              if (section == 0 && index == 0) {
                return itemWakeUpTask();
              } else {
                return itemNormalTask();
              }
            },
            separatorBuilder: (cxt, index) {
              return Container(
                height: 0,
              );
            },
            itemCount: 4);
  }

  Widget indicator() {
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: 5,
            color: Colors.white,
          )),
      child: ContainerIndicator(
        child: Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 1, color: AppColor.halfGrayTextColor)),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: 13.0,
              height: 13.0,
              decoration: BoxDecoration(
                color: AppColor.halfGrayTextColor,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemWakeUpTask() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColor.stripGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wake Up!",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppColor.textWhiteColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "6:00 AM",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.textWhiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemNormalTask() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: AppColor.halfBlueGray,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: AppColor.textGrayBlue,
            )),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "BreakFast Time!",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppColor.theme),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "06:00 AM  07:00 AM",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColor.textGrayBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
