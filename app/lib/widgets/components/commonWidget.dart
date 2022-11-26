import 'package:daly_doc/utils/exportPackages.dart';

simpleMessageShow(String msg) {
  return Center(
    child: Text(
      msg,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
    ),
  );
}
