import 'package:daly_doc/utils/exportWidgets.dart';
import '../../utils/exportPackages.dart';

// ignore: must_be_immutable
class ChooseAccountTypeScreen extends StatelessWidget {
  String? imagePath, title, desc;
  Function()? ontap;
  ChooseAccountTypeScreen(
      {super.key, this.imagePath, this.title, this.desc, this.ontap});

  @override
  Widget build(BuildContext context) {
    return bodyDesign();
  }

//METHOD : - bodyDesign
  Widget bodyDesign() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(gradient: GradientColor.getGradient()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 70),
            child: Text(
              LocalString.lblDalyDoc,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 50,
                  color: Colors.white),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 100),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                  children: <TextSpan>[
                    TextSpan(text: LocalString.lblChosseOne),
                  ],
                ),
              )),
          const SizedBox(
            height: 40,
          ),
          CustomButton(
              title: LocalString.lblPersonal,
              height: 50,
              width: 250,
              radius: 30,
              shadow: true,
              background: Colors.white,
              titleColor: Colors.black,
              onTap: ontap),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              title: LocalString.lblBusiness,
              height: 50,
              width: 250,
              radius: 30,
              shadow: true,
              onTap: ontap),
        ],
      ),
    );
  }
}
