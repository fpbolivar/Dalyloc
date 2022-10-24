import 'package:daly_doc/utils/exportPackages.dart';

class CustomBackButton extends StatelessWidget {
  String title = "";
  Widget? rightTrailingWidget;
  CustomBackButton({super.key, this.title = "", this.rightTrailingWidget});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(Icons.arrow_back_ios)),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white),
        ),
        rightTrailingWidget ?? Container()
      ],
    );
  }
}
