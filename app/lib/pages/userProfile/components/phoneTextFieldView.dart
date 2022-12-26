import 'package:daly_doc/core/LocalString/localString.dart';
import 'package:daly_doc/core/helpersUtil/validator.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/model/PlanInfoModel.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:daly_doc/widgets/customTF/phoneTF.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/colors/colors.dart';
import '../../../core/localStore/localStore.dart';
import '../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class UserPhoneTFView extends StatelessWidget {
  String leftTitle;
  Widget? child;
  Function(String)? onChange;
  Function(String)? onCountryCodeChange;

  var oldValue = "";
  var oldCountryCode = "";
  UserPhoneTFView(
      {super.key,
      this.oldValue = "",
      this.leftTitle = "",
      this.oldCountryCode = "",
      this.onCountryCodeChange,
      this.phoneControllr,
      this.child,
      this.onChange});

  TextEditingController? phoneControllr = TextEditingController();

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
                      "Mobile Number",
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
                            child: Container(
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
                          child: PhoneTF(
                            defaultDialCode: oldCountryCode,
                            isBorderEnable: false,
                            keyBoardType: TextInputType.phone,
                            controllr: phoneControllr!,
                            onCountryCodeChange: (value) {
                              oldCountryCode = value;
                            },
                            onChange: ((value) {
                              print(value);
                              oldValue = value;
                            }),
                          ),
                        )

                            //     writeReview(
                            //   placehoder: "Input here",
                            //   textController: TextEditingController(text: oldValue),
                            //   keyboardType: TextInputType.emailAddress,
                            //   onChanged: (p0) async {
                            //     text = p0;
                            //   },
                            // )
                            ),
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
                        onTap: () {
                          if (oldValue.isEmpty) {
                            ToastMessage.showErrorwMessage(
                                msg: "Enter phone number");
                            return;
                          }

                          onChange!(oldValue);
                          onCountryCodeChange!(oldCountryCode);
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
}
