import 'dart:convert';
import 'dart:math' as math;
import 'package:daly_doc/pages/appoinmentPlan/manager/appointmentApi.dart';
import 'package:daly_doc/pages/paymentPages/addCardView.dart';
import 'package:daly_doc/pages/paymentPages/components/awesome_card.dart';
import 'package:daly_doc/pages/paymentPages/helper/validatorCard.dart';

import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:daly_doc/widgets/customRoundButton/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import 'apiManager/paymentManager.dart';

class CardDetailModel {
  String cardNumber = "";
  String month = "";
  String year = "";
  String cvv = "";
}

class SinglePaymentView extends StatefulWidget {
  var appointmentID = "";
  var fromAddAppointmentForm = false;
  Function()? onSuccessPayment;
  Function(CardDetailModel)? onPaymentDetail;
  SinglePaymentView(
      {this.appointmentID = "",
      this.onSuccessPayment,
      this.onPaymentDetail,
      this.fromAddAppointmentForm = false});
  @override
  _SinglePaymentViewState createState() => _SinglePaymentViewState();
}

class _SinglePaymentViewState extends State<SinglePaymentView> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  late FocusNode _focusNode;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();
  TextEditingController cvvTF = TextEditingController();
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "Payment",
          subtitle: "Detail",
          subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: CreditCard(
                    width: 220,
                    cardNumber: cardNumber,

                    cardExpiry: expiryDate,
                    cardHolderName: cardHolderName,
                    cvv: cvv,
                    bankName: 'DalyDoc Card',
                    showBackSide: showBack,

                    frontBackground: CardBackgrounds.frontColor,
                    backBackground: CardBackgrounds.backColor,
                    showShadow: false,
                    isContactless: true,

                    // mask: getCardTypeMask(cardType: CardType.americanExpress),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: textBgShadow(
                        TextFormField(
                          controller: cardNumberCtrl,
                          decoration: InputDecoration(
                              hintText: 'Card Number',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero),
                          keyboardType: TextInputType.number,
                          // and add this to your `TextFormField` Widget
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CardNumberFormatter(),
                            LengthLimitingTextInputFormatter(19),
                          ],
                          //  maxLength: 19,
                          onChanged: (value) {
                            // final newCardNumber = value.trim();
                            // var newStr = '';
                            // final step = 4;

                            // for (var i = 0; i < newCardNumber.length; i += step) {
                            //   newStr += newCardNumber.substring(
                            //       i, math.min(i + step, newCardNumber.length));
                            //   if (i + step < newCardNumber.length) newStr += ' ';
                            // }

                            setState(() {
                              cardNumber = cardNumberCtrl.text;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Row(
                        children: [
                          Expanded(child: textBgShadow(expireWidgetTF())),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: textBgShadow(cvvWidgetTF()))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton.regular(
                    title: "Submit",
                    background: AppColor.theme,
                    onTap: () async {
                      validationExecute();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validationExecute() async {
    CreditCardResult? result = CreditCardValidationBloc()
        .validateCreditCardInfo(
            cardNumberCtrl.text, expiryFieldCtrl.text, cvvTF.text);

    print(result);
    if (cardNumberCtrl.text.isEmpty) {
      ToastMessage.showMessage(msg: "Enter card number.");
      return;
    }
    if (!result!.isValidCard) {
      ToastMessage.showMessage(msg: "Invalid card number");
      return;
    }
    if (expiryFieldCtrl.text.isEmpty) {
      ToastMessage.showMessage(msg: "Enter expiry date.");
      return;
    }
    if (!result.isValidExpiryDate) {
      ToastMessage.showMessage(msg: "Invalid expiry date");
      return;
    }
    if (cvvTF.text.isEmpty) {
      ToastMessage.showMessage(msg: "Enter CVV.");
      return;
    }
    if (!result.isValidCVV) {
      ToastMessage.showMessage(msg: "Invalid CVV");
      return;
    }
    if (widget.fromAddAppointmentForm) {
      var splitDate = expiryFieldCtrl.text.toString().split("/");
      var expMonth = splitDate[0];
      var expYear = splitDate[1];
      var obj = CardDetailModel();
      obj.cardNumber = cardNumberCtrl.text;
      obj.month = expMonth;
      obj.year = expYear;
      obj.cvv = cvvTF.text;
      showConfirmAlert("Are you sure you want to book appointment?", onTap: () {
        widget.onPaymentDetail!(obj);
      });

      return;
    }
    showConfirmAlert("Are you sure you want to continue transaction?",
        onTap: () {
      purcahseAPI();
    });
  }

  purcahseAPI() async {
    bool? resultResponse = await AppointmentApi().userPayment(
        cardNumber: cardNumberCtrl.text,
        expDate: expiryFieldCtrl.text,
        appointmentID: widget.appointmentID,
        cvv: cvvTF.text,
        onSuccess: () {
          widget.onSuccessPayment!();
          Navigator.of(context).pop(true);
        });
    if (resultResponse != null) {
      if (resultResponse == true) {
        //Navigator.of(context).pop(true);
      }
    }
  }

  cvvWidgetTF() {
    return Container(
      child: TextFormField(
        controller: cvvTF,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'CVV',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero),
        //  maxLength: 3,
        inputFormatters: [
          LengthLimitingTextInputFormatter(4),
        ],
        onChanged: (value) {
          setState(() {
            cvv = value;
          });
        },
        focusNode: _focusNode,
      ),
    );
  }

  expireWidgetTF() {
    return Container(
      child: TextFormField(
        controller: expiryFieldCtrl,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'MM/YY',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero),
        inputFormatters: [
          LengthLimitingTextInputFormatter(5),
        ],
        onChanged: (value) {
          var newDateValue = value.trim();
          final isPressingBackspace = expiryDate.length > newDateValue.length;
          final containsSlash = newDateValue.contains('/');

          if (newDateValue.length >= 2 &&
              !containsSlash &&
              !isPressingBackspace) {
            newDateValue =
                newDateValue.substring(0, 2) + '/' + newDateValue.substring(2);
          }
          setState(() {
            expiryFieldCtrl.text = newDateValue;
            expiryFieldCtrl.selection = TextSelection.fromPosition(
                TextPosition(offset: newDateValue.length));
            expiryDate = newDateValue;
          });
        },
      ),
    );
  }

  textBgShadow(widget) {
    return Container(
        height: 53,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColor.textBlackColor
                //                   <--- border width here
                ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent),
        child: Padding(
          child: widget,
          padding: EdgeInsets.symmetric(horizontal: 10),
        ));
  }
}
