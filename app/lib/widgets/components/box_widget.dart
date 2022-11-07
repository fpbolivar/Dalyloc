import 'package:daly_doc/utils/exportPackages.dart';

class boxWidget1 extends StatelessWidget {
  String? imagePath, title;
  IconData? icon;
  double? height;
  double? width;
  Widget? data;
  Function()? ontap;
  boxWidget1(
      {this.imagePath,
      this.title,
      this.ontap,
      this.data,
      this.icon,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    print(
      0.20 * height!,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: height,
        width: width,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title!,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
                imagePath != null
                    ? Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Image.asset(
                          imagePath!,
                          height: 20,
                        ),
                      )
                    : icon == null
                        ? const SizedBox()
                        : Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Icon(
                              icon,
                              color: Colors.red,
                            ),
                          )
              ],
            ),
            const Break(),
            Container(
              child: data,
            )
          ],
        ),
      ),
    );
  }
}

class Break extends StatelessWidget {
  const Break({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      // width: ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Colors.black26,
      ),
    );
  }
}
