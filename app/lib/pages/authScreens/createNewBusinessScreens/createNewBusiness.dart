import 'dart:async';
import 'dart:io';

import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/CongratsScreen.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/bookingLinkScreen.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/depositsScreen.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';
import 'package:daly_doc/widgets/weekDayCell/weekDayCell.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/localStore/localStore.dart';
import '../../../utils/LocationFinder.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../authManager/models/businessCatModel.dart';
import '../authManager/models/userBusinesModel.dart';

class CreateNewBusinessScreen extends StatefulWidget {
  bool update;
  bool timing;
  String? red;
  UserBusinessModel? userBusinessData;
  List<WeekDaysModel>? weekDays;

  CreateNewBusinessScreen(
      {Key? key,
      this.red,
      this.update = false,
      this.timing = false,
      this.userBusinessData,
      this.weekDays})
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
  UserBusinessModel? UserBusinessData;
  List<WeekDaysModel> weekDays = [];
  WeekDaysModel? singleSelection;
  int? dataIndex = 0;
  String lat = "";
  String long = "";
  String imageUrl = "";
  BusinessCatModel? _selected;
  StreamController controller = StreamController();

  var selectAddress = '';
  var code = "";
  var pageIndex = 0;
  String businessCategoryId = "0";

  File? image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("PANGEINDEx${widget.timing}");
    if (widget.timing) {
      initilizeWeekDays();
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getBusinessDetail();
    });
  }

  getBusinessDetail() async {
    UserBusinessModel? userBiz = await BusinessApis().getUserBusinessDetail();

    if (widget.timing == true) {
      UserBusinessData = userBiz;
      weekDays = UserBusinessData!.timing!;
      setState(() {});
    }
    if (widget.update == true) {
      if (userBiz != null) {
        UserBusinessData = userBiz;

        emailTFC.text = UserBusinessData!.businessEmail.toString();
        nameTFC.text = UserBusinessData!.businessName.toString();

        lat = UserBusinessData!.lat.toString();
        long = UserBusinessData!.lng.toString();
        businessCategoryId = UserBusinessData!.businessCategoryId.toString();
        addressTFC.text = UserBusinessData!.businessAddress.toString();
        imageUrl = UserBusinessData!.businessImg.toString();

        setState(() {});
      }
    }
    BusinessApis().getBusinessCat((List) {
      print(List);
      catData = List;
      if (UserBusinessData != null) {
        catData.forEach((element) {
          if (UserBusinessData!.businessCategoryId == element.id) {
            _selected = element;
          }
        });
      }
      setState(() {});
    });

    if (widget.update == true) {
      // UserBusinessData = widget.userBusinessData;
      // emailTFC.text = UserBusinessData!.businessEmail.toString();
      // nameTFC.text = UserBusinessData!.businessName.toString();
      // dataIndex = UserBusinessData!.userBusinessCategory!.id;

      setState(() {});
    }
    if (widget.timing == true) {
      if (weekDays.isNotEmpty) {
        setState(() {});
      } else {
        initilizeWeekDays();
      }
    }

    if (widget.timing == false) {
      getUserData();
    }

    if (widget.timing == false) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: widget.update == true
            ? getUpdateTitle()
            : widget.timing == true
                ? LocalString.lblBusinessTiming
                : getTitle(),
        // onTap: () {
        //   if (pageIndex > 0) {
        //     pageIndex = pageIndex - 1;
        //     setState(() {});
        //   } else {
        //     Navigator.of(context).pop();
        //   }
        // }
        // //widget.timing == true
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
    if (pageIndex == 0) return LocalString.lblCreateBusiness;
    if (pageIndex == 1) return LocalString.lblCreateBusiness;
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
              if (widget.timing == false && pageIndex == 0 || pageIndex == 1)
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
                    dropDown(),
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
              if (pageIndex == 2 || widget.timing == true) weekDayTimingView(),
              // widget.update == true

              if (pageIndex == 1 || widget.update == true)
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    UploadImage(),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        CustomTF(
                          controllr: addressTFC,
                          placeholder: LocalString.plcAddress,
                          enabled: false,
                          onChange: (p0) {},
                        ),
                        Positioned(
                          child: Container(
                            color: AppColor.newBgcolor,
                            child: InkWell(
                              child: Icon(Icons.gps_fixed),
                              onTap: () {
                                showLocationSelection(
                                  "",
                                  context,
                                  onSelection: (value) {
                                    locationPopup(value);
                                  },
                                );
                              },
                            ),
                          ),
                          right: 10,
                          top: 15,
                        )
                      ],
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
                    widget.update == true
                        ? LocalString.lblSave
                        : widget.update == true
                            ? LocalString.lblSave
                            : LocalString.lblSubmit,
                onTap: () async {
                  if (widget.update == false && widget.timing == false) {
                    BusinessApis().createBusiness(
                        name: nameTFC.text,
                        email: emailTFC.text,
                        businessCategoryId: businessCategoryId.toString(),
                        onSuccess: () {
                          //Navigator.pop(context);
                          //Navigator.pop(context);
                          Routes.pushSimple(
                              context: context,
                              child: CongratsScreenBusiness());
                        });
                  } else if (widget.update == true && widget.timing == false) {
                    var id = await LocalStore().getBusinessId();
                    BusinessApis().updateBusiness(
                        id: id,
                        name: nameTFC.text,
                        image: image == null ? "" : image!.path.toString(),
                        lat: lat,
                        long: long,
                        address: addressTFC.text,
                        email: emailTFC.text,
                        businessCategoryId: businessCategoryId.toString(),
                        onSuccess: () {
                          Navigator.pop(context);
                        });
                  } else if (widget.timing == true) {
                    BusinessApis().createBusinesTiming(
                        weekDays: weekDays,
                        onSuccess: () {
                          Navigator.pop(context);
                        });
                    // Routes.pushSimple(
                    //     context: context, child: DepositScreens());
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
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Expanded(
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              //alignedDropdown: true,
              child: DropdownButton<BusinessCatModel>(
                hint: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: new Text(
                    "Category",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                value: _selected,
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (BusinessCatModel? newValue) {
                  setState(() {
                    _selected = newValue;
                  });
                  if (_selected != null) {
                    businessCategoryId = _selected!.id.toString();
                  }
                },
                items: catData.map((BusinessCatModel map) {
                  return new DropdownMenuItem<BusinessCatModel>(
                    value: map,
                    // value: _mySelection,
                    child: Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              map.name!,
                              overflow: TextOverflow.visible,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 17),
                              maxLines: 2,
                            )),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ]),
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
        // underline: Container(
        //   height: 2,
        //   color: Colors.black,
        // ),
        value: dataIndex,
        elevation: 50,
        borderRadius: BorderRadius.circular(20),
        dropdownColor: AppColor.newBgcolor,
        isExpanded: true,
        focusColor: Colors.transparent,
        items: [],
        // items: List.generate(catData.length + 1, (index) {
        //   final String data = (index < 1)
        //       ? "Choose category"
        //       : catData[index - 1].name.toString();
        //   return DropdownMenuItem(value: index, child: Text(data));
        // }).toList(),
        onChanged: (value) {
          // Update State
          // print(value);
          // print(businessCategoryId);
          // businessCategoryId = int.parse(catData[value!].id.toString());
          // print("businessCategoryId ${businessCategoryId}");
          // dataIndex = value;
          // setState(() {});
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
        height: 150,
        width: double.infinity,
        child: image == null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  if (image == null)
                    if (imageUrl != "")
                      Container(
                        height: 150,
                        child: ImageLoadFromURL(
                          imgURL: HttpUrls.WS_BASEURL + imageUrl,
                        ),
                      ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            showImageSelectDialog("Upload Business Logo");
                          },
                          icon: Icon(Icons.add_circle_outline_outlined)),
                      Text(
                        "Upload Business Image",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              )
            : InkWell(
                onTap: () {
                  showImageOptions(
                    "",
                    context,
                    onSelection: (value) {
                      imageOptionPopup(value);
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
      ),
    );
  }

  weekDayTimingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
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
        name: "Sunday",
        value: "1",
        id: "0",
        selected: false,
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Monday",
        value: "2",
        id: "0",
        selected: false,
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Tuesday",
        value: "3",
        selected: false,
        id: "0",
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Wednesday",
        value: "4",
        id: "0",
        selected: false,
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Thursday",
        value: "5",
        selected: false,
        id: "0",
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Friday",
        value: "6",
        selected: false,
        id: "0",
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
      WeekDaysModel(
        name: "Saturday",
        value: "7",
        selected: false,
        id: "0",
        endtime: PickUpDateTime(timeStr: ""),
        startime: PickUpDateTime(timeStr: ""),
      ),
    ];
  }

  Widget weeklist() {
    int buttonClickCount = 0;
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              buttonClickCount = buttonClickCount + 1;

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
              // if (buttonClickCount == 0) {
              //   print(buttonClickCount);

              // }
              // if (weekDays[index].endtime!.timeStr == "") {
              //   // preSetTime(weekDays[index].selected!, index);
              // }
              print(idsDays);
            },
            child: WeekDaysCell(
              data: weekDays[index],
              onChangeEndTime: (PickUpDateTime et) {
                // weekDays[index].endtime = et;

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
                // weekDays[index].startime = st;
                print("kkkllll${weekDays[index].startime!.timeStr}");
                if (singleSelection == null) {
                  singleSelection = weekDays[index];
                } else {
                  if (singleSelection != null) {
                    if (weekDays[index].startime!.timeStr != "") {
                      if (singleSelection!.startime!.timeStr == "") {
                        singleSelection = weekDays[index];
                      }
                    }
                    controller.add("");
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

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      print(imageTemp);
      imageUrl = "";
      setState(() => this.image = imageTemp);
      print(imageTemp);

      // Navigator.pop(context);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      print(imageTemp);
      imageUrl = "";
      setState(() => this.image = imageTemp);

      print(imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
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

  showImageSelectDialog(msg,
      {bool pop = false,
      VoidCallback? onTap,
      barrierDismiss = false,
      String btnName = "OK"}) {
    var alert = AlertDialog(
      title: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(msg)
          ],
        ),
      ),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton.regular(
              width: 100,
              title: "Gallery",
              onTap: () {
                pickImageFromGallery();
                Navigator.pop(context);
              },
            ),
            CustomButton.regular(
              width: 100,
              title: "Camera",
              onTap: () {
                pickImageFromCamera();
              },
            )
          ],
        )
      ],
    );

    showDialog(
        barrierDismissible: false, //barrierDismiss,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
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

  imageOptionPopup(String value) {
    if ("Delete" == value) {
      image = null;
      setState(() {});
    } else {
      print(value);
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
      lat = latLong.first;
      long = latLong.last;
    });
  }
}
