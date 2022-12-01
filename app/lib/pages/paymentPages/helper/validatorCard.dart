import 'cardValidator/credit_card_validator.dart';

class CreditCardResult {
  bool isValidCard = false;
  bool isValidExpiryDate = false;
  bool isValidCVV = false;
}

class CreditCardValidationBloc {
  CreditCardValidator _ccValidator = CreditCardValidator();

  CreditCardResult? validateCreditCardInfo(
      String ccNum, String expDate, String cvv) {
    var ccNumResults = _ccValidator.validateCCNum(ccNum);
    var expDateResults = _ccValidator.validateExpDate(expDate);
    var cvvResults = _ccValidator.validateCVV(cvv, ccNumResults.ccType);
    var obj = CreditCardResult();
    obj.isValidCard = ccNumResults.isValid;
    obj.isValidExpiryDate = expDateResults.isValid;
    obj.isValidCVV = cvvResults.isValid;
    return obj;
  }
}
