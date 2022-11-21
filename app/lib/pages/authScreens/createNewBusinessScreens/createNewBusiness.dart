import 'dart:async';

import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/widgets/weekDayCell/weekDayCell.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../core/localStore/localStore.dart';
import '../../../utils/LocationFinder.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../authManager/models/businessCatModel.dart';

class CreateNewBusinessScreen extends StatefulWidget {
  bool update;
  bool timing;
  String? red;
  CreateNewBusinessScreen(
      {Key? key, this.red, this.update = false, this.timing = true})
      : super(key: key);

  @override
  State<CreateNewBusinessScreen> createState() =>
      _CreateNewBusinessScreenScreenState();
}

class _CreateNewBusinessScreenScreenState
    extends State<CreateNewBusinessScreen> {
  TextEditingController emailTFC = TextEditingController();
  TextEditingController addressTFC = TextEditingController();
  TextEditingController longLatTFC = TextEditingController();
  TextEditingController nameTFC = TextEditingController();
  List<BusinessCatModel> catData = [];
  List<WeekDaysModel> weekDays = [];
  WeekDaysModel? singleSelection;
  StreamController controller = StreamController();
  int? dataIndex = 0;
  var selectAddress = '';
  var code = "";
  var pageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initilizeWeekDays();
    getUserData();
    BusinessApis().getBusinessCat((List) {
      print(List);
      catData = List;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
          title: widget.update == true ? getUpdateTitle() : getTitle(),
          onTap: () {
            if (pageIndex > 0) {
              pageIndex = pageIndex - 1;
              setState(() {});
            } else {
              Navigator.of(context).pop();
            }
          }
          //widget.timing == true
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

  getTitle() {
    if (pageIndex == 0) return LocalString.lblCreateAnBusiness;
    if (pageIndex == 1) return LocalString.lblCreateAnBusiness;
    if (pageIndex == 2) return LocalString.lblBusinessTiming;
  }

  getUpdateTitle() {
    return LocalString.lblBusinessDetails;
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    // initilizeWeekDays();
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 20,
              // ),
              //widget.timing == false
              if (pageIndex == 0)
                Column(
                  children: [
                    Text(
                      LocalString.lblBusinessDescription,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: AppColor.textBlackColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    list(),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTF(
                      controllr: nameTFC,
                      placeholder: LocalString.plcBusinessName,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTF(
                      controllr: emailTFC,
                      placeholder: LocalString.plcBusinessEmail,
                    ),
                  ],
                ),
              if (pageIndex == 2) weekDayTimingView(),
              // widget.update == true

              if (pageIndex == 1)
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    UploadImage(),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTF(
                      controllr: addressTFC,
                      placeholder: LocalString.plcAddress,
                      onChange: (p0) {
                        showLocationSelection(
                          "",
                          context,
                          onSelection: (value) {
                            locationPopup(value);
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // CustomTF(
              //   controllr: longLatTFC,
              //   placeholder: LocalString.plcLongLat,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),

              // const SizedBox(
              //   height: 20,
              // ),

              const SizedBox(
                height: 20,
              ),

              CustomButton.regular(
                title: //widget.timing == true
                    pageIndex == 0
                        ? LocalString.lblSave
                        : widget.update == true
                            ? LocalString.lblSave
                            : LocalString.lblSubmit,
                onTap: () {
                  if (pageIndex < 2) {
                    pageIndex = pageIndex + 1;
                    setState(() {});
                  }
                },
              ),
              const SizedBox(
                height: 100,
              ),
            ]),
      ),
    );
  }

  list({data}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.textBlackColor
              //                   <--- border width here
              ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent),
      child: DropdownButton(
        underline: const SizedBox(),
        value: dataIndex,
        elevation: 35,
        borderRadius: BorderRadius.circular(20),
        dropdownColor: AppColor.newBgcolor,
        isExpanded: true,
        focusColor: Colors.transparent,
        items: List.generate(catData.length + 1, (index) {
          final String data = (index < 1)
              ? "Choose category"
              : catData[index - 1].name.toString();
          return DropdownMenuItem(value: index, child: Text(data));
        }).toList(),
        onChanged: (value) {
          // Update State
          dataIndex = value;
          setState(() {});
        },
      ),
    );
  }

  UploadImage() {
    return DottedBorder(
      color: Colors.black,
      borderType: BorderType.RRect,
      radius: Radius.circular(8),
      strokeWidth: 1,
      child: Container(
        height: 100,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_circle_outline_outlined)),
            Text(
              "Upload Business Image",
              style: TextStyle(fontSize: 16),
            ),
            // Container(
            //   decoration: BoxDecoration(color: AppColor.buttonColor),
            //   child: CustomButton.regular(
            //     width: 100,
            //     title: LocalString.lblUpload,
            //     onTap: () {},
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  weekDayTimingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SizedBox(
        //   height: 20,
        // ),
        // Container(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         "Days to open",
        //         textAlign: TextAlign.left,
        //         style: TextStyle(
        //           fontSize: 15,
        //           fontWeight: FontWeight.normal,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        StreamBuilder(
            stream: controller.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return weeklist();
            }),
      ],
    );
  }

  initilizeWeekDays() {
    weekDays = [
      WeekDaysModel(
        name: "Monday",
        value: "1",
        selected: false,
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Tuesday",
        value: "2",
        selected: false,
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Wednesday",
        value: "3",
        selected: false,
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Thursday",
        value: "4",
        selected: false,
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Friday",
        value: "5",
        selected: false,
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Saturday",
        value: "6",
        selected: false,
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Sunday",
        value: "7",
        selected: false,
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
    ];
  }

  Widget weeklist() {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(weekDays[index].selected);
              weekDays[index].selected = !weekDays[index].selected!;
              // if (singleSelection != null) {
              //   if (weekDays[index].selected == true) {
              //     weekDays[index].startime = singleSelection.startime;
              //     weekDays[index].endtime = singleSelection.endtime;
              //   }
              // }
              // if (weekDays[index].selected == false) {
              //   weekDays[index].startime.timeStr = "";
              //   weekDays[index].endtime.timeStr = "";
              // }
              // setState(() {
              //   weekDays[index].selected = !weekDays[index].selected;
              // });
              // print(weekDays[index].selected);
              controller.add(weekDays[index].selected);
              List<String> idsDays = [];
              weekDays.forEach((elementCate) {
                if (elementCate.selected!) {
                  idsDays.add(elementCate.value!);
                }
              });
              preSetTime(weekDays[index].selected!, index);
              print(idsDays);
            },
            child: WeekDaysCell(
              data: weekDays[index],
              onChangeEndTime: (PickUpDateTime et) {
                weekDays[index].endtime = et;

                if (singleSelection == null) {
                  singleSelection = weekDays[index];
                } else {
                  if (singleSelection != null) {
                    if (weekDays[index].endtime!.timeStr != "") {
                      if (singleSelection!.endtime!.timeStr == "") {
                        singleSelection = weekDays[index];
                      }
                    }
                  }
                }

                ///  preFillTime();
              },
              onChangeStartTime: (PickUpDateTime st) {
                weekDays[index].startime = st;
                if (singleSelection == null) {
                  singleSelection = weekDays[index];
                } else {
                  if (singleSelection != null) {
                    if (weekDays[index].startime!.timeStr != "") {
                      if (singleSelection!.startime!.timeStr == "") {
                        singleSelection = weekDays[index];
                      }
                    }
                  }
                }

                //print(
                //    "singleSelection.startime.timeStr ${singleSelection.startime.timeStr}");
              },
              onClose: () {
                preFillTime();
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: weekDays.length);
  }

  preSetTime(bool value, index) {
    if (singleSelection != null) {
      if (singleSelection!.startime!.timeStr != "" &&
          singleSelection!.endtime!.timeStr != "") {
        if (value) {
          weekDays[index].startime = singleSelection!.startime;
          weekDays[index].endtime = singleSelection!.endtime;
        } else {
          weekDays[index].startime = PickUpDateTime(timeStr: "");
          weekDays[index].endtime = PickUpDateTime(timeStr: "");
        }

        setState(() {});
      }
    }
  }

  preFillTime() {
    if (singleSelection != null) {
      if (singleSelection!.startime!.timeStr != "" &&
          singleSelection!.endtime!.timeStr != "") {
        // if (!firstTimeIntialized) {
        //   firstTimeIntialized = true;
        // }
        allIsEmptyTime((value) {
          if (!value) {
            for (int index = 0; index < weekDays.length; index++) {
              if (weekDays[index].selected!) {
                weekDays[index].startime = singleSelection!.startime;
                weekDays[index].endtime = singleSelection!.endtime;
              }
            }
            setState(() {});
          }
        });
      }
    }
  }

  locationPopup(String value) {
    {
      if ("Automatic" == value) {
        LocationDetector().getLocation().then((value) async {
          await LocalStore().setaddress(value!.address);

          print("-----******----- ${value.state} ${value.address}");
          setAddress();
        });
      } else {
        LocationDetector().handlePressButton(context, code).then((value) async {
          print(
              "-----******----- ${value!.address}   ${value.lat} ${value.long}");
          await LocalStore().setaddress(value.address);
          setAddress();
        });
      }
    }
  }

  allIsEmptyTime(onSuccess) {
    bool fillAny = false;
    if (singleSelection != null) {
      for (int index = 0; index < weekDays.length; index++) {
        if (singleSelection!.value != weekDays[index].value) {
          if (weekDays[index].startime!.timeStr != "" &&
              weekDays[index].endtime!.timeStr != "") {
            fillAny = true;
            break;
          }
        }
      }
      onSuccess(fillAny);
      return;
    }
    onSuccess(fillAny);
  }

  getUserData() async {
    // Constant.homeProvider.getUserData();

    code = await LocalStore().getCuntrycode();
    setState(() {});
    var selectAddress1 = await LocalStore().getaddress();

    await LocationDetector().getLocation();
    if (selectAddress1 == '') {
      await LocationDetector().getLocation();
      setAddress();
    } else {
      setAddress();
    }
  }

  setAddress() async {
    var code1 = await LocalStore().getCuntrycode();
    var selectAddress1 = await LocalStore().getaddress();
    var latLong = await LocalStore().getLatLong();
    print("-1-" + code1);
    print("---" + selectAddress1);

    setState(() {
      code = code1;
      selectAddress = selectAddress1;
      addressTFC.text = selectAddress;
      longLatTFC.text = latLong.first + "/" + latLong.last;
    });
  }
}
