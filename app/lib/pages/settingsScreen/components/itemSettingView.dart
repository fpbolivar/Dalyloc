import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';
import '../../../core/colors/colors.dart';
import '../../../utils/exportPackages.dart';
import '../../../widgets/dialogs/CommonDialogs.dart';
import '../../../widgets/weekDayCell/timerSelectorWidget.dart';
import '../../authScreens/authManager/models/businessCatModel.dart';
import '../model/SettingOption.dart';

import 'package:intl/intl.dart';

class SettingItemView extends StatefulWidget {
  SettingItemView({super.key, this.itemData, this.onSelectionBool});
  SettingOption? itemData;
  Function(bool)? onSelectionBool;

  @override
  State<SettingItemView> createState() => _SettingItemViewState();
}

class _SettingItemViewState extends State<SettingItemView> {
  var TimeTF = TextEditingController();

  PickUpDateTime SelectedTime = PickUpDateTime();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initilizeWeekDays();
  }

  WeekDaysModel? weekDays;
  initilizeWeekDays() {
    weekDays = WeekDaysModel(
      name: "Sunday",
      value: "1",
      id: "0",
      selected: false,
      endtime: PickUpDateTime(timeStr: ""),
      startime: PickUpDateTime(timeStr: ""),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Row(
        children: [
          Text(
            widget.itemData!.type! == SettingType.counter
                ? "${widget.itemData!.counter} ${widget.itemData?.title}"
                : "${widget.itemData?.title}",
            style: TextStyle(
                color: widget.itemData!.type! == SettingType.logout
                    ? Colors.red
                    : Colors.black,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          if (widget.itemData!.type! == SettingType.loading &&
              widget.itemData!.type! != SettingType.refresh)
            const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                )),
          if (widget.itemData!.type! == SettingType.counter)
            SizedBox(
                width: 110,
                height: 30,
                child: Transform.scale(
                  scale: .8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          if (widget.itemData!.counter! > 1) {
                            setState(() {
                              widget.itemData!.counter =
                                  widget.itemData!.counter! - 1;
                            });
                          }
                        },
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColor.buttonColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0)),
                          ),
                          child: Center(
                              child: new Icon(
                            Icons.remove,
                            color: Colors.white,
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.itemData!.counter =
                                widget.itemData!.counter! + 1;
                          });
                        },
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColor.buttonColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                            ),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ],
                  ),
                )),
          if (widget.itemData!.type! == SettingType.time)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SizedBox(
                  width: 100,
                  height: 30,
                  child: Transform.scale(
                    scale: 0.9,
                    child: InkWell(
                      onTap: () {
                        TimePicker(context, initialTime: SelectedTime.time,
                            onSelected: (picked) {
                          if (picked != null) {
                            var timeFinal = DateFormat("HH:mm").format(picked);
                            print(DateFormat("HH:mm").format(picked));
                            setState(() {
                              widget.itemData!.time = timeFinal;
                              TimeTF = TextEditingController(text: timeFinal);
                              // widget.data.startime!.pickupTime = timeFinal.toString();
                            });
                          }
                        }, onClose: () {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.textBG,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.itemData!.time == ""
                                ? "${widget.itemData?.title}"
                                : widget.itemData!.time!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      // review(
                      //     maxLine: 1,
                      //     minLine: 1,
                      //     textController: TimeTF,
                      //     enabled: false,
                      //     placeholder: "Start Time"),
                    ),

                    // TimeSelectorWidget(
                    // data: weekDays!,
                    // onChangeEndTime: (PickUpDateTime et) {
                    //   print("TimeSelectorWidget dsd${et.timeStr}");

                    //   print(et.timeStr);
                    // },
                    // onChangeStartTime: (PickUpDateTime st) {
                    //   print("TimeSelectorWidget ssd${st.timeStr}");
                    //   // print("TimeSel342432424Widget ssd${st.timeStr}");
                    // },
                    // onClose: () {},
                  )),

              //
            ),
          if (widget.itemData!.type! == SettingType.toggle)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Transform.scale(
                      scale: .7,
                      child: CupertinoSwitch(
                        trackColor: Colors.red, // **INACTIVE STATE COLOR**
                        activeColor: Colors.green, // **ACTIVE STATE COLOR**
                        value: widget.itemData!.value!,
                        onChanged: (bool value) {
                          widget.onSelectionBool!(value);
                        },
                      ))),
            ),
          if (widget.itemData!.type != SettingType.logout &&
              widget.itemData!.type != SettingType.loading &&
              widget.itemData!.type != SettingType.refresh &&
              widget.itemData!.type != SettingType.toggle &&
              widget.itemData!.type != SettingType.counter &&
              widget.itemData!.type != SettingType.time)
            Image.asset(
              'assets/icons/ic_arrow.png',
              fit: BoxFit.contain,
              height: 20,
              width: 20,
            ),
        ],
      ),
    );
  }
}
