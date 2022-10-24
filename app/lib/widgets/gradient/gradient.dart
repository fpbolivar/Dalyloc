import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';

class GradientColor {
  static LinearGradient getGradient() {
    return LinearGradient(
      colors: [AppColor.bgcolor, Colors.black.withOpacity(0.9)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}
