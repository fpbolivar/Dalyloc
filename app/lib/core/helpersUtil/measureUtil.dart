/// Converts Centimeters to Inches
double convertCMtoIN(double cm) => cm * 0.393701;

/// Converts Inches to Centimeters
double convertINtoCM(double inch) => inch * 2.54;

/// Converts Centimeters to Foot
int convertCMtoFT(double cm) => cm.floor() / 2.54 ~/ 12;

/// Converts Foot to Centimeters
double convertFTtoCM(int foot) => foot * 30.48;

/// Converts Foot to Inches
int convertFTtoIN(int foot) => foot * 12;

/// Converts Inches to Foot
int convertINtoFT(int inches) => inches ~/ 12;

/// Converts Centimeters to Foot and Inches
Map<String, int> convertCMtoFtIn(double cm) {
  var foot = convertCMtoFT(cm);
  var inches = cm.ceil() / 2.54 - convertFTtoIN(foot);

  return {"keyFoot": foot.toInt(), "keyInches": inches.round()};
}

/// Converts Foot and Inches to Centimeters
double convertFtIntoCM(Map<String, int> ftIn) =>
    convertFTtoCM(ftIn["keyFoot"]!) +
    convertINtoCM(ftIn["keyInches"]!.toDouble());

/// Converts Kilograms to Pounds
double convertKGtoLB(double kg) => kg * 2.20462;

/// Converts Pounds to Kilograms
double convertLBtoKG(double lb) => lb * 0.453592;

/// Converts Stone  to Pounds
int convertSTtoLB(int st) => st * 14;

/// Converts Pounds  to Stone
double convertLBtoST(int lb) => lb / 14;

/// Converts Stone and Pounds to Pounds
double convertStLbtoLB(Map<String, num> stLb) =>
    (convertSTtoLB(stLb["keyStone"]!.toInt()) + stLb["keyPounds"]!).toDouble();

/// Converts Pounds to Stone and Pounds
Map<String, num> convertLBtoStLb(double lb) {
  var st = convertLBtoST(lb.toInt()).toInt();
  var lbsToReturn = lb - (convertSTtoLB(st));
  return {"keyStone": st, "keyPounds": lbsToReturn};
}

/// Converts Kilograms to Stone
double convertKGtoST(double kg) => kg * 0.157473;

/// Converts Kilograms to Stone and Pounds
Map<String, num> convertKGtoStLb(double kg) {
  var st = convertKGtoST(kg).toInt();
  var lbsToReturn = convertKGtoLB(kg) - convertSTtoLB(st);
  return {"keyStone": st, "keyPounds": lbsToReturn};
}

/// Converts millieters to ounce
double convertMLtoOZ(double ml) => ml / 28.4131;

/// Converts ounce to millieters
double convertOZtoML(double oz) => oz * 28.4131;

/// Converts cups to grams
double cupToGram(double cups) => (cups * 128);

/// Converts ounce to grams
double ounceToGram(double oz) => oz * 28.3495;

/// Converts pounds to grams
double poundToGram(double lbs) => lbs * 453.592;
