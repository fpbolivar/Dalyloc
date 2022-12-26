import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/getUserDetails.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/bankDetailModel.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userDataModel.dart';
import 'package:daly_doc/pages/userProfile/userProfile.dart';
import 'package:daly_doc/widgets/CountryPicker/src/CountryModels/country.dart';
import 'package:daly_doc/widgets/CountryPicker/src/CountryPicker.dart';
import 'package:daly_doc/widgets/customTF/countryPickerTF.dart';
import 'package:daly_doc/widgets/customTF/phoneTF.dart';

import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../../../widgets/CountryPicker/care_country_picker.dart';

class BankDetailFormView extends StatefulWidget {
  String? red;
  BankDetailFormView({Key? key, this.red}) : super(key: key);

  @override
  State<BankDetailFormView> createState() => _BankDetailFormViewState();
}

class _BankDetailFormViewState extends State<BankDetailFormView> {
  TextEditingController routingNumberTFC = TextEditingController();
  TextEditingController accountTFC = TextEditingController();
  TextEditingController cnfAccountTFC = TextEditingController();
  TextEditingController bankNameTFC = TextEditingController();

  TextEditingController cityTFC = TextEditingController();

  TextEditingController stateTFC = TextEditingController();
  TextEditingController accountHolderNameTF = TextEditingController();
  TextEditingController postalCodeTFC = TextEditingController();
  TextEditingController mobileNoTFC = TextEditingController();
  TextEditingController addressTFC = TextEditingController();
  TextEditingController countryTF = TextEditingController();
  String countryCode = "";
  String countryName = "";
  String dob = "";
  String email = "";
  String defaultDialCode = "";
  String phoneNo = "";
  BankDetailModel? oldBankDetail;
  String heading = "Add Bank";
  var manager = UserDetailsApi();
  List<Country> countryData = [];
  Country? country;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setup(defaultDialCodeTemp: "us");
      getBankDetail();
      getUserProfiledata();
    });
  }

  getBankDetail() async {
    oldBankDetail = await BusinessApis().getBankDetail();
    if (oldBankDetail != null) {
      bankNameTFC.text = oldBankDetail!.bank_name ?? "";
      accountHolderNameTF.text = oldBankDetail!.holder_name ?? "";
      accountTFC.text = oldBankDetail!.account_number ?? "";
      cnfAccountTFC.text = oldBankDetail!.account_number ?? "";
      routingNumberTFC.text = oldBankDetail!.routing_number ?? "";
      heading = "Update Bank";
      cityTFC.text = oldBankDetail!.city ?? "";
      addressTFC.text = oldBankDetail!.address ?? "";
      stateTFC.text = oldBankDetail!.state ?? "";
      postalCodeTFC.text = oldBankDetail!.postal_code ?? "";

      //defaultDialCode = "in";
      setup(defaultDialCodeTemp: oldBankDetail!.country!.toLowerCase());

      //
      setState(() {});
    }
  }

  getUserProfiledata() async {
    UserDetailModel? data = await manager.getUserData();
    dob = data?.dateOfBirth ?? "";
    phoneNo = data?.mobile_no ?? "";
    email = data?.email ?? "";

    print("### dob $dob}");
    print("### phoneNo $phoneNo}");
    print("### email $email}");
    if (dob.trim().isEmpty || phoneNo.trim().isEmpty || email.trim().isEmpty) {
      showConfirmAlertWithBtnName(
          "Please fill your email || Phone No. || Date of birth",
          btnName: "Go to profile", onDismissTap: () {
        Navigator.of(context).pop();
      }, onTap: () {
        Routes.pushSimple(
            context: context,
            child: UserProfileViewScreen(),
            onBackPress: () {
              getUserProfiledata();
            });
      });
    } else {
      mobileNoTFC.text = "${data?.country_code}${phoneNo}";
      setState(() {});
    }
  }

  void setup({defaultDialCodeTemp = ""}) {
    countryData = countryCodes
        .map((countryData) => Country.fromJson(countryData))
        .toList();
    List<Country> temp = [];
    print("defaultDialCodeTemp${defaultDialCodeTemp}");
    if (defaultDialCodeTemp == "") {
      temp = countryData.where((element) => element.code == "us").toList();
    } else {
      temp = countryData
          .where((element) => element.code == defaultDialCodeTemp)
          .toList();
    }
    if (temp.isEmpty) {
      temp = countryData.where((element) => element.code == "us").toList();
    }

    if (temp.length > 0) {
      country = temp.first;
      if (temp.isNotEmpty) {
        countryCode = country!.code;
        countryName = country!.name;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.textWhiteColor,
      appBar: CustomAppBarPresentCloseButton(
        title: "$heading",
        subtitle: "Detail",
        fontSize: 18,
        subfontSize: 20,
        topSubPadding: 3,
        needShadow: false,
        needHomeIcon: false,
        colorNavBar: AppColor.textWhiteColor,
        subtitleColor: AppColor.textGrayBlue,
      ),
      body: BackgroundCurveView(
          color: AppColor.textWhiteColor,
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
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   LocalString.lblSignUpDescription,
              //   textAlign: TextAlign.left,
              //   style: TextStyle(
              //       fontWeight: FontWeight.w400,
              //       fontSize: 15,
              //       color: AppColor.textBlackColor),
              // ),
              const SizedBox(
                height: 5,
              ),
              verifyBankStatusView(context),

              CustomTF(
                controllr: bankNameTFC,
                placeholder: LocalString.plcBankName,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTF(
                controllr: accountHolderNameTF,
                placeholder: LocalString.plcAccountHolderName,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTF(
                password: true,
                obscureText: true,
                controllr: accountTFC,
                placeholder: LocalString.plcAccountNumber,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTF(
                password: true,
                obscureText: true,
                controllr: cnfAccountTFC,
                placeholder: LocalString.plcConfirmAccountNumber,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTF(
                controllr: routingNumberTFC,
                placeholder: LocalString.plcRoutingNumber,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Routes.presentSimple(
                      context: context,
                      child: CountryPicker(
                        countryCode: country!.code,
                        onSelection: (data) {
                          country = data;
                          countryCode = data.code;
                          countryName = data.name;
                          print("Choose $countryName}");
                          print("Choose $countryCode}");
                          setState(() {});
                        },
                      ));
                },
                child: CountryPickerTF(
                  controllr: countryTF,
                  defaultCountryName: countryName,
                  keyBoardType: TextInputType.phone,
                  placeholder: LocalString.plcMobileNo,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTF(
                      controllr: cityTFC,
                      placeholder: LocalString.plcCity,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomTF(
                      controllr: stateTFC,
                      placeholder: LocalString.plcState,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTF(
                controllr: addressTFC,
                placeholder: LocalString.plcBankAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTF(
                controllr: postalCodeTFC,
                placeholder: LocalString.plcPostalCode,
              ),
              const SizedBox(
                height: 20,
              ),

              CustomTF(
                controllr: mobileNoTFC,
                enabled: false,
                placeholder: LocalString.plcMobileNo,
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton.regular(
                  title: LocalString.lblSubmit,
                  onTap: () {
                    if (dob.trim().isEmpty ||
                        phoneNo.trim().isEmpty ||
                        email.trim().isEmpty) {
                      showConfirmAlertWithBtnName(
                          "Please fill your email || Phone No. || Date of birth",
                          btnName: "Go to profile", onDismissTap: () {
                        Navigator.of(context).pop();
                      }, onTap: () {
                        Routes.pushSimple(
                            context: context,
                            child: UserProfileViewScreen(),
                            onBackPress: () {
                              getUserProfiledata();
                            });
                      });
                    } else {
                      BusinessApis().addBankDetail(
                          isUpdate: oldBankDetail != null,
                          bankID: oldBankDetail != null
                              ? oldBankDetail!.bank_stripe_id ?? ""
                              : "",
                          context: context,
                          country: countryCode,
                          bankName: bankNameTFC.text,
                          accountHolderName: accountHolderNameTF.text,
                          accountNumber: accountTFC.text,
                          cfmaccountNumber: cnfAccountTFC.text,
                          routingNumber: routingNumberTFC.text,
                          userName: "",
                          city: cityTFC.text,
                          state: stateTFC.text,
                          address: addressTFC.text,
                          postalCode: postalCodeTFC.text,
                          mobileNo: mobileNoTFC.text,
                          onSuccess: () {
                            getBankDetail();
                          });
                    }
                  }),
              const SizedBox(
                height: 100,
              ),
            ]),
      ),
    );
  }

  Widget verifyBankStatusView(context) {
    return oldBankDetail == null
        ? Container()
        : oldBankDetail!.bank_reason != ""
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                    child: Container(
                  //height: 44,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColor.theme.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "❌ ${oldBankDetail!.bank_reason}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                )),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                    child: Container(
                  //height: 44,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: oldBankDetail!.bank_status == "1"
                        ? AppColor.stripGreen.withOpacity(0.5)
                        : AppColor.stripOrange.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        oldBankDetail!.bank_status == "1"
                            ? "✅ Your bank detail is verified."
                            : "⏳ Bank verification is under progress.Wait for 2-3 hours.",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                )),
              );
  }
}
