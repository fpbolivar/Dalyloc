import 'dart:async';
import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userBusinesModel.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/timeSlotsAvailabilty.dart';
import 'package:daly_doc/widgets/timeline/src/util.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constant/constants.dart';
import '../../../core/helpersUtil/dateHelper.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../../../widgets/headerCalendar/headerCalendarModel.dart';
import '../createNewbusinessScreens/createNewBusiness.dart';

class DepositScreens extends StatefulWidget {
  DepositScreens({
    Key? key,
  }) : super(key: key);

  @override
  State<DepositScreens> createState() => _DepositScreensState();
}

class _DepositScreensState extends State<DepositScreens> {
  Future<void> share(Text, Link) async {
    await FlutterShare.share(
        title: 'Share', text: Text, linkUrl: Link, chooserTitle: 'Daly Doc');
  }

  HeaderCalendarDatesModal? todayDate;
  List<HeaderCalendarDatesModal> headerDateModal = [];
  TextEditingController percentTFC = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var dateList = DateHelper().getDateOfMonth(DateTime.now());

    headerDateModal =
        dateList.map((e) => HeaderCalendarDatesModal.fromDate(e)).toList();
    headerDateModal.removeRange(
        0, DateHelper().getCurrentDayDD(DateTime.now()) - 1);
    todayDate = headerDateModal.first;
    Constant.selectedDateYYYYMMDD = todayDate!.dateFormatYYYYMMDD ?? "";

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getBusinessDetail();
    });
  }

  getBusinessDetail() async {
    UserBusinessModel? userBiz = await BusinessApis().getUserBusinessDetail();
    if (userBiz != null) {
      percentTFC.text = userBiz.deposit_percentage.toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(
        title: LocalString.lblDeposit,
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
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              LocalString.lblDepositDescription,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          CustomTF(
            controllr: percentTFC,
            keyBoardType: TextInputType.phone,
            placeholder: "25%",
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          const SizedBox(height: 10),
          CustomButton.regular(
            title: "Save",
            onTap: () async {
              await BusinessApis().depositPercentage(value: percentTFC.text);
              // kFlexMultiplierdepositPercentage
            },
          ),
          const SizedBox(height: 30),
          // listView(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  listView() {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            index == 0
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      "Deposit History",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  )
                : const SizedBox(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                tileColor: Colors.white,
                leading: Text(
                  "${todayDate!.monthShortFormat}\n${DateTime.now().day.toString()}",
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                trailing: const Text(
                  "\$20.78",
                  style: TextStyle(fontSize: 15),
                ),
                title: const Text(
                  "Jonh Doe",
                  style: TextStyle(fontSize: 17),
                ),
                subtitle: const Text(
                  "09:30 AM",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}
