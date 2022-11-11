import 'package:daly_doc/pages/notificationScreen/components/sectionRowlistView.dart';
import 'package:daly_doc/pages/notificationScreen/model/SectionItemModel.dart';
import 'package:daly_doc/pages/notificationScreen/model/rowItemModel.dart';
import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

class NotificationScreen extends StatefulWidget {
  String? red;
  NotificationScreen({Key? key, this.red}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationSectionRowModel> data = [
    NotificationSectionRowModel(title: "Today", items: [
      RowItemModel(
          title: "You have received meal notification",
          description: "Lorem Ipsum is simply dummy text of the"),
      RowItemModel(
          title: "You have received meal notification",
          description: "Lorem Ipsum is simply dummy text of the")
    ]),
    NotificationSectionRowModel(title: "Oct 12,2022", items: [
      RowItemModel(
          title: "You have received exercise notification",
          description: "Lorem Ipsum is simply dummy text of the")
    ])
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarWithBackButton(
        title: LocalString.lblNotification,
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
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              listView(),
              //
            ]),
      ),
    );
  }

  Widget listView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (conext, index) {
        return InkWell(
            onTap: () {
              //onTap!(itemList[index].section ?? 0, index);
            },
            child: NotificationSectionRowListView(sectionItem: data[index]));
      },
      separatorBuilder: (BuildContext context, int index) {
        // ignore: prefer_const_constructors
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
        );
      },
    );
  }
}
