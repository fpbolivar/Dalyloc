import 'package:daly_doc/core/helpersUtil/measureUtil.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/getUserDetails.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userDataModel.dart';
import 'package:daly_doc/pages/excercisePlan/manager/exerciseApi.dart';
import 'package:daly_doc/pages/excercisePlan/model/levelWorkOutModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/pages/userProfile/components/heightInchesView.dart';
import 'package:daly_doc/pages/userProfile/helper/ageCalculator.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:daly_doc/widgets/noDataWidget/noDataWidget.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import 'exercisePlanMainScreen.dart';

class PhysicalActivityLevelView extends StatefulWidget {
  PhysicalActivityLevelView({
    Key? key,
  }) : super(key: key);

  @override
  State<PhysicalActivityLevelView> createState() =>
      _PhysicalActivityLevelViewState();
}

class _PhysicalActivityLevelViewState extends State<PhysicalActivityLevelView> {
  int _selected = -1;
  bool isLoading = false;
  var manager = ExerciseAPI();
  List<LevelWorkoutModel> dataLevels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  getData() async {
    isLoading = true;
    setState(() {});
    List<LevelWorkoutModel>? data = await manager.getPhysicalLevel();
    isLoading = false;
    setState(() {});
    if (data != null) {
      dataLevels = data;
    } else {
      dataLevels = [];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        fontSize: 18,
        onTap: () {
          Navigator.pop(context);
        },
        title: LocalString.lblLevel,
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: isLoading ? loaderList() : bodyDesign()),
      )),
    );
  }

  button() {
    return CustomButton.regular(
      title: "Continue",
      onTap: () async {
        if (_selected == -1) {
          ToastMessage.showErrorwMessage(msg: "Select Activity Level");
          return;
        }
        await LocalStore().setExerciseIntro('true');
        Routes.pushSimple(
            context: context,
            child: ExcercisePlanMainScreen(
              levelList: dataLevels,
              selectedLevel: _selected,
            ));
      },
    );
  }

  Widget bodyDesign() {
    return dataLevels.length == 0
        ? NoDataItemWidget(
            msg: "Physical Activities Level not found",
            refresh: () {
              getData();
            },
          )
        : physicalActivity();
  }

  Widget physicalActivity() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          LocalString.lblExcercisePlanScreenDc3,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w200,
          ),
        ),

        // This displays the selected fruit name.
        const SizedBox(height: 20),

        Expanded(
          child: list(),
        ),
        //SizedBox(height: MediaQuery.of(context).size.height * 0.4),
        button(),
        const SizedBox(height: 30)
      ],
    );
  }

  list() {
    return ListView.separated(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _selected == index
                    ? AppColor.weightScrollColor
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    _selected = index;
                  });
                  print(_selected);
                  _selected.toString() == index;
                },
                title: Text(
                  dataLevels[index].workout_name.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _selected == index ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: dataLevels.length);
  }
}
