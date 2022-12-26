import 'dart:async';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/Apis/PrayerApis.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/components/prayerItemWidget.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/models/prayerModel.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/views/prayerDetailView.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import 'devotionalPlanSetting.dart';
import 'addPrayer.dart';

class PrayerView extends StatefulWidget {
  PrayerView({
    Key? key,
  }) : super(key: key);

  @override
  State<PrayerView> createState() => _PrayerViewScreenState();
}

class _PrayerViewScreenState extends State<PrayerView> {
  List<PrayerModel> prayersList = [];
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPrayerList();
    });
  }

  getPrayerList() {
    PrayerApis().getPRAYERLIST((data) {
      print("objectobjectobjectobject${data}");
      prayersList = data;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: LocalString.lblPrayer,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CustomButton.regular(
            title: "Add New Prayer",
            onTap: () {
              Routes.pushSimple(
                  context: context,
                  child: AddNewPrayerView(),
                  onBackPress: () {
                    getPrayerList();
                  });
            },
          ),
        ),
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: bodyDesign(),
      )),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            prayerlist(prayersList),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget prayerlist(List<PrayerModel> data) {
    return prayersList.length == 0
        ? Container(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    "Click To Add Prayer",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("|"),
                Text("|"),
                Text("|"),
                Text("|"),
                Text("|"),
                Icon(Icons.arrow_downward),
              ],
            ),
          )
        : Column(children: [
            const SizedBox(
              height: 20,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        print(data[index].id);
                        Routes.pushSimple(
                            context: context,
                            child: PrayerDetailView(
                              prayerData: data[index],
                            ),
                            onBackPress: () {
                              print(" if (value.toString() == true.toString()");

                              getPrayerList();
                            });
                      },
                      child: PrayerItemWidget(
                        item: data[index],
                        count: data[index].response!.length.toString(),
                        onAnswer: () {
                          if (data[index].prayerStatus!.toLowerCase() !=
                              "answered") {
                            PrayerApis().changePrayerStatus(
                                id: data[index].id,
                                onSuccess: () {
                                  //Navigator.pop(context);
                                  getPrayerList();
                                });
                          } else {
                            showAlert("The Prayer is already answered");
                          }
                        },
                      ));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: data.length),
          ]);
  }
}
