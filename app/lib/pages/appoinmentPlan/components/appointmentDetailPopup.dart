import 'package:daly_doc/pages/appoinmentPlan/model/bookedAppoinmentModel.dart';
import 'package:daly_doc/pages/appoinmentPlan/views/rescheduleAppointmentView.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';
import 'package:daly_doc/pages/mealPlan/model/foodDietVarientModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';
import 'package:daly_doc/widgets/ratingStar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class AlertAppointmentDetailPopup extends StatelessWidget {
  AlertAppointmentDetailPopup(
      {super.key,
      required this.bookedData,
      this.onSelected,
      this.rateCount = 1.0,
      this.onSubmitRate,
      this.onCancel,
      this.isLoadingRating = false,
      this.onPayNow});
  Function()? onSelected;
  Function()? onPayNow;
  Function(String, double)? onSubmitRate;
  double rateCount;
  bool isLoadingRating = false;
  TextEditingController messageTF = TextEditingController();
  BookedAppointmentModel bookedData;
  Function()? onCancel;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColor.theme,
        //border: Border.all(width: 0.5, color: Colors.black26),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              headerView(context),
              Container(
                color: AppColor.textWhiteColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      dateTime(context),
                      // separator(),
                      userDetail(context),
                      const SizedBox(
                        height: 5,
                      ),
                      descriptionView(),
                      separator(),
                      serviceDetail(context),

                      const SizedBox(
                        height: 20,
                      ),

                      if (!isDisabledRescheduleBtn()) reschedule(context),
                      if (!isDisabledRescheduleBtn())
                        const SizedBox(
                          height: 20,
                        ),

                      if (isDisabledRating()) ratingStar(context),
                      if (isDisabledRating())
                        const SizedBox(
                          height: 20,
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  isDisabledRescheduleBtn() {
    return (bookedData.appt_status!.toLowerCase() == "cancelled") ||
        (bookedData.appt_status!.toLowerCase() == "rejected") ||
        (bookedData.appt_status!.toLowerCase() == "paid") ||
        (bookedData.appt_status!.toLowerCase() == "completed");
  }

  isDisabledRating() {
    var status = (bookedData.appt_status!.toLowerCase() == "completed") ||
        (bookedData.appt_status!.toLowerCase() == "paid");
    return status && (bookedData.is_rating!.toLowerCase() == "0");
  }

  isParitallyPaid() {
    return (bookedData.amount_paid != "" && bookedData.pending_payment != "");
  }

  Widget separator() {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget headerView(context) {
    return Container(
      height: 42,
      color: AppColor.theme,
      child: Stack(
        //  mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isParitallyPaid()) Spacer(),
              Container(
                child: Center(
                  child: Text(
                    "${bookedData.business_name!.capitalize()}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              if (isParitallyPaid())
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 50,
                ),
            ],
          ),
          if (isParitallyPaid())
            Positioned(
              width: 90,
              height: 20,
              top: 11,
              right: 10,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColor.partialBrown,
                  //border: Border.all(width: 0.5, color: Colors.black26),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    " Partially paid ".toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget descriptionView() {
    return bookedData.booked_user_message == ""
        ? Container()
        : Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${bookedData.booked_user_message!.capitalize()}",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
            ),
          );
  }

  Widget userDetail(context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Details",
              style: TextStyle(
                  color: AppColor.textBlackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${bookedData.booked_user_name!.capitalize()}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
                Container(
                  width: 50,
                  height: 30,
                  child: callMsgButton(context),
                )
              ],
            ),
          ],
        )));
  }

  Widget serviceDetail(context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Service Price: \$${bookedData.serviceList!.first.service_price}",
              style: TextStyle(
                  color: AppColor.textBlackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const Text(
              "(Consultation)",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            (bookedData.amount_paid == "" && bookedData.pending_payment == "")
                ? Text(
                    "Paid: \$ FREE",
                    style: TextStyle(
                        color: AppColor.textBlackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                : (bookedData.amount_paid != "")
                    ? Text(
                        "Paid: \$ ${bookedData.amount_paid}",
                        style: TextStyle(
                            color: AppColor.textBlackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      )
                    : Container(),
            (bookedData.pending_payment != "")
                ? Text("Pending Balance: \$ ${bookedData.pending_payment}",
                    style: TextStyle(
                      color: AppColor.textBlackColor,
                      fontSize: 15,
                    ))
                : Container()
          ],
        )));
  }

  Widget reschedule(context) {
    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width,
        child: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomButton.regular(
                title: "Reschedule",
                fontSize: 10,
                background: AppColor.rescheduleBgColor,
                onTap: () {
                  Routes.pushSimple(
                      context: context,
                      child:
                          RescheduleAppointmentView(bookingData: bookedData));
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: CustomButton.regular(
                title: "Cancel",
                fontSize: 10,
                background: AppColor.rejectBgColor,
                onTap: () {
                  onCancel!();
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            (bookedData.amount_paid == "" && bookedData.pending_payment == "")
                ? Container()
                : (bookedData.appt_status == "accepted")
                    ? Expanded(child: payNowBtn(context))
                    : Container(),
          ],
        )));
  }

  Widget payNowBtn(context) {
    return CustomButton.regular(
      title: "Pay Now",
      fontSize: 10,
      width: 140,
      background: AppColor.acceptBgColor,
      onTap: () {
        onPayNow!();
      },
    );

    // Container(
    //     height: 35,
    //     //width: MediaQuery.of(context).size.width,
    //     child: Container(
    //         child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         CustomButton.regular(
    //           title: "Pay Now",
    //           fontSize: 15,
    //           width: 140,
    //           background: AppColor.acceptBgColor,
    //         ),
    //       ],
    //     )));
  }

  Widget dateTime(context) {
    return Container(
        height: 44,
        width: MediaQuery.of(context).size.width,
        child: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${bookedData.formateDate!}",
              style: TextStyle(
                  color: AppColor.textBlackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${bookedData.appt_local_start_time!} - ${bookedData.appt_local_end_time!}",
              style: TextStyle(
                  color: AppColor.textBlackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ],
        )));
  }

  Widget callMsgButton(context) {
    return Container(
        //height: 44,
        width: MediaQuery.of(context).size.width,
        child: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                final Uri callLaunchUri = Uri(
                  scheme: 'tel',
                  path: bookedData.booked_user_phone_no,
                );
                launchUrl(callLaunchUri);
              },
              child: Image.asset(
                "assets/icons/ic_call.png",
                width: 20,
                height: 20,
              ),
            ),
            InkWell(
              onTap: () {
                final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: bookedData.booked_user_email,
                    queryParameters: {
                      'subject': 'Support DalyDoc Appointment'
                    });

                launchUrl(emailLaunchUri);
              },
              child: Image.asset(
                "assets/icons/ic_msg.png",
                width: 22,
                height: 22,
              ),
            ),
          ],
        )));
  }

  Widget ratingStar(context) {
    return isLoadingRating
        ? SizedBox(width: 20, height: 20, child: loaderList())
        : Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Share your experience",
                  style: TextStyle(
                      color: AppColor.textBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 30,
                  // width: 100,
                  child: RatingBar.builder(
                    initialRating: rateCount,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 20,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      rateCount = rating;
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                writeReview(),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton.regular(
                          title: "Submit",
                          fontSize: 15,
                          width: 80,
                          background: AppColor.acceptBgColor,
                          onTap: () {
                            onSubmitRate!(messageTF.text, rateCount);
                          },
                        ),
                      ],
                    ))
              ],
            )));
  }

  Widget writeReview() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: AppColor.textBlackColor
            //                   <--- border width here
            ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          style: TextStyle(fontSize: 20, color: AppColor.textBlackColor),
          minLines: 2,
          maxLines: 2,
          autocorrect: false,
          controller: messageTF,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Any comment... ",
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
