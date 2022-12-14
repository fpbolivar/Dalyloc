import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/GroupTaskItemModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';
import '../../../widgets/dashedLine/dashedView.dart';
import '../../../widgets/timeline/timelines.dart';
import '../model/TaskModel.dart';
import 'dashConnectorView.dart';

// ignore: must_be_immutable
class TimelineView extends StatelessWidget {
  TimelineView(
      {super.key,
      required this.taskGroupData,
      required this.onMarkComplete,
      required this.onSelectItem});
  List<GroupTaskItemModel> taskGroupData;

  Function(int, int) onMarkComplete;
  Function(int, int) onSelectItem;

  // @override
  // Widget build(BuildContext context) {
  //   return Text("");
  // }
  @override
  Widget build(BuildContext context) {
    print("taskGroupDaTA L ${taskGroupData.length}");
    taskGroupData.forEach(
      (element) {
        print("taskGroupDataerr ${element.hr}");
        print("taskGroupDataerrt ${element.time}");
      },
    );

    return viewNodeList2();
  }

  viewNodeList2() {
    return ListView.separated(
        padding: EdgeInsets.only(top: 20, bottom: 100),
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (cxt, index) {
          double top = index == 0 ? 18.0 : 0.0;
          print("CAT $index");
          print("CAT ${taskGroupData[index].time}");

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
                child:
                    dotStepper(index: index, time: taskGroupData[index].time),
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
        itemCount: taskGroupData.length);
  }

  dotStepper({int index = 0, time = ""}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 0),
      child: Stack(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 61,
                  child: Text(
                    time,
                    style: TextStyle(
                        color: AppColor.halfGrayTextColor, fontSize: 13),
                  ),
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
    // return section == 4
    //     ? SizedBox(height: 60, width: MediaQuery.of(context).size.width + 100)
    //     :
    print("section$section");
    print("   taskGroupData[section].task!${taskGroupData[section].task!}");

    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (cxt, index) {
          var item = taskGroupData[section].task!;
          print("itemKKKK${item}");
          return item[index].operationType == "wake"
              ? itemWakeUpTask(taskGroupData[section].time)
              : InkWell(
                  child: itemNormalTask(item[index], section, index),
                  onTap: () {
                    onSelectItem(section, index);
                  });

          //
          // if (section == 0 && index == 0) {
          //   return itemWakeUpTask();
          // } else {
          //   return itemNormalTask();
          // }
        },
        separatorBuilder: (cxt, index) {
          return Container(
            height: 0,
          );
        },
        itemCount: taskGroupData[section].task!.length);
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

  Widget itemWakeUpTask(time) {
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
                time,
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

  getBgColor(String operationType) {
    switch (operationType) {
      case "meal":
        return AppColor.mealItemBgColor;

      case "prayer":
        return AppColor.prayerItemBgColor;

      case "appointment":
        return AppColor.appointmentItemBgColor;
      case "exercise":
        return AppColor.exerciseItemBgColor;

      default:
        return AppColor.taskItemBgColor;
    }
  }

  getBoderColor(String operationType) {
    switch (operationType) {
      case "meal":
        return Color(0xFF9C735D);
      case "prayer":
        return Color(0xFF12aa68D);
      case "appointment":
        return Color(0xFFAE9A53);
      case "exercise":
        return Color(0xFF7a66ff);

      default:
        return AppColor.textGrayBlue;
    }
  }

  Widget itemNormalTask(TaskModel item, int section, int row) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: item.isCompleted == "0"
                ? getBgColor(item.operationType)
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.5,
              color: item.isCompleted == "0"
                  ? getBoderColor(item.operationType)
                  : Colors.black54,
            )),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      item.taskName.toString() == ""
                          ? "No Name"
                          : item.taskName.toString(),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          decorationThickness: 1,
                          decorationColor: Colors.black,
                          decoration: item.isCompleted == "0"
                              ? null
                              : TextDecoration.combine(
                                  [TextDecoration.lineThrough]),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColor.theme),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (item.getAllSubtaskCount() > 0)
                    item.operationType == TaskType.meal.rawValue
                        ? Column(children: [
                            Text(
                              "☑ ${item.getAllSubtaskCount()}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: item.isCompleted == "0"
                                    ? AppColor.textGrayBlue
                                    : Colors.black54,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ])
                        : Column(
                            children: [
                              Text(
                                "☑ ${item.getCompleteTaskCount()}/${item.getAllSubtaskCount()}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: item.isCompleted == "0"
                                      ? AppColor.textGrayBlue
                                      : Colors.black54,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                  item.operationType == TaskType.exercise.rawValue
                      ? Text(
                          "${item.startTime}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: item.isCompleted == "0"
                                ? AppColor.textGrayBlue
                                : Colors.black54,
                          ),
                        )
                      : item.operationType == TaskType.meal.rawValue
                          ? Text(
                              "${item.startTime}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: item.isCompleted == "0"
                                    ? AppColor.textGrayBlue
                                    : Colors.black54,
                              ),
                            )
                          : Text(
                              "${item.startTime} - ${item.endTime}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: item.isCompleted == "0"
                                    ? AppColor.textGrayBlue
                                    : Colors.black54,
                              ),
                            ),
                ],
              ),
              if (item.operationType != TaskType.exercise.rawValue &&
                  item.operationType != TaskType.prayer.rawValue)
                Positioned(
                  right: 0,
                  top: 15,
                  child: Container(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                        side: MaterialStateBorderSide.resolveWith(
                          (states) =>
                              BorderSide(width: 1.0, color: AppColor.theme),
                        ),
                        checkColor: AppColor.theme,
                        activeColor: Colors.transparent,
                        value: item.isCompleted == "1",
                        onChanged: (value) {
                          print(value);
                          onMarkComplete(section, row);
                          // setState(() {
                          //   data[index].isSelected = value;
                          // });
                        }),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
