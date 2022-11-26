import 'dart:async';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';

class AddNewPrayerView extends StatefulWidget {
  AddNewPrayerView({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewPrayerView> createState() => _AddNewPrayerViewScreenState();
}

class _AddNewPrayerViewScreenState extends State<AddNewPrayerView> {
  TextEditingController titleTFC = TextEditingController();
  TextEditingController noteTFC = TextEditingController();
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
        title: LocalString.lblLetsPray,
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
          SizedBox(height: 20),
          CustomTF(
            controllr: titleTFC,
            placeholder: LocalString.plcEnterTitle,
          ),
          SizedBox(height: 20),
          CustomTF(
            controllr: noteTFC,
            placeholder: LocalString.plcNeedToAddMoreNotes,
            height: 100,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          //
          SizedBox(height: MediaQuery.of(context).size.height - 400),
          CustomButton.regular(
            title: "Add",
            onTap: () {
              // Routes.pushSimple(
              //     context: context,
              //     child: CreateNewBusinessScreen(
              //       update: true,
              //     ));
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
            return Container(
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
            );
            //       InkWell(
            //           onTap: () {},
            //           child: Row(
            //             children: [

            //               Padding(
            //                 padding: EdgeInsets.only(left: 8.0, right: 8.0),
            //                 child: Container(
            //                     width: MediaQuery.of(context).size.width - 135,
            //                     child: Column(
            //                       children: [

            //                       ],
            //                     )),
            //               ),
            //             ],
            //           ));
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
