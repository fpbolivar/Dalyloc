import 'dart:async';
import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/timeSlotModel.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userBusinesModel.dart';
import 'package:flutter_share/flutter_share.dart';
import '../../../core/constant/constants.dart';
import '../../../core/helpersUtil/dateHelper.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../../../widgets/headerCalendar/headerCalendarModel.dart';
import '../../../widgets/weekDayCell/weekDayCell.dart';
import '../createNewbusinessScreens/createNewBusiness.dart';

class TimeSlotsAvailabiltyScreens extends StatefulWidget {
  bool timeSlotsAvailabilty;
  TimeSlotsAvailabiltyScreens({Key? key, this.timeSlotsAvailabilty = true})
      : super(key: key);

  @override
  State<TimeSlotsAvailabiltyScreens> createState() =>
      _TimeSlotsAvailabiltyScreensState();
}

class _TimeSlotsAvailabiltyScreensState
    extends State<TimeSlotsAvailabiltyScreens> {
  // bool _isSelected = false;

  static int _len = 10;
  List<bool> isChecked = List.generate(_len, (index) => false);
  int value = -1;
  List<TimeSlotModel> data = [
    TimeSlotModel(
        name: "According to service duration",
        id: "1",
        isChecked: false,
        time: "-1"),
    TimeSlotModel(
        name: "Every 15 minutes", id: "1", isChecked: false, time: "15"),
    TimeSlotModel(
        name: "Every 30 minutes", id: "1", isChecked: false, time: "30"),
    TimeSlotModel(name: "Hourly", id: "1", isChecked: false, time: "60")
  ];
  List<TimeSlotModel> data2 = [
    TimeSlotModel(
      name: "Automatically accept all appointment requests.",
      id: "1",
      isChecked: false,
      time: "0",
    ),
    TimeSlotModel(
      name: "Manually accept or decline all appointment requests",
      id: "1",
      isChecked: false,
      time: "1",
    ),
  ];

  BusinessApis manager = BusinessApis();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSlot();
    });
  }

  getSlot() async {
    UserBusinessModel? tempResponse = await manager.getUserBusinessDetail();
    // await manager.getUserBusinessServices("1");
    var found = false;
    if (tempResponse != null) {
      data.forEach((element) {
        if (element.time == tempResponse.slot_interval.toString()) {
          element.isChecked = true;
          found = true;
        }
      });
      if (tempResponse.is_acceptance == "0") {
        data2[0].isChecked = true;
      } else {
        data2[1].isChecked = true;
      }
      if (found == false) {
        data[0].isChecked = true;
      }
      setState(() {});
    } else {
      setState(() {});
    }
    print(tempResponse!.slot_interval);
    if (tempResponse!.serviceDetail != null) {
      data[0].time = tempResponse.serviceDetail!.service_time;
    }
  }

  clearAllChecked() {
    data.forEach((element) {
      element.isChecked = false;
    });
  }

  clearAllChecked2() {
    data2.forEach((element) {
      element.isChecked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: widget.timeSlotsAvailabilty == true
            ? LocalString.lblTimeSlotsAvailabilty
            : LocalString.lblBookingAcceptance,
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

  Widget bodyDesign() {
    return weeklist(widget.timeSlotsAvailabilty == true ? data : data2);
  }

  Widget weeklist(List<TimeSlotModel> data) {
    return Column(children: [
      SizedBox(
        height: 30,
      ),
      ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  clearAllChecked();
                  clearAllChecked2();
                  data[index].isChecked = true;
                  setState(() {});
                  if (widget.timeSlotsAvailabilty == true) {
                    BusinessApis().setTimeSlot(data[index].time.toString());
                  } else {
                    BusinessApis()
                        .createAcceptance(value: data[index].time.toString());
                  }
                  // data.forEach((element) {
                  //   if (data[index] != element) {
                  //     data[index]["isChecked"] = "true";
                  //     setState(() {});
                  //   } else {
                  //     data[index]["isChecked"] = "false";
                  //     setState(() {});
                  //   }
                  // });
                  // if (data[index]["isChecked"] == "false") {
                  //   // setState(() {
                  //   //   data[index]["isChecked"] = "true";
                  //   // });

                  //
                  // } else if (data[index]["isChecked"] == "true") {
                  //   setState(() {
                  //     data[index]["isChecked"] = "false";
                  //   });
                  //   // data.forEach((element) {
                  //   //   setState(() {
                  //   //     data[index]["isChecked"] = "false";
                  //   //   });
                  //   // });
                  // }

                  // setState(() {});
                },
                child: Row(
                  children: [
                    data[index].isChecked == false
                        ? Icon(
                            Icons.circle,
                            color: Colors.black38,
                            size: 35,
                          )
                        : Icon(
                            Icons.verified_rounded,
                            color: AppColor.bgcolor,
                            size: 35,
                          ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 135,
                        child: Text(
                          data[index].name.toString(),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: data.length),
    ]);
  }
}
