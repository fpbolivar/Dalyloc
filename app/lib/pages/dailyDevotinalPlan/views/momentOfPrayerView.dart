import 'dart:async';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/checkingPlanSubscription/checkingPlanSubscription.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/views/payersListView.dart';
import 'package:daly_doc/pages/mealPlan/manager/mealEnum.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../Apis/PrayerApis.dart';
import '../models/prayerModel.dart';

class MomentOfPrayerView extends StatefulWidget {
  MomentOfPrayerView({
    Key? key,
  }) : super(key: key);

  @override
  State<MomentOfPrayerView> createState() => _MomentOfPrayerViewScreenState();
}

class _MomentOfPrayerViewScreenState extends State<MomentOfPrayerView> {
  AdminPrayerModel? adminPrayer;
  bool data = false;
  bool isActive = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPrayer();
    });
  }

  getPrayer() {
    PrayerApis().getAdmin((data) {
      print("objectallCatallCatallCatallCat${data}");
      adminPrayer = data;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: LocalString.lblAmomentofPrayer,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CustomButton.regular(
            title: "Continue",
            onTap: () {
              Routes.pushSimple(context: context, child: PrayerView());
            },
          ),
        ),
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: viewMoment()
            /*isActive
                ? viewMoment()
                : CheckSubscriptionView(
                    activeStatus: (value) {
                      setState(() {
                        isActive = value;
                      });
                      print("isActive$isActive");
                    },
                    title: "Devotional",
                    typeOfOperation: MealTypePlan.devotional,
                  )*/
            ),
      )),
    );
  }

  viewMoment() {
    return adminPrayer == null
        ? Center(child: CircularProgressIndicator())
        : bodyDesign();
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Text(
            adminPrayer!.prayerDescription!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            adminPrayer!.writtenby!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w100,
            ),
          ),
          //

          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
