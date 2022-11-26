import 'dart:async';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/views/payersListView.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';

class PrayerDetailView extends StatefulWidget {
  String? title = "";
  String? status = "";
  PrayerDetailView({Key? key, this.status = "Pending", this.title = ""})
      : super(
          key: key,
        );

  @override
  State<PrayerDetailView> createState() => _PrayerDetailViewState();
}

class _PrayerDetailViewState extends State<PrayerDetailView> {
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
        title: widget.title!,
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
          data("Note", LocalString.lblDc1),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          data("Response", LocalString.lblDc1),
          SizedBox(height: MediaQuery.of(context).size.height - 500),
          CustomButton.regular(
            title: widget.status!,
            background: widget.status!.toLowerCase() != "answered"
                ? Colors.red
                : Colors.green,
            onTap: () {
              Routes.pushSimple(context: context, child: PrayerView());
            },
          ),
        ],
      ),
    );
  }

  data(title, note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          note,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
