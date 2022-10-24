import 'package:daly_doc/utils/exportPackages.dart';

import '../../utils/exportWidgets.dart';

class BackgroundCurveView extends StatelessWidget {
  Widget child;
  BackgroundCurveView({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      height: MediaQuery.of(context).size.height - 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.curveViewBgColor,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0),
              topLeft: Radius.circular(40.0),
            ),
            color: Color(0xFF575555)),
        child: child,
      ),
    );
  }
}