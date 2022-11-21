import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/widgets/weekDayCell/timerSelectorWidget.dart';

import '../../pages/authScreens/authManager/models/businessCatModel.dart';
import '../../utils/exportPackages.dart';

class WeekDaysCell extends StatelessWidget {
  String title = "";
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
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        data.selected == false
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
                data.name!,
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
            child: TimeSelectorWidget(
              data: data,
              onChangeEndTime: (PickUpDateTime et) {
                print("TimeSelectorWidget dsd${et.timeStr}");
                this.onChangeEndTime(et);
              },
              onChangeStartTime: (PickUpDateTime st) {
                this.onChangeStartTime(st);
                print("TimeSelectorWidget ssd${st.timeStr}");
              },
              onClose: () {
                this.onClose();
              },
            ))
      ],
    ));
  }
}
