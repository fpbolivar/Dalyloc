import 'package:daly_doc/utils/exportPackages.dart';

class ShadowOnView extends StatelessWidget {
  double width = 100;
  double height = 100;
  double fontSize = 17;
  double elevation = 0;

  Color? background;
  Color? titleColor;
  VoidCallback? onTap;
  FontWeight fontweight;
  EdgeInsets? padding;
  Widget? child;
  ShadowOnView(
      {this.width = double.infinity,
      this.height = 50,
      this.elevation = 10.0,
      this.fontSize = 17,
      this.background,
      this.titleColor,
      this.padding,
      this.onTap,
      @required this.child,
      this.fontweight = FontWeight.w400});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: (MediaQuery.of(context).size.width),
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        // clipBehavior: Clip.antiAlias,
        child: Material(
            elevation: elevation,
            borderRadius: BorderRadius.circular(10),
            clipBehavior: Clip.antiAlias,
            color: background,
            child: Padding(
              padding: padding == null
                  ? EdgeInsets.fromLTRB(10, 0, 10, 0)
                  : padding!,
              child: this.child,
            )));
  }
}
