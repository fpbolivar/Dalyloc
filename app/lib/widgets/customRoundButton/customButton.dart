import '../../../utils/exportPackages.dart';
import '../../utils/exportWidgets.dart';

class CustomButton extends StatelessWidget {
  double width = 100;
  double height = 100;
  double fontSize = 17;
  double borderWidth = 0;
  String title = "";
  bool? shadow;
  Color? background;
  Color? titleColor;
  double? radius;
  VoidCallback? onTap;
  FontWeight fontweight;
  CustomButton(
      {super.key,
      this.width = double.infinity,
      this.shadow,
      this.height = 44,
      this.title = "",
      this.borderWidth = 0,
      this.fontSize = 20,
      this.radius = 5,
      this.background,
      this.titleColor,
      this.onTap,
      this.fontweight = FontWeight.w400});
  CustomButton.regular(
      {super.key,
      this.width = double.infinity,
      this.shadow = false,
      this.height = 50,
      this.title = "",
      this.borderWidth = 0,
      this.fontSize = 18,
      this.radius = 8,
      this.background,
      this.titleColor,
      this.onTap,
      this.fontweight = FontWeight.w400});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            border: borderWidth == 0
                ? null
                : Border.all(width: 1.5, color: AppColor.borderColor
                    //                   <--- border width here
                    ),
            boxShadow: shadow == false
                ? null
                : [const BoxShadow(blurRadius: 25.0, color: Colors.black)],
            borderRadius: BorderRadius.circular(radius ?? 20),
            color: background ?? AppColor.buttonColor),
        clipBehavior: Clip.antiAlias,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontWeight: fontweight,
                color: titleColor ?? Colors.white,
                fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
