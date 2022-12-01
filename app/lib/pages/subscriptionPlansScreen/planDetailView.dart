import 'package:daly_doc/pages/notificationScreen/components/sectionRowlistView.dart';
import 'package:daly_doc/pages/notificationScreen/model/SectionItemModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/settingsScreen/ApiManager/AllPlansApiManager.dart';
import 'package:daly_doc/pages/taskPlannerScreen/createTaskView.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/ToastBar/toastMessage.dart';
import '../../widgets/htmlRender/htmlRender.dart';
import 'components/planItemView.dart';
import 'model/PlanInfoModel.dart';

class PlanDetailView extends StatefulWidget {
  PlanInfoModel? data;
  String? red;
  PlanDetailView({Key? key, this.data}) : super(key: key);

  @override
  State<PlanDetailView> createState() => _PlanDetailViewState();
}

class _PlanDetailViewState extends State<PlanDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: widget.data!.title,
          subtitle: "Plan",
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

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            headerTitle("Features"),
            widget.data!.periodDuration == PlanType.free
                ? HTMLRender(
                    data: widget.data!.description.toString(),
                  )
                : HTMLRender(
                    data: widget.data!.planList?.first.description ?? "",
                  ),

            widget.data!.periodDuration == PlanType.free
                ? freePlanView()
                : paidPlanView()
            //
          ]),
    );
  }

  Widget paidPlanView() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          CustomButton.regular(
            title: "Add to Calendar",
            background: AppColor.stripGreen,
            height: 40,
            fontSize: 15,
            radius: 4,
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          headerTitle("Subscription Detail"),
          Text(
            "Renew on ${widget.data!.end_dateFormat}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColor.textBlackColor),
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton.regular(
            title: "Cancel",
            background: Colors.red,
            height: 40,
            fontSize: 15,
            radius: 4,
            onTap: () {
              ToastMessage.confrimationToast(
                  msg: LocalString.msgCancelPlan,
                  OnTap: () {
                    AllPlansApiManager()
                        .cancelPlan(planId: widget.data!.id.toString());
                  });
            },
          ),
        ]);
  }

  Widget freePlanView() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        CustomButton.regular(
          title: "Create Task / Event",
          background: AppColor.stripGreen,
          height: 40,
          radius: 4,
          fontSize: 15,
          onTap: () {
            Routes.pushSimple(
                context: context,
                child: CreateTaskView(
                  isUpdate: false,
                ));
          },
        ),
        const SizedBox(
          height: 80,
        ),
        Image.asset(
          "assets/icons/ic_basicfree.png",
          width: 100,
          height: 100,
        ),
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          "assets/icons/ic_logoPlacholder.png",
          width: 200,
          height: 30,
        ),
        const SizedBox(
          height: 60,
        ),
      ],
    );
  }

  Widget headerTitle(title) {
    return Text(
      title.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: AppColor.textBlackColor),
    );
  }
}
