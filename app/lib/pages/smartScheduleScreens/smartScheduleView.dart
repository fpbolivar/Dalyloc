import 'dart:ui';

import 'package:daly_doc/pages/smartScheduleScreens/components/smartScheduleCardItemView.dart';
import 'package:daly_doc/pages/subscriptionPlansScreen/planDetailView.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import 'models/SmartItemModal.dart';

class SmartScheduleView extends StatefulWidget {
  String? red;
  SmartScheduleView({Key? key, this.red}) : super(key: key);

  @override
  State<SmartScheduleView> createState() => _SmartScheduleViewState();
}

class _SmartScheduleViewState extends State<SmartScheduleView> {
  List<SmartItemModel> data = [
    SmartItemModel(icon: "ic_send.png", title: "Send Email"),
    SmartItemModel(icon: "ic_text.png", title: "Send Text"),
    SmartItemModel(icon: "ic_attach.png", title: "Copy Link"),
    SmartItemModel(icon: "ic_book.png", title: "Book for Invitee")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "Choose how to Schedule",
          subtitle: "",
          subtitleColor: AppColor.textGrayBlue),
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
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              optionList(),
              const SizedBox(
                height: 10,
              ),

              //
            ]),
      ),
    );
  }

  Widget headerTitle(title) {
    return Text(
      title.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: AppColor.textBlackColor),
    );
  }

  Widget optionList() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      itemCount: data.length,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,

      // ignore: missing_return
      itemBuilder: (BuildContext context, int index) {
        return SmartScheduleCardItemView(itemData: data[index]);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: MediaQuery.of(context).size.width / (100 * 3)),
    );
  }
}
