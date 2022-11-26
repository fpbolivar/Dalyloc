import 'dart:async';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/views/prayerDetailView.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../devotionalPlanSetting.dart';
import 'addPrayer.dart';

class PrayerView extends StatefulWidget {
  PrayerView({
    Key? key,
  }) : super(key: key);

  @override
  State<PrayerView> createState() => _PrayerViewScreenState();
}

class _PrayerViewScreenState extends State<PrayerView> {
  List data = [
    {
      "prayer": "For Family",
      "status": "answered",
      "subTitle": "Need to pray good!"
    },
    {"prayer": "Prayer for Mornings", "status": "pending", "subTitle": ""},
  ];
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
        title: LocalString.lblPrayer,
        trailingIcon: true,
        trailingIconData: Icon(Icons.settings),
        trailingIconOnTap: () {
          Routes.pushSimple(context: context, child: DevotionalPlanSetting());
        },
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
          prayerlist(data),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          //
          SizedBox(height: MediaQuery.of(context).size.height - 400),
          CustomButton.regular(
            title: "Add",
            onTap: () {
              Routes.pushSimple(context: context, child: AddNewPrayerView());
            },
          ),
        ],
      ),
    );
  }

  Widget prayerlist(List data) {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Routes.pushSimple(
                    context: context,
                    child: PrayerDetailView(
                      status: data[index]['status'].toString().toUpperCase(),
                      title: data[index]['prayer'].toString(),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ListTile(
                  leading: data[index]['status'] == "answered"
                      ? Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 30,
                        )
                      : Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 30,
                        ),
                  title: Text(
                    data[index]['prayer'].toString(),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  subtitle: data[index]['subTitle'].toString() == ""
                      ? null
                      : Text(
                          data[index]['subTitle'].toString(),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: data.length),
    ]);
  }
}
