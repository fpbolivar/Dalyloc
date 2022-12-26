import 'package:daly_doc/pages/appoinmentPlan/components/appointmentDetailPopup.dart';
import 'package:daly_doc/pages/appoinmentPlan/components/noDataWidget.dart';

import 'package:daly_doc/pages/authScreens/authManager/models/upcomingAppointmentModel.dart';
import 'package:daly_doc/pages/excercisePlan/exerciseSettingView.dart';
import 'package:daly_doc/pages/excercisePlan/manager/exerciseApi.dart';
import 'package:daly_doc/pages/excercisePlan/model/exerciseSettingModel.dart';
import 'package:daly_doc/pages/excercisePlan/physicalActivityLevelView.dart';
import 'package:daly_doc/widgets/htmlRender/htmlRender.dart';
import 'package:daly_doc/widgets/swipeAction/flutter_swipe_action_cell.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/components/upcomingAppointmentItemView.dart';

class TermsConditionsView extends StatefulWidget {
  TermsConditionsView({
    Key? key,
  }) : super(key: key);

  @override
  State<TermsConditionsView> createState() => _TermsConditionsViewState();
}

class _TermsConditionsViewState extends State<TermsConditionsView> {
  List<UpcomingAppointmentItemModel> savedCardList = [];
  //var manager = PaymentManager();
  late SwipeActionController controller;
  bool isAccepted = false;
  bool isLoading = false;
  bool isNextLoading = false;

  var managerExercise = ExerciseAPI();
  ExerciseSettingModel? data =
      ExerciseSettingModel(option_name: "", option_value: "");
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSetting();
    });
  }

  getSetting() async {
    isLoading = true;
    setState(() {});

    data = await managerExercise.getTermsConditions();
    isLoading = false;
    setState(() {});
    setState(() {});
  }

  acceptTermsConditions() async {
    isNextLoading = true;
    setState(() {});

    await managerExercise.acceptExerciseTermConditions();
    isNextLoading = false;
    setState(() {});

    Routes.pushSimple(
        context: context,
        child: ExerciseSettingView(
          isAdd: true,
        ));
    // Routes.pushSimple(context: context, child: PhysicalActivityLevelView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
        title: "Terms & Conditions",
        subtitle: "",
        fontSize: 18,
        subfontSize: 20,
        topSubPadding: 3,
        needShadow: false,
        needHomeIcon: false,
        // colorNavBar: AppColor.textWhiteColor,
        subtitleColor: AppColor.textGrayBlue,
      ),
      body: BackgroundCurveView(
          //  color: AppColor.navBarWhite,
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLoading
                      ? Padding(
                          padding: EdgeInsets.all(20),
                          child: loaderList(),
                        )
                      : Expanded(child: bodyDesign()),
                  isLoading ? Container() : acceptWidget()

                  // savedCardList.length == 0
                  //     ? Expanded(
                  //         child: NoDataWidget(
                  //         refresh: () {},
                  //       ))
                  //     : Expanded(child: bodyDesign()),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                ])),
      )),
    );
  }

  Widget acceptWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 5),
      child: Container(
        //height: 50,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                  color: Colors.grey, blurRadius: 2.0, offset: Offset(1, 1)),
            ],
            // border: Border.all(width: 0.5, color: Colors.black26),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: isAccepted,
                      onChanged: (value) {
                        isAccepted = value!;
                        setState(() {});
                      },
                      // YOUR COLOR HERE
                      side: BorderSide(color: AppColor.theme, width: 2)),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "I have read and agreed with the terms and conditions.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isNextLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: loaderList(),
                                  )
                                : CustomButton.regular(
                                    height: 30,
                                    width: 100,
                                    fontSize: 14,
                                    title: "Next",
                                    background: isAccepted
                                        ? AppColor.theme
                                        : Colors.grey,
                                    onTap: () {
                                      if (isAccepted) {
                                        acceptTermsConditions();
                                      }
                                    },
                                  )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HTMLRender(
                data: data!.option_value ?? "",
              )
            ]),
      ),
    );
  }
}
