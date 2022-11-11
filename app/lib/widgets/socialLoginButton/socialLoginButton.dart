import 'package:daly_doc/core/colors/colors.dart';

import '../../../utils/exportPackages.dart';

enum SocialButtonType {
  facebook,
  google;
}

class SocialLoginButton extends StatelessWidget {
  double width = 100;
  double height = 100;
  double fontSize = 17;
  SocialButtonType type;
  String title = "";
  bool? shadow;
  Color? background;
  Color? titleColor;
  double? radius;
  VoidCallback? onTap;
  FontWeight fontweight;
  SocialLoginButton(
      {super.key,
      this.type = SocialButtonType.facebook,
      this.width = double.infinity,
      this.shadow,
      this.height = 44,
      this.title = "",
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
            border: Border.all(width: 1.5, color: AppColor.borderColor
                //                   <--- border width here
                ),
            borderRadius: BorderRadius.circular(radius ?? 20),
            color: background ?? Colors.transparent),
        clipBehavior: Clip.antiAlias,
        child: Center(
            child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            if (type == SocialButtonType.facebook)
              Image.asset(
                "assets/icons/ic_facebook.png",
                width: 30,
                height: 30,
              ),
            if (type == SocialButtonType.google)
              Image.asset(
                "assets/icons/ic_google.png",
                width: 30,
                height: 25,
              ),
            Spacer(),
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: fontweight,
                  color: titleColor ?? AppColor.textBlackColor,
                  fontSize: fontSize),
            ),
            Spacer(),
          ],
        )),
      ),
    );
  }
}
