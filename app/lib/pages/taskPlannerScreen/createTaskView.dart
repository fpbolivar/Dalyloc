import 'package:daly_doc/pages/taskPlannerScreen/components/howOftenView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/components/timePickerView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:intl/intl.dart';
import '../../../utils/exportPackages.dart';
import '../../utils/exportWidgets.dart';
import 'components/addSubtasksVIew.dart';
import 'components/emailTFView.dart';
import 'components/howlongDurationView.dart';
import 'components/notesTFView.dart';
import 'components/timePickerComponent/homepage.dart';
import 'manager/ApisManager/Apis.dart';
import 'model/TaskModel.dart';
import 'model/subtaskModel.dart';

class CreateTaskView extends StatefulWidget {
  String? red;
  bool? isUpdate;
  TaskModel? item;
  DateTime? date;

  CreateTaskView(
      {Key? key, this.red, this.isUpdate = false, this.item, this.date})
      : super(key: key);

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  var manager = TaskManager();
  var timecController = FixedExtentScrollController();
  var minController = FixedExtentScrollController();
  var interval = 1;
  int indexHrsSelected = 0;
  int indexMinSelected = 0;
  int indexAMPMSelected = 0;
  var hrsData = [];
  var minutesData = [];
  //var finalTime = "09:00 AM";
  var finalTime = "09:00";
  var displayTimeText = "";
  var displayDateText = "";
  var howOften = "once";
  var howLong = "1m";
  var stime = "";
  var etime = "";
  var stime24 = "";
  var etime24 = "";
  var _dateYYYYMMDD = "";
  var utcDateTime = "";
  List<SubtaskModel> subTaskdata = [];
  TextEditingController nameTF = TextEditingController();
  TextEditingController noteTF = TextEditingController();
  bool update = false;
  TaskModel? itemTask;
  SegmentType selectedLongData = SegmentType.first;
  SegmentOftenType selectedOftenData = SegmentOftenType.once;
  DateTime? calenderDefaultDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.date != null) {
      calenderDefaultDate = widget.date;
    } else {
      calenderDefaultDate = DateTime.now();
    }
    if (widget.isUpdate != null) {
      update = widget.isUpdate!;
      if (update) {
        itemTask = widget.item;
        setData();
      }
    }

    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: update ? LocalString.lblUpdate : LocalString.lblCreate,
          subtitle: "Task",
          subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: bodyDesign(),
        ),
      )),
    );
  }

//If Update
  setData() {
    nameTF.text = itemTask!.taskName;
    noteTF.text = itemTask!.note;
    subTaskdata = itemTask!.subTaskslist!;

    selectedLongData = itemTask!.howLong.segmenttype;
    selectedOftenData = itemTask!.howOften.typeValue;
    displayTimeText = itemTask!.startTime + " - " + itemTask!.endTime;
    interval = itemTask!.howLong.segmenttype.interval;
    howOften = itemTask!.howOften;
    stime = itemTask!.startTime;
    etime = itemTask!.endTime;
    _dateYYYYMMDD = itemTask!.dateString;
    // emailTF.text = itemTask!.email;
    // emailTF.text = itemTask!.email;
    // emailTF.text = itemTask!.email;
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              EmaiViewTask(
                controller: nameTF,
              ),
              const SizedBox(
                height: 20,
              ),
              HowLongViewTask(
                selectedData: selectedLongData,
                howLong: (interval, rawValue) {
                  setState(() {
                    this.interval = interval;
                  });
                  howLong = rawValue;
                  calculateTimeUseInterval();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "When?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColor.textBlackColor),
                ),
              ),
              Container(
                  height: 200,
                  child: CustomTimePicker(
                    interval: interval,
                    controller: timecController,
                    minController: minController,
                    displayTimeText: displayTimeText,
                    hrsData: hrsData,
                    minutesData: minutesData,
                    indexAMPMSelected: indexAMPMSelected,
                    indexHrsSelected: indexHrsSelected,
                    indexMinSelected: indexMinSelected,
                    onRefresh: (indexHrsSelectedTemp, indexMinSelectedTemp,
                        indexAMPMSelectedTemp, finalTime) {
                      setState(() {
                        indexHrsSelected = indexHrsSelectedTemp;
                        indexMinSelected = indexMinSelectedTemp;
                        indexAMPMSelected = indexAMPMSelectedTemp;
                      });
                      calculateTimeUseInterval();
                    },
                  )),
              TimePickerViewTask(
                interval: interval,
                displayDateText: displayDateText,
                onDateTap: () {
                  //()
                  showCalendarModalSheet();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              HowOftenViewTask(
                  selectedOften: selectedOftenData,
                  onSelected: (data) {
                    print(data);
                    howOften = data;
                  }),
              const SizedBox(
                height: 20,
              ),
              AddSubTaskViewTask(
                data: subTaskdata,
                onSubmitted: (subTaskdata) {
                  this.subTaskdata = subTaskdata;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              NoteTFViewTask(
                textController: noteTF,
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton.regular(
                title: update ? "Update Task" : "Create Task",
                onTap: () {
                  validateForm();
                  // ToastMessage.showMessage(msg: LocalString.msgEmail);
                  // manager.getAllTask();

                  // manager.saveTaskData();
                },
              ),
              const SizedBox(
                height: 50,
              ),
            ]),
      ),
    );
  }

  validateForm() {
    if (nameTF.text.isEmpty) {
      ToastMessage.showMessage(msg: LocalString.msgTaskName);
    }
    // else if (!Validator.isValidEmail(emailTF.text)) {
    //   ToastMessage.showMessage(msg: LocalString.msgInValidEmail);
    // }
    else if (noteTF.text.isEmpty) {
      ToastMessage.showMessage(msg: LocalString.msgNotes);
    } else {
      if (update) {
        final subtasks = manager.subtaskJSON(this.subTaskdata);
        final subtasksStr = json.encode(subtasks);
        final utcDateTimeTask =
            manager.generateUtcDateTime(date: _dateYYYYMMDD, time: stime24);

        TaskModel data = TaskModel();
        data.tid = itemTask!.tid;
        data.taskName = nameTF.text;
        data.dateString = _dateYYYYMMDD;
        data.endTime = etime;
        data.startTime = stime;
        data.note = noteTF.text;
        data.email = "";
        data.howLong = howLong;
        data.howOften = howOften;
        data.isCompleted = itemTask!.isCompleted;
        data.serverID = itemTask!.serverID;
        data.utcDateTime = utcDateTimeTask;
        data.createTimeStamp = DateTime.now().microsecondsSinceEpoch;

        data.subNotes = subtasksStr;
        manager.updateTaskData(data, () {});
        // TaskApiManager().updateTaskApi(
        //     data: data,
        //     subTask: subtasks,
        //     onSuccess: (value) {
        //       // data.serverID = value;

        //     });
        if (data.serverID != 0) {
          TaskApiManager()
              .updateTaskApi(data: data, subTask: subtasks, isSync: true);
        }
      } else {
        final subtasks = manager.subtaskJSON(this.subTaskdata);
        final subtasksStr = json.encode(subtasks);
        final utcDateTimeTask =
            manager.generateUtcDateTime(date: _dateYYYYMMDD, time: stime24);

        TaskModel data = TaskModel();
        data.taskName = nameTF.text;
        data.email = "";
        data.utcDateTime = utcDateTimeTask;
        data.tid = DateTime.now().microsecondsSinceEpoch;
        data.howLong = howLong;
        data.howOften = howOften;
        data.note = noteTF.text;
        data.endTime = etime;
        data.createTimeStamp = DateTime.now().microsecondsSinceEpoch;
        data.startTime = stime;
        data.dateString = _dateYYYYMMDD;
        data.subNotes = subtasksStr;
        data.isCompleted = "0";
        data.serverID = 0;
        print("${subtasksStr}");
        TaskApiManager().CreateTaskData(
            data: data,
            subTask: subtasks,
            onSuccess: (value) {
              data.serverID = value;
              manager.saveTaskData(data, () {
                noteTF.text = "";
                nameTF.text = "";
                setState(() {});
              });
              // if (value != 0) {

              // }
            });

        // manager.saveTaskData(data, () {
        //   noteTF.text = "";
        //   nameTF.text = "";
        //   TaskApiManager().CreateTaskData(data: data, subTask: subtasks);
        //   setState(() {});
        // });
      }
    }
  }

  showCalendarModalSheet() {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return CalendarAlertView(
          intialDate: DateTime.now(),
          onDateSelect: (date) {
            var _date = TaskManager().dateParseMMddyyyy(date);
            _dateYYYYMMDD = TaskManager().dateParseyyyyMMdd(date);
            setState(() {
              displayDateText = _date;
            });
          },
        );
      },
    );
  }

  setup() {
    hrsSetup();
    minutesSetup();
    timecController = FixedExtentScrollController();
    minController = FixedExtentScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (update == false) {
        displayDateText = manager.dateParseMMddyyyy(calenderDefaultDate!);
        _dateYYYYMMDD = TaskManager().dateParseyyyyMMdd(calenderDefaultDate!);
        timecController.jumpToItem(8);
        minController.jumpToItem(30);
        calculateTimeUseInterval();
      } else {
        displayDateText = manager.dateFromStr(itemTask!.dateString);

        final sTime24hr = manager.timeFromStr(itemTask!.startTime);
        print("sTime24hr${sTime24hr}");

        var ff = sTime24hr.split(":");
        var hr = ff[0].trim();
        var min = ff[1].trim();
        var indexHrCalculate = int.parse(hr);
        var indexMinCalculate = int.parse(min);

        if (indexHrCalculate > 0) {
          indexHrCalculate = indexHrCalculate - 1;
        }
        if (indexMinCalculate > 0) {
          indexMinCalculate = indexMinCalculate;
        }
        print("indexMinCalculate$indexMinCalculate}");
        timecController.jumpToItem(indexHrCalculate);
        minController.jumpToItem(indexMinCalculate);
        setState(() {});
      }
    });
  }

  calculateTimeUseInterval() async {
    String amPm = ""; //indexAMPMSelected == 0 ? "AM" : "PM";
    finalTime = hrsData[indexHrsSelected] +
        ":" +
        minutesData[indexMinSelected] +
        " " +
        amPm;
    String timeParse24 = finalTime;

    var ff = timeParse24.split(":");
    var hr = ff[0].trim();
    var min = ff[1].trim();

    //print(ff);
    TimeOfDay _startTime =
        TimeOfDay(hour: int.parse(hr), minute: int.parse(min));

    var StartTime = DateTime.utc(2022, 01, 01, int.parse(hr), int.parse(min));
    //print("StartTime${StartTime}");
    print(interval);
    var intervalTemp = Duration(minutes: interval);
    var endTime = StartTime.add(intervalTemp);
    // print(endTime);
    // print("endTime${endTime}");
    stime24 = DateFormat("HH:mm").format(StartTime);
    etime24 = DateFormat("HH:mm").format(endTime);

    stime = DateFormat("h:mm a").format(StartTime);
    etime = DateFormat("h:mm a").format(endTime);
    displayTimeText = stime + " - " + etime;
    // print(displayTimeText);
    setState(() {});
  }

  hrsSetup() {
    for (var i = 1; i <= 23; i += 1) {
      if (10 > i) {
        hrsData.add("0${i}");
      } else {
        hrsData.add("${i}");
      }
    }
  }

  minutesSetup() {
    for (var i = 0; i < 60; i += 1) {
      if (10 > i) {
        minutesData.add("0${i}");
      } else {
        minutesData.add("${i}");
      }
    }
  }
}
