import 'package:daly_doc/core/helpersUtil/measureUtil.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/editUserProfieApi.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/getUserDetails.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userDataModel.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/pages/userProfile/components/ageTextFieldView.dart';
import 'package:daly_doc/pages/userProfile/components/emailTextFieldView.dart';
import 'package:daly_doc/pages/userProfile/components/heightInchesView.dart';
import 'package:daly_doc/pages/userProfile/components/heightTextFieldView.dart';
import 'package:daly_doc/pages/userProfile/components/otpTextFeild.dart';
import 'package:daly_doc/pages/userProfile/components/phoneTextFieldView.dart';
import 'package:daly_doc/pages/userProfile/components/userNameTFView.dart';
import 'package:daly_doc/pages/userProfile/helper/ageCalculator.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:daly_doc/widgets/dashedLine/dashedView.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import 'package:intl/intl.dart';
import 'components/popMenuView.dart';
import 'components/userHeaderView.dart';
import 'components/userHealthInfoView.dart';
import 'components/weightTextFieldView.dart';

class UserProfileViewScreen extends StatefulWidget {
  String? red;
  UserProfileViewScreen({Key? key, this.red}) : super(key: key);

  @override
  State<UserProfileViewScreen> createState() => _UserProfileViewScreenState();
}

class _UserProfileViewScreenState extends State<UserProfileViewScreen> {
  var manager = UserDetailsApi();
  var phoneControllr = TextEditingController();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      data();
    });
  }

  String token = "";
  String gender = "";
  String age = "";
  String dob = "";
  String feet = "";
  String inches = "";
  String weight = "";
  String height = "";
  String name = "";
  String mobileNo = "";
  String onlyMobileNo = "";
  String originalMobNo = "";
  String ageDuration = "years old";
  String countryCode = "";
  String userEmail = "";
  String formattedDate = "";
  data() async {
    UserDetailModel? data = await manager.getUserData();
    print("31212");
    print("EMAIL ${data?.email}");
    if (data != null) {
      countryCode = data.country_code ?? "";
    }
    userEmail = data?.email ?? "";
    // setState(() async {
    token = await LocalStore().getToken();

    name = await LocalStore().get_nameofuser();

    mobileNo = await LocalStore().get_MobileNumberOfUser();
    originalMobNo = mobileNo;
    onlyMobileNo = mobileNo;
    phoneControllr.text = onlyMobileNo;
    age = await LocalStore().getAge();
    height = await LocalStore().getHeightOfUser();
    gender = await LocalStore().getGenderOfUser();
    weight = await LocalStore().getWeightOfUser();
    dob = await LocalStore().getDOB();
    var cm = double.tryParse(height) ?? 0.0;

    // });
    if (dob != null) {
      if (dob != "") {
        DateTime dd = TaskManager().dateObjFromStr(dob);
        calculateAge(dd);
      }
    }

    // String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
    mobileNo = "$countryCode $mobileNo";
    setState(() {});
    calcuationFeet(height);
  }

  calcuationFeet(text) {
    if (text == "") {
      return;
    }
    Map<String, int> obj = convertCMtoFtIn(double.parse(text));
    print(obj);
    feet = obj["keyFoot"].toString();
    inches = obj["keyInches"].toString();
    if (obj["keyFoot"].toString() == "0") {
      feet = "0";
    }
    if (obj["keyInches"].toString() == "0") {
      //inchesController.clear();
      inches = "0";
    }
    setState(() {});
  }

  updateProfile() {
    var updateMobileNo = countryCode.trim() + onlyMobileNo.trim();
    var oldMobileNo = mobileNo.replaceAll(" ", "");
    var phn = "";
    var codeCountryTemp = "";

    if (oldMobileNo.trim() != updateMobileNo.trim()) {
      phn = onlyMobileNo;
      codeCountryTemp = countryCode;
    }
    EditUserDataApi().EdituserData(
        token: token,
        dob: dob,
        age: age,
        weight: weight,
        height: height,
        name: name,
        countryCode: codeCountryTemp,
        mobile: phn,
        email: userEmail,
        gender: gender);
  }

  sendOTP() {
    EditUserDataApi().sendOtpToVerifyPhoneNumber(
        phoneNo: onlyMobileNo.trim(),
        country_code: countryCode.trim(),
        onReceiveOTP: (otp, userID) {
          textAgeWidget(
              context,
              UserOTPTFView(
                oldValue: otp,
                mobileNo: countryCode.trim() + onlyMobileNo.trim(),
                resendOtpChange: () {
                  sendOTP();
                },
                onChange: (text) {
                  if (text.trim() != "") {
                    EditUserDataApi().otpVerifyApi(
                        otp: text.trim(),
                        country_code: countryCode.trim(),
                        uid: userID,
                        onSuccess: () {
                          Navigator.pop(context);
                          mobileNo = countryCode.trim() + onlyMobileNo.trim();
                          setState(() {});
                          updateProfile();
                        });
                  }
                },
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarWithBackButton(
        title: "User detail",
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: bodyDesign(),
        ),
      )),
    );
  }

  calculateAge(DateTime date) {
    DateTime birthday = date;

    DateDuration duration;

    // Find out your age as of today's date 2021-03-08
    duration = AgeCalculator.age(birthday);

    if (duration.years != 0) {
      age = duration.years.toString();
      if (age == "1") {
        ageDuration = "year ago";
      } else {
        ageDuration = "years ago";
      }
    } else if (duration.months != 0) {
      age = duration.months.toString();
      if (age == "1") {
        ageDuration = "month ago";
      } else {
        ageDuration = "months ago";
      }
    } else if (duration.days != 0) {
      age = duration.days.toString();
      if (age == "1") {
        ageDuration = "day ago";
      } else {
        ageDuration = "days ago";
      }
    } else if (duration.years == 0 &&
        duration.months == 0 &&
        duration.days == 0) {
      age = duration.days.toString();
      if (age == "0") {
        ageDuration = "day ago";
      } else {
        ageDuration = "day ago";
      }
    }

    setState(() {});
    print('Your age is $duration'); //
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            UserHeaderView(
              userName: name,
              mobile_no: mobileNo,
              onChange: () {
                textAgeWidget(context, UserTextFieldView(
                  onChange: (text) {
                    if (text.trim() == "") {
                      return;
                    }
                    print("text$text");
                    name = text;
                    setState(() {});
                  },
                ));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 40,
            ),
            UserHealthInfoView(
              leftTitle: "Email Id",
              child: InkWell(
                child: userEmail == ""
                    ? Text("Enter Email")
                    : Text(
                        userEmail,
                        maxLines: 1,
                      ),
                onTap: () async {
                  textAgeWidget(
                      context,
                      UserEmailTFView(
                        oldValue: userEmail,
                        onChange: (text) {
                          userEmail = text;
                          setState(() {});
                        },
                      ));
                },
              ),
            ),
            separatorDashed(),
            UserHealthInfoView(
              leftTitle: "Mobile No",
              child: InkWell(
                child: onlyMobileNo == ""
                    ? Text("Enter Mobile No.")
                    : Text(countryCode + onlyMobileNo),
                onTap: () async {
                  if (originalMobNo == "") {
                    textAgeWidget(
                        context,
                        UserPhoneTFView(
                          phoneControllr: phoneControllr,
                          oldValue: onlyMobileNo,
                          oldCountryCode: countryCode,
                          onCountryCodeChange: (text) {
                            countryCode = text;
                            setState(() {});
                          },
                          onChange: (text) {
                            onlyMobileNo = text;
                            setState(() {});
                          },
                        ));
                  }
                },
              ),
            ),
            separatorDashed(),

            UserHealthInfoView(
              leftTitle: "Date of birth",
              child: InkWell(
                child: dob == "" ? Text("yyyy-MM-dd") : Text(dob),
                onTap: () async {
                  final today = DateTime.now();
                  var newDate =
                      new DateTime(today.year - 14, today.month, today.day);

                  DateTime? pickedDate = await datePickerModal(newDate);

                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate!);
                  print("pickedDate $pickedDate");
                  print("pickedDate $formattedDate");
                  setState(() {
                    dob = formattedDate.toString();
                  });
                  calculateAge(pickedDate);
                },
              ),
            ),
            separatorDashed(),
            UserHealthInfoView(
              leftTitle: "Age",
              child: InkWell(
                child: Text("$age  $ageDuration"),
                onTap: () {
                  ToastMessage.showErrorwMessage(msg: "Select DOB");
                  // textAgeWidget(context, AgeTextFieldView());
                  // Future.delayed(const Duration(seconds: 7), () {
                  //   setState(() async {
                  //     age = await LocalStore().getAge();
                  //   });
                  // });
                },
              ),
            ),
            separatorDashed(),
            UserHealthInfoView(
                leftTitle: "Gender",
                child: InkWell(
                  child: Stack(
                    children: [
                      Positioned(
                          top: 7,
                          left: 0,
                          right: 0,
                          child: Center(
                              child: Text(gender == "" ? "Select" : gender))),
                      PopMenuView(
                        list: ["Male", "Female"],
                        onSelection: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                    ],
                  ),
                  onTap: () {},
                )),

            separatorDashed(),

            UserHealthInfoView(
              leftTitle: "Height",
              heightNeed: true,
              feet: feet,
              inches: inches,
              child: InkWell(
                child: Text("${height} cm"),
                onTap: () {
                  textAgeWidget(
                      context,
                      HeightInchesTextFieldView(
                          feet: feet,
                          cm: height,
                          inches: inches,
                          fromProfile: true,
                          onCm: (value) {
                            print(value);
                            height = value;
                            setState(() {});
                          },
                          onFeet: (value) {
                            print(value);
                            feet = value;
                            setState(() {});
                          },
                          onInches: (value) {
                            print(value);
                            inches = value;
                            setState(() {});
                          }));
                },
              ),
            ),
            separatorDashed(),
            UserHealthInfoView(
              leftTitle: "Weight",
              child: InkWell(
                child: Text("$weight Kg"),
                onTap: () {
                  textAgeWidget(context, WeightTextFieldView(
                    onChange: (text) {
                      weight = text;
                      setState(() {});
                    },
                  ));
                },
              ),
            ),

            // const SizedBox(
            //   height: 20,
            // ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CustomButton.regular(
                title: "Update",
                onTap: () {
                  if (dob.isEmpty) {
                    ToastMessage.showErrorwMessage(msg: "Select D.O.B");
                    return;
                  }
                  if (dob.isEmpty) {
                    ToastMessage.showErrorwMessage(msg: "Select D.O.B");
                    return;
                  }
                  if (gender.isEmpty) {
                    ToastMessage.showErrorwMessage(msg: "Select Gender");
                    return;
                  }
                  if (height.isEmpty) {
                    ToastMessage.showErrorwMessage(msg: "Enter Height");
                    return;
                  }
                  if (weight.isEmpty) {
                    ToastMessage.showErrorwMessage(msg: "Enter Weight");
                    return;
                  }
                  var updateMobileNo = countryCode.trim() + onlyMobileNo.trim();
                  var oldMobileNo = mobileNo.replaceAll(" ", "");
                  print(oldMobileNo.trim());
                  print(updateMobileNo.trim());
                  if (oldMobileNo.trim() != updateMobileNo.trim()) {
                    sendOTP();
                  } else {
                    updateProfile();
                  }
                },
                width: 150,
              ),

              //
            ),
            const SizedBox(
              height: 40,
            ),
          ]),
    );
  }

  Widget separatorDashed() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        DashedLine(
          dashWidth: 5,
          color: AppColor.halfGrayTextColor,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  date() async {
    // if (pickedDate != null) {
    //   print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
    //   String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    //   print(
    //       formattedDate); //formatted date output using intl package =>  2021-03-16
    //   setState(() {
    //     dateInput.text = formattedDate; //set output date to TextField value.
    //   });
    // } else {}
  }

  datePickerModal(DateTime initialDate) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      // initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(1950, 8),
      lastDate: initialDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.theme, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            // textButtonTheme: TextButtonThemeData(
            //   style: TextButton.styleFrom(
            //     primary: Colors.red, // button text color
            //   ),
            // ),
          ),
          child: child!,
        );
      },
    );
  }

  textAgeWidget(context, child) {
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return child;
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }
}
