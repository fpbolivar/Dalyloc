import 'package:daly_doc/core/colors/colors.dart';
import 'package:flutter/material.dart';

class CardBackgrounds {
  CardBackgrounds._();

  static Widget black = Container(
    width: double.maxFinite,
    height: double.maxFinite,
    color: Color(0xff0B0B0F),
  );
  static Widget frontColor = Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: AppColor.halfGrayTextColor);
  static Widget white = Container(
    width: double.maxFinite,
    height: double.maxFinite,
    color: Color(0xffF9F9FA),
  );
  static Widget backColor = Container(
    width: double.maxFinite,
    height: double.maxFinite,
    color: AppColor.segmentBarBgColor,
  );

  static Widget custom(color) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Color(color),
    );
  }
}
