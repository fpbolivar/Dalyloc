import 'package:daly_doc/pages/taskPlannerScreen/components/LocationTFView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/components/howOftenView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/components/taskNameTFView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/components/timePickerView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/widgets/GooglePlacesComponents/GooglePlacesList.dart';
import 'package:daly_doc/widgets/GooglePlacesComponents/searchPlaceModel.dart';
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
import 'model/TimeModel.dart';
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

  //var hrsData = [];
  List<TimeModel> hrsData = [];
  List<TimeModel> minutesData = [];
  //var minutesData = [];
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

  var lastHR = "";

  var lastMin = "";
  List<SubtaskModel> subTaskdata = [];
  TextEditingController nameTF = TextEditingController();
  TextEditingController emailTF = TextEditingController();
  TextEditingController noteTF = TextEditingController();
  bool update = false;
  TaskModel? itemTask;
  SegmentType selectedLongData = SegmentType.first;
  SegmentOftenType selectedOftenData = SegmentOftenType.once;
  DateTime? calenderDefaultDate;
  SearchPlacesModel locationSelected =
      SearchPlacesModel(address: "", lat: "", long: "");
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
    stime24 = itemTask!.startTime;
    etime24 = itemTask!.endTime;

    stime = manager.timeFromStr12Hrs(stime24);
    etime = manager.timeFromStr12Hrs(etime24);

    _dateYYYYMMDD = itemTask!.dateString;
    emailTF.text = itemTask!.email == "null" ? "" : itemTask!.email;
    locationSelected.address = itemTask!.location;
    locationSelected.lat = itemTask!.lat;
    locationSelected.long = itemTask!.lng;
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
              TaskNameTFView(
                controller: nameTF,
              ),
              const SizedBox(
                height: 20,
              ),
              EmaiViewTask(
                controller: emailTF,
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
                      if (hrsData[indexHrsSelectedTemp].enable == false) {
                        setState(() {});
                        Future.delayed(Duration(milliseconds: 300), () {
                          timeDisabe();
                        });
                      } else {
                        Future.delayed(Duration(milliseconds: 300), () {
                          //  timeDisabe();
                        });
                        setState(() {
                          indexHrsSelected = indexHrsSelectedTemp;
                          indexMinSelected = indexMinSelectedTemp;
                          indexAMPMSelected = indexAMPMSelectedTemp;
                        });
                      }

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
              InkWell(
                onTap: () {
                  Routes.presentSimple(
                      context: context,
                      child: GooglePlaceListView(
                        onSelection: (selectedPlace) async {
                          locationSelected = selectedPlace;
                          setState(() {});
                          // String pincode = await PlacesSearchManager.getPincode(
                          //     latitude: selectedPlace.lat,
                          //     longitude: selectedPlace.long);
                          // zipcodeTF.text = pincode;
                          // _getLatLng(selectedPlace);
                        },
                      ));
                },
                child: LocationTFViewTask(data: locationSelected),
              ),
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
    print(DateTime.now().microsecondsSinceEpoch);

    if (nameTF.text.isEmpty) {
      ToastMessage.showMessage(msg: LocalString.msgTaskName);
      return;
    }
    if (!emailTF.text.isEmpty) {
      // ToastMessage.showMessage(msg: LocalString.msgEmail);
      if (!Validator.isValidEmail(emailTF.text)) {
        ToastMessage.showMessage(msg: LocalString.msgInValidEmail);
        return;
      }
    }

    if (noteTF.text.isEmpty) {
      ToastMessage.showMessage(msg: LocalString.msgNotes);
      return;
    } else {
      if (update) {
        final subtasks = manager.subtaskJSON(this.subTaskdata);
        final subtasksStr = json.encode(subtasks);
        final utcDateTimeTask =
            manager.generateUtcDateTime(date: _dateYYYYMMDD, time: stime24);
        etime24 = manager.generateUtcTime(time: etime24);
        stime24 = manager.generateUtcTime(time: stime24);
        TaskModel data = TaskModel();
        data.tid = itemTask!.tid;
        data.taskName = nameTF.text;
        data.dateString = _dateYYYYMMDD;
        data.endTime = etime24;
        data.startTime = stime24;
        data.note = noteTF.text;
        data.email = emailTF.text;
        data.howLong = howLong;

        data.howOften = howOften;
        data.isCompleted = itemTask!.isCompleted;
        data.serverID = itemTask!.serverID;
        data.utcDateTime = utcDateTimeTask;
        data.createTimeStamp = DateTime.now().microsecondsSinceEpoch;

        data.subNotes = subtasksStr;
        data.location = locationSelected.address ?? "";
        data.lat = locationSelected.lat ?? "";
        data.lng = locationSelected.long ?? "";
        manager.updateTaskData(data, () {
          Routes.pushSimpleAndReplaced(
              context: context, child: ScheduleCalendarScreen());
          ToastMessage.showSuccessMessage(msg: LocalString.msgUpdateTask);
        }, needAlert: false);
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
        etime24 = manager.generateUtcTime(time: etime24);
        stime24 = manager.generateUtcTime(time: stime24);
        TaskModel data = TaskModel();
        data.taskName = nameTF.text;
        data.email = emailTF.text;
        data.utcDateTime = utcDateTimeTask;
        data.tid = DateTime.now().microsecondsSinceEpoch;
        data.howLong = howLong;
        data.howOften = howOften;
        data.note = noteTF.text;
        data.endTime = etime24;
        data.createTimeStamp = DateTime.now().microsecondsSinceEpoch;
        data.startTime = stime24;
        data.dateString = _dateYYYYMMDD;
        data.subNotes = subtasksStr;
        data.isCompleted = "0";
        data.serverID = 0;

        data.location = locationSelected.address ?? "";
        data.lat = locationSelected.lat ?? "";
        data.lng = locationSelected.long ?? "";
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

                Routes.pushSimpleAndReplaced(
                    context: context, child: ScheduleCalendarScreen());
                // Navigator.of(context).popUntil((route) =>
                //     route.settings.name ==
                //     ScheduleCalendarScreen().runtimeType.toString());

                ToastMessage.showSuccessMessage(
                    msg: LocalString.msgCreatedTask);
              }, needAlert: false);
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
          enablePastDates: false,
          intialDate: DateTime.now(),
          onDateSelect: (date) {
            var _date = TaskManager().dateParseMMddyyyy(date);
            _dateYYYYMMDD = TaskManager().dateParseyyyyMMdd(date);

            setState(() {
              displayDateText = _date;
            });
            timeDisabe();
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
        timeDisabe();
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
        timeDisabe();
        setState(() {});
      }
    });
  }

  timeDisabe() {
    var dt = DateTime.now();
    var currentDate = TaskManager().dateParseyyyyMMdd(dt);
    var time24 = TaskManager().timeFromDATE(dt);

    if (currentDate == _dateYYYYMMDD) {
      var ff = time24.split(":");
      var hr = ff[0].trim();
      var min = ff[1].trim();
      lastHR = hr;
      lastMin = min;
      var indexHrCalculate = int.parse(hr);
      var indexMinCalculate = int.parse(min);
      if (indexMinCalculate <= 30) {
        indexHrCalculate = indexHrCalculate - 1;
      }
      timecController.jumpToItem(indexHrCalculate);
      print("HR timeDisabe ${indexHrCalculate}");
      for (int i = 0; i < indexHrCalculate; i++) {
        hrsData[i].enable = false;
      }
      // var hrGobal = int.tryParse(lastHR) ?? 0;
      // var minGobal = int.tryParse(lastHR) ?? 0;
      // print("HR 2 timeDisabe ${hrGobal}");
      // if (hrGobal == indexHrsSelected) {
      //   for (int i = 0; i < indexMinCalculate; i++) {
      //     minutesData[i].enable = false;
      //   }
      // }
      // minController.jumpToItem(indexMinCalculate + 1);
      calculateTimeUseInterval(
          index: indexHrCalculate, needHideSomeIndex: true);
      setState(() {});
    } else {
      for (var element in hrsData) {
        element.enable = true;
      }
      setState(() {});
    }
  }

  unHideMinute() {
    for (int i = 0; i < minutesData.length; i++) {
      minutesData[i].enable = true;
    }
  }

  calculateTimeUseInterval({needHideSomeIndex = false, index = 0}) async {
    String amPm = ""; //indexAMPMSelected == 0 ? "AM" : "PM";
    if (!needHideSomeIndex) {
      finalTime = hrsData[indexHrsSelected].title +
          ":" +
          minutesData[indexMinSelected].title +
          " " +
          amPm;
    } else {
      finalTime = hrsData[index].title +
          ":" +
          minutesData[indexMinSelected].title +
          " " +
          amPm;
    }
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
      TimeModel obj = TimeModel();
      obj.enable = true;
      if (10 > i) {
        obj.title = "0${i}";
        //hrsData.add("0${i}");
      } else {
        obj.title = "${i}";
        //hrsData.add("${i}");
      }

      hrsData.add(obj);
    }
    print("hrsData ${hrsData.length}");
  }

  minutesSetup() {
    for (var i = 0; i < 60; i += 1) {
      TimeModel obj = TimeModel();
      obj.enable = true;
      if (10 > i) {
        obj.title = "0${i}";
        //  minutesData.add("0${i}");
      } else {
        obj.title = "${i}";
        // minutesData.add("${i}");
      }
      minutesData.add(obj);
    }
  }

  timeHide() {
    for (var i = 0; i < 60; i += 1) {
      // if (10 > i) {
      //   minutesData.add("0${i}");
      // } else {
      //   minutesData.add("${i}");
      // }
    }
  }
}
