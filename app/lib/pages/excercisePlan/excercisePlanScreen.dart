import 'package:daly_doc/core/helpersUtil/measureUtil.dart';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/editUserProfieApi.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/getUserDetails.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userDataModel.dart';
import 'package:daly_doc/pages/excercisePlan/physicalActivityLevelView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/manager/taskManager.dart';
import 'package:daly_doc/pages/userProfile/components/heightInchesView.dart';
import 'package:daly_doc/pages/userProfile/helper/ageCalculator.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import 'exeercisePlanMainScreen.dart';

class ExcercisePlanScreen extends StatefulWidget {
  ExcercisePlanScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ExcercisePlanScreen> createState() => _ExcercisePlanScreenScreenState();
}

class _ExcercisePlanScreenScreenState extends State<ExcercisePlanScreen> {
  int pageIndex = 0;
  int _selected = 0;
  String genderInfo = "";
  var manager = UserDetailsApi();
  TextEditingController weightController = TextEditingController();
  String dobInfo = "";
  String nameInfo = "";
  String feetInfo = "";
  String inchesInfo = "";
  String weightInfo = "";
  String heightInfo = "";
  String ageInfo = "";
  String countryCode = "";
  String ageDuration = "years old";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  getData() async {
    UserDetailModel? data = await manager.getUserData();
    if (data != null) {
      genderInfo = data.gender ?? "";
      heightInfo = data.height ?? "";
      genderInfo = data.gender ?? "";
      weightInfo = data.weight ?? "";
      nameInfo = data.name ?? "";
      weightController.text = weightInfo;
      dobInfo = data.dateOfBirth ?? "";
      var cm = double.tryParse(heightInfo) ?? 0.0;
      calcuationFeet(heightInfo);

      // });
      if (dobInfo != null) {
        if (dobInfo != "") {
          DateTime dd = TaskManager().dateObjFromStr(dobInfo);
          calculateAge(dd);
        }
      }
    }
  }

  calcuationFeet(text) {
    if (text == "") {
      return;
    }
    Map<String, int> obj = convertCMtoFtIn(double.parse(text));
    print(obj);
    feetInfo = obj["keyFoot"].toString();
    inchesInfo = obj["keyInches"].toString();
    if (obj["keyFoot"].toString() == "0") {
      feetInfo = "0";
    }
    if (obj["keyInches"].toString() == "0") {
      //inchesController.clear();
      inchesInfo = "0";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
          fontSize: 18,
          onTap: () {
            if (pageIndex > 0) {
              pageIndex = pageIndex - 1;
              setState(() {});
              print(pageIndex);
            } else {
              Navigator.pop(context);
            }
          },
          title: pageIndex == 0
              ? LocalString.lbltellUsTitle
              : pageIndex == 1
                  ? LocalString.lblHowOldTitle
                  : pageIndex == 2
                      ? LocalString.lblWeight
                      : LocalString.lblheight),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: bodyDesign()
            // adminPrayer == null
            //     ? Center(child: CircularProgressIndicator())
            //     :

            ),
      )),
    );
  }

  button() {
    return CustomButton.regular(
      title: "Continue",
      onTap: () async {
        if (pageIndex < 3) {
          setState(() {
            pageIndex = pageIndex + 1;
            print(pageIndex);
          });
        } else {
          if (genderInfo == "") {
            ToastMessage.showErrorwMessage(msg: "Select Gender");
            return;
          }
          if (dobInfo == "") {
            ToastMessage.showErrorwMessage(msg: "Select Date of Birth");
            return;
          }
          if (weightController.text == "") {
            ToastMessage.showErrorwMessage(msg: "Enter Weight");
            return;
          }
          if (heightInfo == "") {
            ToastMessage.showErrorwMessage(msg: "Enter Height (Centimeter)");
            return;
          }
          var token = await LocalStore().getToken();
          EditUserDataApi().EdituserData(
              token: token,
              dob: dobInfo,
              age: ageInfo,
              weight: weightController.text,
              height: heightInfo,
              name: nameInfo,
              gender: genderInfo,
              onSuccess: () {
                Routes.pushSimple(
                    context: context, child: PhysicalActivityLevelView());
              });
        }
      },
    );
  }

  Widget bodyDesign() {
    return pageIndex == 0
        ? gender()
        : pageIndex == 1
            ? dob()
            : pageIndex == 2
                ? weight()
                : height();
  }

  openCalender() async {
    final today = DateTime.now();
    var newDate = new DateTime(today.year - 13, today.month, today.day);

    DateTime? pickedDate = await datePickerModal(newDate);

    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
    print("pickedDate $pickedDate");
    print("pickedDate $formattedDate");
    setState(() {
      dobInfo = formattedDate.toString();
    });
    calculateAge(pickedDate);
  }

  calculateAge(DateTime date) {
    DateTime birthday = date;

    DateDuration duration;

    // Find out your age as of today's date 2021-03-08
    duration = AgeCalculator.age(birthday);

    if (duration.years != 0) {
      ageInfo = duration.years.toString();
      if (ageInfo == "1") {
        ageDuration = "year ago";
      } else {
        ageDuration = "years ago";
      }
    } else if (duration.months != 0) {
      ageInfo = duration.months.toString();
      if (ageInfo == "1") {
        ageDuration = "month ago";
      } else {
        ageDuration = "months ago";
      }
    } else if (duration.days != 0) {
      ageInfo = duration.days.toString();
      if (ageInfo == "1") {
        ageDuration = "day ago";
      } else {
        ageDuration = "days ago";
      }
    } else if (duration.years == 0 &&
        duration.months == 0 &&
        duration.days == 0) {
      ageInfo = duration.days.toString();
      if (ageInfo == "0") {
        ageDuration = "day ago";
      } else {
        ageDuration = "day ago";
      }
    }

    setState(() {});
    print('Your age is $ageDuration'); //
    print('Your age is $ageInfo'); //
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

  Widget dob() {
    var time = "";

    return Column(
      children: [
        SizedBox(height: 10),
        //  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          LocalString.lblExcercisePlanScreenDc2,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w200,
          ),
        ),
        SizedBox(height: 20),
        // This displays the selected fruit name.

        // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Expanded(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.black26),
                //     borderRadius: BorderRadius.all(Radius.circular(10))),

                child: Container(
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          openCalender();
                        },
                        child: dobTextBoxWidget(
                          placehoder: "DD/MM/YYYY",
                          title: "Date of Birth",
                        ),
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
                // child: CupertinoDatePicker(
                //   mode: CupertinoDatePickerMode.date,
                //   onDateTimeChanged: (DateTime newDateTime) {
                //     print(time);
                //     setState(() {
                //       time = DateFormat("dd/MM/yyyy")
                //           .format(newDateTime)
                //           .toString();
                //     });
                //   },
                //   maximumYear: DateTime.now().year,
                // ),
              ),
              Spacer()
            ],
          ),
        ),
        //  SizedBox(height: MediaQuery.of(context).size.height * 0.32),
        button(),
        const SizedBox(height: 30)
      ],
    );
  }

  Widget gender() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            LocalString.lblExcercisePlanScreenDc,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        // const SizedBox(height: 20),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Expanded(
          child: imageGender(
              imagePath: "assets/icons/Female.png",
              text: "Female",
              selected: genderInfo.toLowerCase() == "female"),
        ),
        // const SizedBox(height: 20),
        //SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Expanded(
          child: imageGender(
              imagePath: "assets/icons/Male.png",
              text: "Male",
              selected: genderInfo.toLowerCase() == "male"),
        ),
        // SizedBox(height: MediaQuery.of(context).size.height * 0.14),
        button(),
        const SizedBox(height: 30)
      ],
    );
  }

  Widget weight() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            LocalString.lblExcercisePlanScreenDc2,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
            child: weightTextField(
          placehoder: "Kg",
          title: "Weight (Kg)",
          textController: weightController,
          keyboardType: TextInputType.number,
          onChanged: (p0) async {},
        ))
        // Expanded(
        //   child: Column(
        //     children: [
        //       RotatedBox(
        //         quarterTurns: 1,
        //         child: Container(
        //           width: 100,
        //           child: CupertinoPicker(
        //             magnification: 1,

        //             useMagnifier: false,

        //             itemExtent: 120,
        //             // This is called when selected item is changed.
        //             onSelectedItemChanged: (int selectedItem) {
        //               setState(() {
        //                 _selected = selectedItem;
        //                 print("${_selected} Kg Weight");
        //               });
        //             },
        //             children: List<Widget>.generate(200, (int index) {
        //               return Center(
        //                 child: RotatedBox(
        //                   quarterTurns: 3,
        //                   child: Text(
        //                     index.toString(),
        //                     style: TextStyle(
        //                         fontSize: 60,
        //                         fontWeight: FontWeight.bold,
        //                         color: AppColor.weightScrollColor),
        //                   ),
        //                 ),
        //               );
        //             }),
        //           ),
        //         ),
        //       ),
        //       Image.asset("assets/icons/Polygon.png"),
        //     ],
        //   ),
        //  ),

        ,
        Spacer(),
        // This displays the selected fruit name.

        //
        //   SizedBox(height: MediaQuery.of(context).size.height * 0.47),
        button(),
        const SizedBox(height: 30)
      ],
    );
  }

  Widget height() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              LocalString.lblExcercisePlanScreenDc2,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          //  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          SizedBox(height: 30),
          HeightInchesTextFieldView(
              feet: feetInfo,
              cm: heightInfo,
              inches: inchesInfo,
              fromProfile: false,
              onCm: (value) {
                print(value);
                heightInfo = value;
                setState(() {});
              },
              onFeet: (value) {
                print(value);
                feetInfo = value;
                setState(() {});
              },
              onInches: (value) {
                print(value);
                inchesInfo = value;
                setState(() {});
              }),
          /*  Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // RotatedBox(
                //     quarterTurns: 1,
                //     child: Image.asset("assets/icons/Polygon.png")),
                // SizedBox(
                //   width: 10,
                // ),
                // Container(
                //   width: 150,
                //   height: MediaQuery.of(context).size.height * 0.4,
                //   child: CupertinoPicker(
                //     magnification: 1.5,
    
                //     useMagnifier: false,
    
                //     itemExtent: 80,
                //     // This is called when selected item is changed.
                //     onSelectedItemChanged: (int selectedItem) {
                //       setState(() {
                //         _selected = selectedItem;
                //       });
                //       print("${_selected}CM Height");
                //     },
                //     children: List<Widget>.generate(200, (int index) {
                //       return Center(
                //         child: Text(
                //           index.toString(),
                //           style: TextStyle(
                //               fontSize: 40,
                //               fontWeight: FontWeight.bold,
                //               color: AppColor.weightScrollColor),
                //         ),
                //       );
                //     }),
                //   ),
                // ),
              ],
            ),
          
          ),
            */
          //   Spacer(),
          // This displays the selected fruit name.

          //
          //SizedBox(height: MediaQuery.of(context).size.height * 0.219),
          button(),
          const SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget imageGender({imagePath, text, bool selected = false}) {
    return Container(
      // width: 120,
      // height: 120,
      child: InkWell(
        onTap: () {
          print(text);
          genderInfo = text.toString().toLowerCase();
          setState(() {});
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(50),
              decoration: new BoxDecoration(
                color: selected ? AppColor.theme : AppColor.bgGenderGrayCircle,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                imagePath.toString(),
                width: 45,
                height: 45,
                color: selected ? Colors.white : AppColor.theme,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget weightTextField(
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
          padding: const EdgeInsets.only(
            bottom: 5,
            left: 5,
          ),
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
        SizedBox(
          height: 10,
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

  Widget dobTextBoxWidget({
    placehoder = "",
    title = "Option",
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 5,
            left: 5,
          ),
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
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                dobInfo == "" ? placehoder : dobInfo,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w200,
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Age: " + ageInfo + " " + ageDuration,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
