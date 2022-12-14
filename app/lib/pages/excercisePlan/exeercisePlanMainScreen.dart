import 'package:daly_doc/pages/authScreens/authManager/api/getUserDetails.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userDataModel.dart';
import 'package:daly_doc/pages/excercisePlan/manager/exerciseApi.dart';
import 'package:daly_doc/pages/excercisePlan/model/levelWorkOutModel.dart';
import 'package:daly_doc/pages/excercisePlan/model/workoutDataModel.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';
import 'package:daly_doc/widgets/noDataWidget/noDataWidget.dart';
import 'package:daly_doc/widgets/scrollPositionedList/scrollable_positioned_list.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import 'excerciseDetail.dart';

class ExcercisePlanMainScreen extends StatefulWidget {
  List<LevelWorkoutModel>? levelList;
  int? selectedLevel;
  ExcercisePlanMainScreen({Key? key, this.levelList, this.selectedLevel = -1})
      : super(key: key);

  @override
  State<ExcercisePlanMainScreen> createState() =>
      _ExcercisePlanMainScreenScreenState();
}

class _ExcercisePlanMainScreenScreenState
    extends State<ExcercisePlanMainScreen> {
  var manager = UserDetailsApi();
  int pageIndex = 0;
  int _selected = -1;

  bool isLoadingLevel = false;
  var managerExercise = ExerciseAPI();
  List<LevelWorkoutModel> dataLevels = [];
  WorkoutReponseModel? workoutResponse;

  var hiText = "Hi,";
  var name = "Username";
  var isLoadingUserDetail = false;
  var isLoadingWorkout = false;

  ScrollController workOutLevelScrollScontroller = ScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.levelList != null) {
      dataLevels = widget.levelList!;
    }
    if (widget.selectedLevel != -1) {
      _selected = widget.selectedLevel!;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserDetail();
      if (dataLevels.isEmpty) {
        getLevels();
      } else {
        itemScrollController.jumpTo(index: _selected);
        getWorkOutByLevelID();
      }
    });
  }

  getUserDetail() async {
    isLoadingUserDetail = true;
    setState(() {});
    UserDetailModel? data = await manager.getUserData(needLoader: false);
    isLoadingUserDetail = false;

    if (data != null) {
      name = data.name ?? "";
    }
    setState(() {});
  }

  getLevels() async {
    isLoadingLevel = true;
    setState(() {});
    List<LevelWorkoutModel>? data = await managerExercise.getPhysicalLevel();
    isLoadingLevel = false;
    setState(() {});
    if (data != null) {
      dataLevels = data;
      if (_selected == -1) {
        _selected = 0;
        getWorkOutByLevelID();
      }
    } else {
      dataLevels = [];
    }
    setState(() {});
  }

  getWorkOutByLevelID() async {
    isLoadingWorkout = true;
    setState(() {});
    var levelID = dataLevels[_selected].id;
    WorkoutReponseModel? data =
        await managerExercise.getWorkOutByLevelID(levelID: levelID);
    isLoadingWorkout = false;
    setState(() {});
    if (data != null) {
      workoutResponse = data;
    } else {
      workoutResponse = WorkoutReponseModel(explore: [], pending: []);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        needLoader: isLoadingUserDetail,
        onTap: () {
          Navigator.pop(context);
        },
        title: "${hiText} ${name.capitalize()}",
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: bodyDesign()
            // adminPrayer == null
            //     ? Center(child: CircularProgressIndicator())
            //     :

            ),
      )),
    );
  }

  Widget bodyDesign() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        isLoadingLevel
            ? loaderList()
            : dataLevels.length == 0
                ? noWorkOutLevel()
                : workoutLevelView(),
        isLoadingWorkout
            ? Padding(
                padding: const EdgeInsets.only(top: 100),
                child: loaderList(),
              )
            : workoutResponse == null
                ? noWorkOutData()
                : (workoutResponse!.explore!.length == 0 &&
                        workoutResponse!.pending!.length == 0)
                    ? noWorkOutData()
                    : Column(
                        children: [exploreListView(), pendingListView()],
                      )
      ],
    ));
  }

  exploreListView() {
    return Column(
      children: [
        if (workoutResponse != null)
          if (workoutResponse!.explore != null)
            if (workoutResponse!.explore!.length > 0)
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        if (workoutResponse != null)
          if (workoutResponse!.explore != null)
            if (workoutResponse!.explore!.length > 0)
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: dataList(workoutResponse!.explore, "Explore")),
      ],
    );
  }

  pendingListView() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        if (workoutResponse != null)
          if (workoutResponse!.pending != null)
            if (workoutResponse!.pending!.length > 0)
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: workoutResponse!.pending!.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "Pending Workout",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.weightScrollColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showConfirmAlert(
                                      "Do you want to complete workout?",
                                      onTap: () async {
                                    bool? value =
                                        await managerExercise.completeWorkOut(
                                            workOutID: workoutResponse!
                                                .pending![index].workout_id);
                                    if (value != null) {
                                      getWorkOutByLevelID();
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "Complete All",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.weightScrollColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          dataList(
                              workoutResponse!.pending![index].user_workout,
                              ""),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    );
                  }))
      ],
    );
  }

  workoutLevelView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Workout Levels",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        workOutLevellist(),
      ],
    );
  }

  workOutLevellist() {
    return Container(
      height: 40.0,
      child: ScrollablePositionedList.separated(
        itemCount: dataLevels.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _selected = index;
              });
              print(_selected);
              _selected.toString() == index;
              getWorkOutByLevelID();
            },
            child: Container(
              // width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _selected == index
                    ? AppColor.weightScrollColor
                    : Colors.white,
                border: Border.all(color: AppColor.weightScrollColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    dataLevels[index].workout_name.toString(),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16.0,
                        color:
                            _selected == index ? Colors.white : Colors.black),
                  ),
                ),
              ),
            ),
          );
        },
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 10,
          );
        },
      ),
    );
  }

  noWorkOutLevel() {
    return NoDataItemWidget(
      refresh: () {
        getLevels();
      },
      msg: 'Workout Level not found.',
    );
  }

  noWorkOutData() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: NoDataItemWidget(
        refresh: () {
          getWorkOutByLevelID();
        },
        msg: 'Workout not found.',
      ),
    );
  }

  dataList(List<WorkoutDataModel>? data, title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != "")
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: AppColor.weightScrollColor),
            ),
          ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Routes.pushSimple(
                      context: context,
                      child: ExcerciseDetailScreen(
                        title: data[index].workout_name,
                        id: data[index].id,
                      ));
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                data[index].workout_name!,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                data[index].workout_time.toString() +
                                    " Seconds",
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: AppColor.textSubtitle),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          height: 80,
                          width: 100,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0)),
                            color: Colors.white,
                          ),
                          child: ImageLoadFromURL(
                            fit: BoxFit.cover,
                            imgURL: HttpUrls.WS_BASEURL +
                                data[index].workout_image!.toString(),
                          ),
                        )
                        // Image.asset(
                        //   data[index]["image"],
                        //   fit: BoxFit.cover,
                        //   height: 80,
                        // ),
                      ],
                    )),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: data!.length),
      ],
    );
  }
}
