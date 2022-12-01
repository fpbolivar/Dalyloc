import 'dart:async';
import 'package:daly_doc/core/localStore/localStore.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../createNewbusinessScreens/createNewBusiness.dart';

class BookingLinkScreen extends StatefulWidget {
  BookingLinkScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BookingLinkScreen> createState() => _BookingLinkScreenScreenState();
}

class _BookingLinkScreenScreenState extends State<BookingLinkScreen> {
  Future<void> share(Text, Link) async {
    await FlutterShare.share(
        title: 'Share', text: Text, linkUrl: Link, chooserTitle: 'Daly Doc');
  }

  String Link = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    Link = await LocalStore().getBusinessSlug();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: LocalString.lblOnlineBusiness,
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: bodyDesign(),
        ),
      )),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.001),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(
              'assets/introduction_animation/introduction_image.png',
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              LocalString.lblBookingLinkDc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          const Text(
            "Your booking link",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Text(
            Link == "" ? "http://apis.codeoptimalsolutions.com" : Link,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.blue),
          ),
          const SizedBox(height: 40),
          CustomButton.regular(
            title: "Share Link",
            onTap: () {
              share("Booking Link",
                  Link == "" ? "http://apis.codeoptimalsolutions.com" : Link);
            },
            titleColor: AppColor.buttonColor,
            borderWidth: 2,
            background: Colors.transparent,
          ),
          const SizedBox(height: 10),
          CustomButton.regular(
            title: "Edit business details",
            onTap: () {
              Routes.pushSimple(
                  context: context,
                  child: CreateNewBusinessScreen(
                    update: true,
                  ));
            },
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }

  _launchURL(urlString) async {
    Uri url = Uri.parse("http://apis.codeoptimalsolutions.com/");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
