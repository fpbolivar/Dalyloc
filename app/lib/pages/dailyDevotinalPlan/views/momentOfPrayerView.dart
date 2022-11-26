import 'dart:async';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/views/payersListView.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';

class MomentOfPrayerView extends StatefulWidget {
  MomentOfPrayerView({
    Key? key,
  }) : super(key: key);

  @override
  State<MomentOfPrayerView> createState() => _MomentOfPrayerViewScreenState();
}

class _MomentOfPrayerViewScreenState extends State<MomentOfPrayerView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: LocalString.lblAmomentofPrayer,
      ),
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
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          const Text(
            LocalString.lblAmomentofPrayerDc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          const Text(
            "Rebecca Barlow Jordan",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w100,
            ),
          ),
          //
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          CustomButton.regular(
            title: "Continue",
            onTap: () {
              Routes.pushSimple(context: context, child: PrayerView());
            },
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
