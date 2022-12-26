import 'package:daly_doc/pages/appoinmentPlan/model/bookedAppoinmentModel.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';
import 'package:daly_doc/pages/mealPlan/model/foodDietVarientModel.dart';
import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';

// ignore: must_be_immutable
class AlertAcceptRejetView extends StatelessWidget {
  AlertAcceptRejetView(
      {super.key,
      required this.bookedData,
      this.onSelected,
      this.onComplete,
      this.onCancel,
      this.onAskForPayment,
      this.onReject,
      this.onAccept});
  Function()? onSelected;
  Function()? onComplete;
  TextEditingController messageTF = TextEditingController();
  BookedAppointmentModel bookedData;
  Function()? onCancel;
  Function()? onAccept;
  Function()? onReject;
  Function()? onAskForPayment;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    dateTime(context),
                    serviceDetail(context),
                    separator(),
                    userDetail(context),
                    separator(),
                    descriptionView(),
                    const SizedBox(
                      height: 20,
                    ),
                    if (isPendingBtn()) acceptRejectBtn(context),
                    if (isPendingBtn())
                      const SizedBox(
                        height: 20,
                      ),
                    if (!isDisabledAskForPaymentBtn())
                      askForPaymentBtn(context),
                    if (!isDisabledAskForPaymentBtn())
                      const SizedBox(
                        height: 20,
                      ),
                    if (!isFreeService()) completeBookBtn(context),
                    if (isAllAmountPaid()) completeBookBtn(context),
                    if (!isFreeService() || isAllAmountPaid())
                      const SizedBox(
                        height: 20,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  isDisabledAskForPaymentBtn() {
    return (bookedData.appt_status!.toLowerCase() == "cancelled") ||
        (bookedData.appt_status!.toLowerCase() == "rejected") ||
        (bookedData.appt_status!.toLowerCase() == "paid") ||
        (bookedData.appt_status!.toLowerCase() == "completed") ||
        (bookedData.appt_status!.toLowerCase() != "accepted") ||
        (bookedData.amount_paid == "" && bookedData.pending_payment == "");
  }

  isParitallyPaid() {
    return (bookedData.amount_paid != "" && bookedData.pending_payment != "");
  }

  isPendingBalancePaid() {
    return (bookedData.pending_payment != "");
  }

  isCompletePaid() {
    return (bookedData.amount_paid != "");
  }

  isPendingBtn() {
    return (bookedData.appt_status!.toLowerCase() == "pending");
  }

  isFreeService() {
    var status = !(bookedData.amount_paid == "" &&
        bookedData.pending_payment == "" &&
        bookedData.appt_status!.toLowerCase() != "rejected" &&
        bookedData.appt_status!.toLowerCase() != "pending");
    print("isFreeService ${status}");
    return status;
  }

  isAllAmountPaid() {
    var status = (bookedData.appt_status!.toLowerCase() == "paid" &&
        bookedData.appt_status!.toLowerCase() != "rejected" &&
        bookedData.appt_status!.toLowerCase() != "pending");
    print("isAllAmountPaid ${status}");
    return status;
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
        height: 44,
        width: MediaQuery.of(context).size.width,
        color: AppColor.theme,
        child: Container(
          child: Center(
            child: Text(
              "${bookedData.booked_user_name!.capitalize()}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }

  Widget descriptionView() {
    return bookedData.booked_user_message == ""
        ? Container()
        : Text(
            "${bookedData.booked_user_message!.capitalize()}",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w400),
          );
  }

  Widget userDetail(context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "User Details",
              style: TextStyle(
                  color: AppColor.textBlackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${bookedData.booked_user_name!.capitalize()}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${bookedData.booked_user_phone_no}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${bookedData.booked_user_email}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
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
                : Container(),
            un_paid_PartiallyBtn(context)
          ],
        )));
  }

  Widget acceptRejectBtn(context) {
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
                title: "Accept",
                fontSize: 15,
                background: AppColor.acceptBgColor,
                onTap: () {
                  onAccept!();
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: CustomButton.regular(
                title: "Reject",
                fontSize: 15,
                background: AppColor.rejectBgColor,
                onTap: () {
                  onReject!();
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        )));
  }

  Widget askForPaymentBtn(context) {
    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width,
        child: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: CustomButton.regular(
                title: "Ask for Payment",
                fontSize: 15,
                background: AppColor.acceptBgColor,
                onTap: () {
                  onAskForPayment!();
                },
              ),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        )));
  }

  Widget completeBookBtn(context) {
    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width,
        child: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: CustomButton.regular(
                title: "Complete Job",
                fontSize: 15,
                titleColor: AppColor.acceptBgColor,
                borderWidth: 1,
                background: Colors.transparent,
                onTap: () {
                  onComplete!();
                },
              ),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        )));
  }

  Widget un_paid_PartiallyBtn(context) {
    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width,
        child: Container(
            child: isParitallyPaid()
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomButton.regular(
                      title: "Partially Paid",
                      fontSize: 10,
                      width: 90,
                      height: 20,
                      radius: 4,
                      background: AppColor.partialBrown,
                    )
                  ])
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isPendingBalancePaid())
                        CustomButton.regular(
                          title: "Unpaid",
                          fontSize: 10,
                          width: 50,
                          height: 20,
                          radius: 4,
                          background: AppColor.rejectBgColor,
                        ),
                      if (isParitallyPaid())
                        const SizedBox(
                          width: 10,
                        ),
                      if (isParitallyPaid())
                        CustomButton.regular(
                          title: "Partially Paid",
                          fontSize: 10,
                          width: 90,
                          height: 20,
                          radius: 4,
                          background: AppColor.partialBrown,
                        ),
                      if (isPendingBalancePaid())
                        const SizedBox(
                          width: 10,
                        ),
                      if (isCompletePaid())
                        CustomButton.regular(
                          title: "Paid",
                          fontSize: 10,
                          width: 40,
                          height: 20,
                          radius: 4,
                          background: AppColor.acceptBgColor,
                        ),
                      if (isCompletePaid())
                        const SizedBox(
                          width: 10,
                        ),
                    ],
                  )));
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

    // Container(
    //       child: Stack(
    //         //  mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Row(
    //             children: [
    //               Spacer(),
    //               Container(
    //                 child: const Center(
    //                   child: Text(
    //                     " John ",
    //                     style: TextStyle(color: Colors.white),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: (MediaQuery.of(context).size.width / 2) - 50,
    //               ),
    //             ],
    //           ),
    //           Positioned(
    //             width: 100,
    //             height: 20,
    //             top: 11,
    //             right: 10,
    //             child: Container(
    //               color: AppColor.partialBrown,
    //               child: const Center(
    //                 child: Text(
    //                   " Positioned ",
    //                   textDirection: TextDirection.rtl,
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   )
  }
}
