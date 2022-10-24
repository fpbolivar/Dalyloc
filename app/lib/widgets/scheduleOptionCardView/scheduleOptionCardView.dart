import '../../utils/exportPackages.dart';

class ScheduleOptionCardView extends StatelessWidget {
  String? imagePath, title;
  IconData? icon;
  double? height;
  Function()? ontap;
  ScheduleOptionCardView(
      {this.imagePath, this.title, this.ontap, this.icon, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: height,
      width: height,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Spacer(),
          Icon(
            icon!,
            size: 50,
          ),
          const Spacer(),
          Text(
            title!,
            textAlign: TextAlign.center,
            // ignore: prefer_const_constructors
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 15, color: Colors.black),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
