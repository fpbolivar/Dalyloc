import 'dart:async';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/Apis/PrayerApis.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/components/playerResponseItem.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/views/payersListView.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../models/prayerModel.dart';

class PrayerDetailView extends StatefulWidget {
  PrayerModel? prayerData;

  PrayerDetailView({Key? key, this.prayerData})
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
        title: widget.prayerData!.prayerTitle!,
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: bodyDesign(),
        ),
      )),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CustomButton.regular(
            title: "Answered", //widget.prayerData!.prayerStatus!.capitalize(),
            background: Color(0XFF2E7316),
            // widget.prayerData!.prayerStatus!.toLowerCase() != "answered"
            //     ? Color(0XFFD82121)
            //     : Color(0XFF2E7316),
            onTap: () {
              if (widget.prayerData!.prayerStatus!.toLowerCase() !=
                  "answered") {
                PrayerApis().changePrayerStatus(
                    id: widget.prayerData!.id,
                    onSuccess: () {
                      Navigator.pop(context);
                    });
              } else {
                showAlert("The Prayer is already answered");
              }
              // Routes.pushSimple(context: context, child: PrayerView());
            },
          ),
        ),
      ),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data("Note", widget.prayerData!.prayerNote),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Response",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              widget.prayerData!.response!.length == 0
                  ? Text("No Response by Administration.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ))
                  : listResponse()
            ],
          )
          // data("Response", widget.prayerData!.response),
        ],
      ),
    );
  }

  data(title, note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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

  listResponse() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var item = widget.prayerData!.response![index];
          return InkWell(
              onTap: () {},
              child: PlayerResponseItem(
                item: item,
                index: index + 1,
              ));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: widget.prayerData!.response!.length);
  }
}
