import 'dart:convert';
import 'dart:math' as math;
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

class AddCardView extends StatefulWidget {
  @override
  _AddCardViewState createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
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
          title: "Add Payment",
          subtitle: "Card",
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
    bool? resultResponse = await PaymentManager().addCard(
        cardNumber: cardNumberCtrl.text,
        expDate: expiryFieldCtrl.text,
        cvv: cvvTF.text);
    if (resultResponse != null) {
      if (resultResponse == true) {
        Navigator.of(context).pop(true);
      }
    }
  }

  cvvWidgetTF() {
    return Container(
      child: TextFormField(
        controller: cvvTF,
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

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = new StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: new TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
