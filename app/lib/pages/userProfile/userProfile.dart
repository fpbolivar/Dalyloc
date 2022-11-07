import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/editUserProfieApi.dart';
import 'package:daly_doc/pages/notificationScreen/components/sectionRowlistView.dart';
import 'package:daly_doc/pages/notificationScreen/model/SectionItemModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/pages/userProfile/components/ageTextFieldView.dart';
import 'package:daly_doc/pages/userProfile/components/heightTextFieldView.dart';
import 'package:daly_doc/widgets/dashedLine/dashedView.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      data();
    });
  }

  String token = "";
  String gender = "Male";
  String age = "26";
  String dob = "2022-10-28";
  String feet = "6";
  String inch = "2";
  String weight = "75";
  String name = "";
  String mobileNo = "";
  data() async {
    print("31212");
    // setState(() async {
    token = await LocalStore().getToken();

    name = LocalString.userName;

    mobileNo = LocalString.userMobileNo;
    age = await LocalStore().getAge();
    feet = await LocalStore().getfeet();
    inch = await LocalStore().getInch();
    weight = await LocalStore().getWeightOfUser();
    // });

    setState(() {});
  }

  String formattedDate = "";
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
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 40,
            ),
            UserHealthInfoView(
              leftTitle: "Date of birth",
              child: InkWell(
                child: Text("$dob"),
                onTap: () async {
                  DateTime? pickedDate = await datePickerModal();

                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate!);
                  print("pickedDate $pickedDate");
                  print("pickedDate $formattedDate");
                  setState(() {
                    dob = formattedDate.toString();
                  });
                },
              ),
            ),
            separatorDashed(),
            UserHealthInfoView(
              leftTitle: "Age",
              child: InkWell(
                child: Text("$age years old"),
                onTap: () {
                  textAgeWidget(context, AgeTextFieldView());
                  Future.delayed(const Duration(seconds: 7), () {
                    setState(() async {
                      age = await LocalStore().getAge();
                    });
                  });
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
                          child: Center(child: Text(gender))),
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
              child: InkWell(
                child: Text("$feet feet,$inch inches"),
                onTap: () {
                  textAgeWidget(context, HeightTextFieldView());
                  Future.delayed(const Duration(seconds: 7), () {
                    setState(() async {
                      feet = await LocalStore().getfeet();
                      inch = await LocalStore().getInch();
                    });
                  });
                },
              ),
            ),
            separatorDashed(),
            UserHealthInfoView(
              leftTitle: "Weight",
              child: InkWell(
                child: Text("$weight Kg"),
                onTap: () {
                  textAgeWidget(context, WeightTextFieldView());
                  Future.delayed(const Duration(seconds: 7), () {
                    setState(() async {
                      weight = await LocalStore().getWeightOfUser();
                    });
                  });
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
                  EditUserDataApi().EdituserData(
                      token: token,
                      dob: dob,
                      age: age,
                      weight: weight,
                      feet: feet,
                      inch: inch,
                      name: name,
                      gender: gender);
                },
                width: 150,
              ),

              //
            )
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

  datePickerModal() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      // initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(1950, 8),
      lastDate: DateTime.now(),
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
