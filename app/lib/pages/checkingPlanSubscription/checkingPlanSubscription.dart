import 'dart:convert';
import 'dart:math' as math;
import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealEnum.dart';
import 'package:daly_doc/pages/paymentPages/components/awesome_card.dart';
import 'package:daly_doc/pages/paymentPages/helper/validatorCard.dart';
import 'package:daly_doc/pages/settingsScreen/ApiManager/AllPlansApiManager.dart';
import 'package:daly_doc/pages/settingsScreen/model/allPlanMode.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/planMonthlyYearlyView.dart';

import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:daly_doc/widgets/customRoundButton/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class CheckSubscriptionView extends StatefulWidget {
  CheckSubscriptionView(
      {required this.activeStatus,
      required this.typeOfOperation,
      required this.title});
  Function(bool)? activeStatus;
  MealTypePlan? typeOfOperation;
  String? title;
  @override
  _CheckSubscriptionViewState createState() => _CheckSubscriptionViewState();
}

class _CheckSubscriptionViewState extends State<CheckSubscriptionView> {
  bool isActive = false;
  bool? isCheckingPlanLoading = false;
  MealApis manager = MealApis();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getActiveStatus();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  getActiveStatus() async {
    // noPlanWidget();
    // return;
    isCheckingPlanLoading = true;
    setState(() {});
    bool? status =
        await manager.getActivePlanStatus(type: widget.typeOfOperation!);
    if (status == null) {
      isActive = false;
    } else {
      isActive = status;
      if (isActive) {}
      if (isActive == false) {}
    }
    isCheckingPlanLoading = false;
    widget.activeStatus!(isActive);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      body: BackgroundCurveView(
        child: SafeArea(
            child: isCheckingPlanLoading!
                ? Center(
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )),
                  )
                : SingleChildScrollView(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      noPlanWidget()
                    ],
                  ))),
      ),
    );
  }

  noPlanWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You are not member of ${widget.title} subscription.",
            textAlign: TextAlign.center,
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          Text(
            "For take meal feature, join ${widget.title} subscription.",
            textAlign: TextAlign.center,
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w400,
                fontSize: 13),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton.regular(
                  title: "Refresh",
                  width: 100,
                  height: 30,
                  fontSize: 13,
                  background: Colors.blueAccent,
                  onTap: () {
                    getActiveStatus();
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomButton.regular(
                  title: "Buy",
                  width: 70,
                  height: 30,
                  fontSize: 13,
                  onTap: () {
                    getplanList();
                  },
                )
              ]),
        ],
      ),
    );
  }

  getplanList() {
    isCheckingPlanLoading = true;
    setState(() {});
    AllPlansApiManager().getAllPlans(
        onSuccess: (List<GetAllPlansModel> data) {
          isCheckingPlanLoading = false;
          setState(() {});
          GetAllPlansModel? mealplan;

          data.forEach((element) {
            if (element.typeOfOperation == widget.typeOfOperation!.rawValue) {
              mealplan = element;

              // Routes.pushSimple(context: context, child: MealSettingView());
            }
          });
          if (mealplan != null) {
            Routes.pushSimpleRootNav(
                context: context,
                child: PlanMonthlyYearlyView(
                  title: widget.title ?? "",
                  subscriptionSubPlans: mealplan!.subscriptionSubPlans!,
                ));
          }
        },
        onError: () {});
  }
}
