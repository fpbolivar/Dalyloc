import 'dart:async';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/Apis/PrayerApis.dart';
import 'package:daly_doc/pages/dailyDevotinalPlan/models/prayerCategoryModel.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
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
  PrayerCategoryModel? _selected;
  List<PrayerCategoryModel> catData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCategory();
    });
  }

  getCategory() async {
    List<PrayerCategoryModel>? list = await PrayerApis().getPrayerCategory();
    if (list == null) {
      catData = [];
    } else {
      catData = list;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: LocalString.lblLetsPray,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CustomButton.regular(
            title: "Add",
            onTap: () {
              validationForm();
            },
          ),
        ),
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

  validationForm() {
    if (_selected == null) {
      ToastMessage.showErrorwMessage(msg: "Select category.");
      return;
    }
    if (noteTFC.text.isEmpty) {
      ToastMessage.showErrorwMessage(msg: "Enter note.");
      return;
    }
    PrayerApis().createPrayer(
        note: noteTFC.text,
        id: _selected == null ? "" : _selected!.id,
        onSuccess: () {
          Navigator.pop(context);
        });
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          // CustomTF(
          //   controllr: titleTFC,
          //   placeholder: LocalString.plcEnterTitle,
          // ),
          dropDown(),
          SizedBox(height: 20),
          CustomTF(
            controllr: noteTFC,
            maxlines: 100,
            placeholder: LocalString.plcNeedToAddMoreNotes,
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget dropDown() {
    return Container(
      padding: EdgeInsets.all(5),
      height: 55,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.textBlackColor
              //                   <--- border width here
              ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          //alignedDropdown: true,
          // alignedDropdown: true,
          child: DropdownButton<PrayerCategoryModel>(
            hint: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: new Text(
                "Category",
                style: TextStyle(fontSize: 15),
              ),
            ),
            value: _selected,
            // underline: Container(
            //   height: 2,
            //   color: Colors.white,
            // ),
            isExpanded: true,
            onChanged: (PrayerCategoryModel? newValue) {
              setState(() {
                _selected = newValue;
              });
            },
            items: catData.map((PrayerCategoryModel map) {
              return new DropdownMenuItem<PrayerCategoryModel>(
                value: map,
                // value: _mySelection,
                child: Container(
                  child: Container(
                      padding: EdgeInsets.only(left: 10),
                      // width: MediaQuery.of(context).size.width - 10,
                      child: Text(
                        map.name!,
                        //   overflow: TextOverflow.visible,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                        maxLines: 2,
                      )),
                ),
              );
            }).toList(),
          ),
        ),
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
