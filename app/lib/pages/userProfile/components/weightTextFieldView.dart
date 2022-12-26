import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class WeightTextFieldView extends StatefulWidget {
  String leftTitle;
  Function(String)? onChange;
  var text = "";
  Widget? child;
  WeightTextFieldView(
      {super.key, this.leftTitle = "", this.child, this.onChange});

  @override
  State<WeightTextFieldView> createState() => _WeightTextFieldViewState();
}

class _WeightTextFieldViewState extends State<WeightTextFieldView> {
  String weight = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 190,
          clipBehavior: Clip.antiAlias,
          // ignore: sort_child_properties_last
          child: Material(
              elevation: 0,
              color: AppColor.segmentBarBgColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Weight",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColor.textBlackColor),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(children: [
                        Expanded(
                            child: writeReview(
                                placehoder: "Kilogram",
                                maxLength: 5,
                                keyboardType: TextInputType.number)),
                        // SizedBox(
                        //   width: 50,
                        // ),
                        //Expanded(child: Container())
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      CustomButton.regular(
                        title: "Done",
                        width: 70,
                        height: 30,
                        radius: 4,
                        fontSize: 10,
                        onTap: () async {
                          widget.onChange!(widget.text);
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
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
      keyboardType = TextInputType.text,
      maxLength = 100}) {
    return Container(
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
          style: TextStyle(fontSize: 17, color: AppColor.halfGrayTextColor),
          minLines: 1,
          maxLines: 1,
          maxLength: maxLength,
          autocorrect: false,
          controller: textController,
          keyboardType: keyboardType,
          onChanged: (value) async {
            widget.text = value;
          },
          decoration: InputDecoration(
            hintText: placehoder,
            border: InputBorder.none,
            hintStyle:
                TextStyle(fontSize: 17, color: AppColor.halfGrayTextColor),
          ),
        ),
      ),
    );
  }
}
