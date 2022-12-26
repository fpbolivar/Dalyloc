import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/bookedAppoinmentModel.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/upcomingAppointmentModel.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';
import '../../../../utils/exportPackages.dart';

// ignore: must_be_immutable
class UpcomingAppointmentItemView extends StatelessWidget {
  BookedAppointmentModel itemData;
  bool? fromUser = false;
  UpcomingAppointmentItemView(
      {super.key, this.fromUser = false, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.5, color: Colors.black26),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
            child: Stack(
              children: [
                bodyView(),
                // Positioned(
                //     right: 0,
                //     top: 0,
                //     child: Container(
                //       width: 80,
                //       height: 80,
                //       child: Image.asset(
                //         "assets/icons/${itemData.image}",
                //         width: 25,
                //         height: 25,
                //       ),
                //     ))
              ],
            )),
      ),
    );
  }

  Widget bodyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: prefer_const_constructors
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              fromUser!
                  ? "${itemData.business_name}"
                  : "${itemData.booked_user_name}",
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Container(
              color: getStatusColor(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "${itemData.appt_status!.capitalize()}",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),

        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${itemData.formateDate}|${itemData.appt_local_start_time}",
                      textAlign: TextAlign.left,
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ])
      ],
    );
  }

  getStatusColor() {
    switch (itemData.appt_status!.toLowerCase().statusType) {
      case StatusAppointment.pending:
        return Colors.red[800];

      case StatusAppointment.accepted:
        return AppColor.applinkColor;
      case StatusAppointment.completed:
        return Colors.blue[800];
      case StatusAppointment.reject:
        return Colors.orange[800];
      case StatusAppointment.cancelled:
        return Colors.blueGrey;
      case StatusAppointment.paid:
        return AppColor.acceptBgColor;
      default:
        Colors.red[800];
    }
  }
}
