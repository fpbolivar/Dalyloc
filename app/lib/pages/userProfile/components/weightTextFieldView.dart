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

  Widget? child;
  WeightTextFieldView({super.key, this.leftTitle = "", this.child});

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
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColor.textBlackColor),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(children: [
                        Expanded(child: writeReview(placehoder: "Kilogram")),
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

  Widget writeReview({textController, placehoder = ""}) {
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
          style: TextStyle(fontSize: 25, color: AppColor.halfGrayTextColor),
          minLines: 1,
          maxLines: 1,
          autocorrect: false,
          controller: textController,
          keyboardType: TextInputType.text,
          onChanged: (value) async {
            setState(() {
              weight = value;
            });
            await LocalStore().setWeightOfUser(value);
            print(weight);
          },
          decoration: InputDecoration(
            hintText: placehoder,
            border: InputBorder.none,
            hintStyle:
                TextStyle(fontSize: 25, color: AppColor.halfGrayTextColor),
          ),
        ),
      ),
    );
  }
}
