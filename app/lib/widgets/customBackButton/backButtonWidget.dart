import 'package:daly_doc/utils/exportPackages.dart';

class CustomBackButton extends StatelessWidget {
  String title = "";
  InlineSpan? richtext;
  Icon? icon;
  Function()? onPressed;
  bool dualColoredTitle;
  Widget? rightTrailingWidget;
  CustomBackButton(
      {super.key,
      this.richtext,
      this.icon,
      this.onPressed,
      this.title = "",
      this.rightTrailingWidget,
      this.dualColoredTitle = false});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPressed ??
              () {
                Navigator.pop(
                  context,
                );
              },
          icon: icon ?? Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        dualColoredTitle == true
            ? RichText(text: richtext!)
            : Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Colors.white),
              ),
        rightTrailingWidget ?? Container()
      ],
    );
  }
}
