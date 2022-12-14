import 'package:flutter/foundation.dart';

class Country {
  String name;
  String code;
  String dialCode;
  String extra;
  bool selected;
  Country(
      {required this.name,
      required this.code,
      required this.dialCode,
      this.extra = "",
      this.selected = false});

  @override
  String toString() {
    return dialCode + code;
  }

  // Country.fromJson(Map<dynamic, dynamic> countryData) {
  //   name = countryData['Name'];
  //   code = countryData['ISO'];
  //   dialCode = "+" + countryData['Code'];
  //   selected = false;
  // }
  factory Country.fromJson(Map<String, dynamic> countryData) {
    return Country(
      name: countryData['Name'],
      code: countryData['ISO'],
      dialCode: "+" + countryData['Code'],
      selected: false,
    );
  }
  //String get flagUri => "assets/images/flags/${code.toLowerCase()}.png";
}
