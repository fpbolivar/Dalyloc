import 'package:daly_doc/utils/exportPackages.dart';

import '../../utils/exportWidgets.dart';

// ignore: must_be_immutable
class BackgroundCurveView extends StatelessWidget {
  Widget child;
  Color? color;
  BackgroundCurveView({super.key, required this.child, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? AppColor.newBgcolor,
      child: child,
    );
    // return Container(
    //   margin: const EdgeInsets.only(top: 70),
    //   height: MediaQuery.of(context).size.height - 70,
    //   alignment: Alignment.center,
    //   decoration: BoxDecoration(
    //     color: AppColor.curveViewBgColor,
    //   ),
    //   child: Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 20),
    //     alignment: Alignment.center,
    //     decoration: const BoxDecoration(
    //         borderRadius: BorderRadius.only(
    //           topRight: Radius.circular(40.0),
    //           topLeft: Radius.circular(40.0),
    //         ),
    //         color: Color(0xFF575555)),
    //     child: child,
    //   ),
    // );
  }
}
