import '../../utils/exportPackages.dart';
import '../../utils/exportWidgets.dart';

// ignore: must_be_immutable
class GetStartedScreen extends StatelessWidget {
  String? imagePath, title, desc;
  Function()? ontap;

  GetStartedScreen(
      {super.key, this.imagePath, this.title, this.desc, this.ontap});

  @override
  Widget build(BuildContext context) {
    return bodyDesign();
  }

//METHOD : -  bodyDesign
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
              padding: const EdgeInsets.only(top: 50),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                  children: <TextSpan>[
                    const TextSpan(text: LocalString.lblStayOrganized),
                    TextSpan(
                        text: LocalString.lblDaily,
                        style: TextStyle(
                            color: AppColor.dailyLblcolor,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25.0,
                    ),
                  ],
                ),
                child: Image.asset(imagePath!)),
          ),
          const SizedBox(
            height: 40,
          ),
          CustomButton(
              title: LocalString.lblGetStarted,
              height: 50,
              width: 250,
              shadow: true,
              radius: 30,
              onTap: ontap),
        ],
      ),
    );
  }
}
