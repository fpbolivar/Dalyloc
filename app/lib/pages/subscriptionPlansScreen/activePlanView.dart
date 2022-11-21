import 'dart:ui';

import 'package:daly_doc/pages/notificationScreen/components/sectionRowlistView.dart';
import 'package:daly_doc/pages/notificationScreen/model/SectionItemModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/planDetailView.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

import '../settingsScreen/ApiManager/AllPlansApiManager.dart';
import 'components/freeItemView.dart';
import 'components/planItemView.dart';
import 'model/PlanInfoModel.dart';

class ActivePlanView extends StatefulWidget {
  String? red;
  ActivePlanView({Key? key, this.red}) : super(key: key);

  @override
  State<ActivePlanView> createState() => _ActivePlanViewState();
}

class _ActivePlanViewState extends State<ActivePlanView> {
  // PlanInfoModel(
  //   title: "Devotional Plan",
  //   price: "\$12.99",
  //   description:
  //       "<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>",
  //   btnTitle: "Manage Subscription",
  //   periodDuration: PlanType.monthly,
  //   contextType: ContentType.choice,
  //   image: "ic_devotional.png"),
  List<PlanInfoModel> data = [];
  List<PlanInfoModel> freePlan = [
    PlanInfoModel(
        title: "Basic Plan",
        description:
            "<ul><li>Create unlimited Tasks.</li><li>Create unlimited Events.</li></ul>",
        periodDuration: PlanType.free,
        contextType: ContentType.text,
        image: "ic_free.png"),
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getActivePlan();
    });
  }

  getActivePlan() {
    AllPlansApiManager().getActivePlan(onSuccess: (List<PlanInfoModel> list) {
      data = list;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "Active",
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
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              headerTitle("Free Plan"),
              const SizedBox(
                height: 10,
              ),
              freelistView(),
              const SizedBox(
                height: 20,
              ),
              headerTitle("Your Subscribed Plan"),
              const SizedBox(
                height: 10,
              ),
              if (data.isNotEmpty) listView(),
              if (data.isEmpty)
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(child: Text("No Plan subscribed yet"))
                  ],
                ),
              //
            ]),
      ),
    );
  }

  Widget headerTitle(title) {
    return Text(
      title.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: AppColor.textBlackColor),
    );
  }

  Widget freelistView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: freePlan.length,
      itemBuilder: (conext, index) {
        return InkWell(
            onTap: () {
              Routes.presentSimple(
                  context: context,
                  child: PlanDetailView(
                    data: freePlan[index],
                  ));
              //onTap!(itemList[index].section ?? 0, index);
            },
            child: FreeItemView(itemData: freePlan[index]));
      },
      separatorBuilder: (BuildContext context, int index) {
        // ignore: prefer_const_constructors
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
        );
      },
    );
  }

  Widget listView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (conext, index) {
        return InkWell(
            onTap: () {
              Routes.presentSimple(
                  context: context,
                  child: PlanDetailView(
                    data: data[index],
                  ),
                  onBackPress: (value) {
                    if (value.toString() == true.toString()) {
                      getActivePlan();
                    }
                  });
            },
            child: PlanItemView(itemData: data[index]));
      },
      separatorBuilder: (BuildContext context, int index) {
        // ignore: prefer_const_constructors
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
        );
      },
    );
  }
}
