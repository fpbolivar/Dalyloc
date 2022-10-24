import '../../../utils/exportPackages.dart';

class CustomButton extends StatelessWidget {
  double width = 100;
  double height = 100;
  double fontSize = 17;
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
      this.fontSize = 20,
      this.radius = 5,
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
            boxShadow: [
              shadow == true
                  ? const BoxShadow(blurRadius: 25.0, color: Colors.black)
                  : const BoxShadow(blurRadius: 0),
            ],
            borderRadius: BorderRadius.circular(radius ?? 20),
            color: background ?? Colors.grey[800]),
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
