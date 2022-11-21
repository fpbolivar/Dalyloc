import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';
import '../model/subtaskModel.dart';

// ignore: must_be_immutable
class AddSubTaskViewTask extends StatefulWidget {
  AddSubTaskViewTask({super.key, this.onSubmitted, required this.data});
  Function(List<SubtaskModel>)? onSubmitted;
  List<SubtaskModel> data = [];
  @override
  State<AddSubTaskViewTask> createState() => _AddSubTaskViewTaskState();
}

class _AddSubTaskViewTaskState extends State<AddSubTaskViewTask> {
  List<SubtaskModel> data = [];
  TextEditingController subTaskTF = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
    // data.add(SubtaskModel(isSelected: false, description: "Shoping"));
    // data.add(SubtaskModel(
    //     isSelected: false,
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make"));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Add Subtask:",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColor.textBlackColor),
            ),
            InkWell(
              onTap: () {
                textWidgetAddTask();
              },
              child: Icon(
                Icons.add_circle_outline,
                color: AppColor.theme,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (conext, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(width: 1.0, color: Colors.green),
                      ),
                      checkColor: Colors.green[900],
                      activeColor: Colors.transparent,
                      value: data[index].isCompleted,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          data[index].isCompleted = value;
                        });
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
                        data[index].description ?? "",
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                    width: 20,
                    height: 20,
                    child: InkWell(
                        child: Icon(Icons.delete),
                        onTap: () {
                          List<SubtaskModel> dateTemp = [];
                          dateTemp.addAll(data);
                          dateTemp.removeAt(index);
                          data = dateTemp;
                          widget.onSubmitted!(data);
                          setState(() {});
                        })),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            // ignore: prefer_const_constructors
            return const Divider();
          },
        ),
      ],
    );
  }

  addSubTaskData(String datatext) {
    if (datatext.toString().isNotEmpty) {
      data.insert(
          0,
          SubtaskModel(
              id: DateTime.now().microsecondsSinceEpoch,
              description: datatext,
              isCompleted: false));
      subTaskTF.clear();
      setState(() {});
      widget.onSubmitted!(data);
      Navigator.of(context).pop();
    } else {
      widget.onSubmitted!(data);
      Navigator.of(context).pop();
    }
  }

  textWidgetAddTask() {
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              clipBehavior: Clip.antiAlias,
              // ignore: sort_child_properties_last
              child: Material(
                  elevation: 0,
                  color: AppColor.segmentBarBgColor,
                  child: Column(
                    children: [
                      Expanded(child: writeReview(textController: subTaskTF)),
                      Row(
                        children: [
                          Spacer(),
                          CustomButton.regular(
                            title: "Add",
                            width: 70,
                            height: 30,
                            radius: 4,
                            fontSize: 10,
                            onTap: () {
                              addSubTaskData(subTaskTF.text);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
              margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
              decoration: BoxDecoration(
                color: AppColor.segmentBarBgColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  Widget writeReview({textController}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.segmentBarBgColor.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          style: TextStyle(fontSize: 15, color: AppColor.textBlackColor),
          minLines: 3,
          maxLines: 3,
          autocorrect: false,
          controller: textController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Enter Description",
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 15, color: AppColor.textBlackColor),
          ),
        ),
      ),
    );
  }
}
