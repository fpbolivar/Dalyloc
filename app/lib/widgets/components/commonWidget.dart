import 'package:daly_doc/utils/exportPackages.dart';
import 'package:daly_doc/utils/exportWidgets.dart';

simpleMessageShow(String msg) {
  return Center(
    child: Text(
      msg,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
    ),
  );
}

Widget loaderList() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(AppColor.theme),
      strokeWidth: 2,
    ),
  );
}
