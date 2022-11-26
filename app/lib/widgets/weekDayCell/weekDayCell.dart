import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/weekDayCell/timerSelectorWidget.dart';

import '../../core/constant/constants.dart';
import '../../pages/authScreens/authManager/models/businessCatModel.dart';
import '../../utils/exportPackages.dart';

class WeekDaysCell extends StatefulWidget {
  Function(PickUpDateTime) onChangeStartTime;
  Function(PickUpDateTime) onChangeEndTime;
  Function() onClose;
  WeekDaysModel data;
  WeekDaysCell(
      {required this.data,
      required this.onChangeStartTime,
      required this.onChangeEndTime,
      required this.onClose});

  @override
  State<WeekDaysCell> createState() => _WeekDaysCellState();
}

class _WeekDaysCellState extends State<WeekDaysCell> {
  String title = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        widget.data.selected == false
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
        //       Container(
        //         width: 35,
        //         height: 35,
        //         clipBehavior: Clip.antiAlias,
        //         decoration: BoxDecoration(
        //             color: Colors.white,
        //             shape: BoxShape.circle,
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.grey,
        //                 blurRadius: 5.0,
        //                 //    offset: Offset(0, 3)
        //               ),
        //             ]),
        //         child: Icon(Icons.verified_rounded)),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Spacer(),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.data.name!,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),

              SizedBox(
                height: 10,
              ),

              // Spacer(),
            ],
          ),
        ),
        Container(
          width: 150,
          child:
              // TimeSelectorWidget(
              //       textOnly: true,
              //       data: data,
              //       onChangeEndTime: (PickUpDateTime et) {
              //         print("TimeSelectorWidget dsd${et.timeStr}");
              //         this.onChangeEndTime(et);
              //       },
              //       onChangeStartTime: (PickUpDateTime st) {
              //         this.onChangeStartTime(st);
              //         print("TimeSelectorWidget ssd${st.timeStr}");
              //       },
              //       onClose: () {
              //         this.onClose();
              //       },
              //     )
              InkWell(
            onTap: () {
              widget.data.selected == true
                  ? showTimeWidget(context)
                  : showAlert(
                      "Select Week Days",
                    );
            },
            child: Text(
              widget.data.selected == false
                  ? "Closed"
                  : widget.data.startime!.timeStr.toString() == ""
                      ? " Click to set time "
                      : "${widget.data.startime!.timeStr.toString()} - ${widget.data.endtime!.timeStr.toString()}",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        )
      ],
    ));
  }

  showTimeWidget(BuildContext context,
      {bool pop = false,
      VoidCallback? onTap,
      barrierDismiss = false,
      String btnName = "Set",
      String btnName2 = "Cancel",
      String closed = "Closed"}) {
    var alert = Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      child: Container(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  // InkWell(
                  //     onTap: () {
                  //       print(widget.data.selected);
                  //       setState(() {
                  //         widget.data.selected = widget.data.selected!;
                  //       });
                  //     },
                  //     child: Container(
                  //       child: widget.data.selected == false
                  //           ? Icon(
                  //               Icons.circle,
                  //               color: Colors.black38,
                  //               size: 35,
                  //             )
                  //           : Icon(
                  //               Icons.verified_rounded,
                  //               color: AppColor.bgcolor,
                  //               size: 35,
                  //             ),
                  //     )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        child: TimeSelectorWidget(
                      data: widget.data,
                      onChangeEndTime: (PickUpDateTime et) {
                        print("TimeSelectorWidget dsd${et.timeStr}");
                        // this.widget.onChangeEndTime(et);

                        widget.data.endtime = et;

                        print(et.timeStr);
                      },
                      onChangeStartTime: (PickUpDateTime st) {
                        this.widget.onChangeStartTime(st);

                        widget.data.startime = st;

                        print("TimeSelectorWidget ssd${st.timeStr}");
                        // print("TimeSel342432424Widget ssd${st.timeStr}");
                      },
                      onClose: () {
                        this.widget.onClose();
                      },
                    )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton.regular(
                  width: 100,
                  title: btnName,
                  onTap: () {
                    widget.onChangeStartTime(widget.data.startime!);
                    Navigator.of(context).pop();
                    if (onTap != null) {
                      onTap();
                    }
                  },
                ),
                // CustomButton.regular(
                //   width: 100,
                //   title: btnName2,
                //   onTap: () {
                //     Navigator.of(context)
                //         .pop();
                //     if (onTap != null) {
                //       onTap();
                //     }
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );

    showDialog(
        barrierDismissible: false, //barrierDismiss,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
