import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/core/helpersUtil/measureUtil.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../core/localStore/localStore.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class HeightInchesTextFieldView extends StatefulWidget {
  String leftTitle;
  String feet;
  String inches;
  String cm;
  bool fromProfile;
  Widget? child;
  Function(String)? onChange;
  Function(String)? onFeet;
  Function(String)? onInches;
  Function(String)? onCm;
  HeightInchesTextFieldView(
      {super.key,
      this.feet = "",
      this.cm = "",
      this.inches = "",
      this.leftTitle = "",
      this.child,
      this.onChange,
      this.fromProfile = false,
      this.onCm,
      this.onInches,
      this.onFeet});

  @override
  State<HeightInchesTextFieldView> createState() =>
      _HeightInchesTextFieldViewState();
}

class _HeightInchesTextFieldViewState extends State<HeightInchesTextFieldView> {
  var text = "";
  TextEditingController cmController = TextEditingController();
  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();
  @override
  void initState() {
    super.initState();
    feetController.text = widget.feet;
    inchesController.text = widget.inches;
    cmController.text = widget.cm;
  }

  calcuationFeet(text) {
    if (text == "") {
      return;
    }
    Map<String, int> obj = convertCMtoFtIn(double.parse(text));
    print(obj);
    feetController.text = obj["keyFoot"].toString();
    inchesController.text = obj["keyInches"].toString();
    if (obj["keyFoot"].toString() == "0") {
      feetController.text = "0";
    }
    if (obj["keyInches"].toString() == "0") {
      //inchesController.clear();
      inchesController.text = "0";
    }
    if (!widget.fromProfile) {
      callBackToSumbitData();
    }
  }

  calcuationCM(text) {
    if (text == "") {
      cmController.text = "";
      return;
    }

    Map<String, int> obj = {};
    var feet = feetController.text;
    var inches = inchesController.text;
    if (feet == "") {
      feet = "0";
    }
    if (inches == "") {
      inches = "0";
    }
    obj["keyFoot"] = int.tryParse(feet) ?? 0;
    obj["keyInches"] = int.tryParse(inches) ?? 0;
    if (feet == "0") {
      //int ft = convertINtoFT(int.tryParse(inches) ?? 0);
      //feetController.text = ft.toString();
    }
    double cm = convertFtIntoCM(obj);
    cmController.text = cm.toStringAsFixed(3);

    if (!widget.fromProfile) {
      callBackToSumbitData();
    }
  }

  callBackToSumbitData() {
    widget.onCm!(cmController.text);
    widget.onFeet!(feetController.text);
    widget.onInches!(inchesController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: widget.fromProfile ? 280 : 250,
          clipBehavior: Clip.antiAlias,
          // ignore: sort_child_properties_last
          child: Material(
              elevation: 0,
              color: widget.fromProfile
                  ? AppColor.segmentBarBgColor
                  : AppColor.newBgcolor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 05),
                      child: Row(children: [
                        Expanded(
                            child: writeReview(
                          placehoder: "cm",
                          title: "Centimeter",
                          textController: cmController,
                          keyboardType: TextInputType.number,
                          onChanged: (p0) async {
                            text = p0;
                            calcuationFeet(text);
                            //await LocalStore().setfeet(p0);
                          },
                        )),
                        // const SizedBox(
                        //   width: 50,
                        // ),
                        // Expanded(
                        //     child: writeReview(
                        //   placehoder: "Inches",
                        //   maxLength: 3,
                        //   keyboardType: TextInputType.phone,
                        //   onChanged: (p1) async {
                        //     await LocalStore().setInch(p1);
                        //   },
                        // ))
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 05),
                      child: Row(children: [
                        Expanded(
                            child: writeReview(
                          placehoder: "Feet",
                          title: "Feet",
                          textController: feetController,
                          keyboardType: TextInputType.number,
                          onChanged: (p0) async {
                            text = p0;
                            calcuationCM(text);
                            //await LocalStore().setfeet(p0);
                          },
                        )),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                            child: writeReview(
                          placehoder: "Inches",
                          title: "Inches",
                          textController: inchesController,
                          keyboardType: TextInputType.number,
                          onChanged: (p0) async {
                            text = p0;
                            calcuationCM(text);
                            //await LocalStore().setfeet(p0);
                          },
                        )),

                        // Expanded(
                        //     child: writeReview(
                        //   placehoder: "Inches",
                        //   maxLength: 3,
                        //   keyboardType: TextInputType.phone,
                        //   onChanged: (p1) async {
                        //     await LocalStore().setInch(p1);
                        //   },
                        // ))
                      ]),
                    ),
                  ),
                  if (widget.fromProfile)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Spacer(),
                          CustomButton.regular(
                            title: "Done",
                            width: 70,
                            height: 30,
                            radius: 4,
                            fontSize: 10,
                            onTap: () {
                              callBackToSumbitData();
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )),
          margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: AppColor.segmentBarBgColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget writeReview(
      {textController,
      placehoder = "",
      title = "Option",
      Function(String)? onChanged,
      keyboardType = TextInputType.number,
      maxLength = 100}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // border: Border.all(
            //   width: 1, //                   <--- border width here
            // ),
            boxShadow: [
              const BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ],
            color: AppColor.textWhiteColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              style: TextStyle(fontSize: 20, color: AppColor.halfGrayTextColor),
              minLines: 1,
              maxLines: 1,
              autocorrect: false,
              controller: textController,
              onChanged: onChanged,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: placehoder,
                border: InputBorder.none,
                hintStyle:
                    TextStyle(fontSize: 18, color: AppColor.halfGrayTextColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
