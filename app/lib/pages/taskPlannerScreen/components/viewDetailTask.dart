import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/core/helpersUtil/shareItemToExternalAppHelper.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/createTaskView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/ApisManager/Apis.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/TaskModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/model/subtaskModel.dart';
import 'package:daly_doc/widgets/ToastBar/flushbar.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:daly_doc/widgets/dashedLine/dashedView.dart';
import '../../../core/colors/colors.dart';
import '../../../core/routes/routes.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class ViewTaskDetail extends StatelessWidget {
  ViewTaskDetail({super.key, required this.item});
  TaskModel item;
  @override
  Widget build(BuildContext context) {
    return _showMultiSubTasks(context);
  }

  _showMultiSubTasks(BuildContext context) {
    return StatefulBuilder(builder: (contextt, setState) {
      return AlertDialog(
        title: Text('Task Detail'),
        contentPadding: EdgeInsets.only(top: 0.0),

        // content: setupAlertDialoadContainer(),
        content: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 30,
              minWidth: MediaQuery.of(context).size.width - 30,
              maxHeight: MediaQuery.of(context).size.height - 100,
              minHeight: 90),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        item.taskName.toString() == ""
                            ? "No Name"
                            : item.taskName.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Note',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(item.note.toString()),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DashedLine(
                        height: 0.5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Sub Task',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (item.subTaskslist!.isEmpty)
                        Column(
                          children: [
                            Text(
                              'Empty Subtask',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      DashedLine(
                        height: 0.5,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ListTileTheme(
                          //contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
                          child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (cxt, index) {
                          SubtaskModel itemInfo = item.subTaskslist![index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                    side: MaterialStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                          width: 1.0, color: Colors.green),
                                    ),
                                    checkColor: Colors.green[900],
                                    activeColor: Colors.transparent,
                                    value: itemInfo
                                        .isCompleted, //data[index].isSelected,
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        itemInfo.isCompleted = value;
                                      });

                                      TaskManager()
                                          .completeMarkSubtaskTaskData(item);
                                    }),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      itemInfo.description ?? "",
                                      textAlign: TextAlign.left,
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: item.subTaskslist!.length,
                      )

                          // ListBody(
                          //   children: provider.serviceByCat.map(_buildItem).toList(),
                          // ),
                          ),
                    ],
                  ),
                  // Positioned(top: 3, right: 4, child: Icon(Icons.share))
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            height: 80,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SquareOptionWidget(context,
                      iconName: "ic_bin",
                      title: "Delete",
                      color: Colors.red.withOpacity(0.3), onTap: () async {
                    ToastMessage.deletedTaskToast(
                        msg: LocalString.msgDeleteTask,
                        OnTap: () async {
                          print("item.serverID ${item.serverID}");

                          if (item.serverID != 0) {
                            TaskManager().storeDeletedID(item.serverID);
                            await TaskApiManager().deleteTask(
                                id: item.serverID.toString(), isSync: true);
                          }

                          print(item.tid);
                          await TaskManager().taskDelete(item.tid);
                          //Navigator.of(context).pop();
                          Constant.taskProvider.startTaskFetchFromDB();
                          Navigator.of(context).pop();
                        });
                  }),
                ),
                Expanded(
                    child: SquareOptionWidget(context,
                        iconName: "ic_pencil", title: "Edit", onTap: () {
                  Navigator.of(context).pop();
                  Routes.pushSimple(
                      context: context,
                      child: CreateTaskView(isUpdate: true, item: item));
                }, color: Colors.cyan.withOpacity(0.3))),
              ],
            ),
          ),
          Container(
            height: 80,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SquareOptionWidget(context,
                      iconName: "ic_complete",
                      title: item.isCompleted == "0"
                          ? "Complete"
                          : "Incomplete", onTap: () async {
                    if (item.isCompleted == "0") {
                      item.isCompleted = "1";
                    } else {
                      item.isCompleted = "0";
                    }

                    await TaskManager()
                        .makeTaskIsCompleted(item.isCompleted, item.tid);
                    Constant.taskProvider.notifyListeners();
                    setState(() {});
                  },
                      color: item.isCompleted == "0"
                          ? Colors.green.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3)),
                ),
                Expanded(
                    child: SquareOptionWidget(context,
                        iconName: "ic_shareArrow", title: "Share", onTap: () {
                  Navigator.of(context).pop();
                  shareTask(item);
                }, color: Colors.purple.withOpacity(0.3))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: CustomButton.regular(
              title: "Dismiss",
              titleColor: Colors.black,
              background: Colors.blue.withOpacity(0.3),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    });
  }

  Widget SquareOptionWidget(BuildContext context,
      {iconName = "", title = "", color, onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(top: 0),
        //width: 100,
        decoration: BoxDecoration(
          color: color,
          //  color: AppColor.theme,
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: bodyView(iconName: iconName, title: title, OnTap: onTap),
      ),
    );
  }

  Widget bodyView({iconName = "", title = "", OnTap}) {
    return InkWell(
      onTap: () {
        OnTap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: 25,
            height: 25,
            child: Image.asset(
              "assets/icons/${iconName}.png",
              width: 25,
              height: 25,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
