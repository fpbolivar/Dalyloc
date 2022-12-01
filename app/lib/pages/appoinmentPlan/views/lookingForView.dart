import 'package:daly_doc/pages/appoinmentPlan/components/lookingItemWidget.dart';
import 'package:daly_doc/pages/appoinmentPlan/components/noDataWidget.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/LookingItemModel.dart';
import 'package:daly_doc/pages/appoinmentPlan/views/consultantView.dart';
import 'package:daly_doc/pages/paymentPages/addCardView.dart';
import 'package:daly_doc/pages/paymentPages/model/SavedCardModel.dart';
import 'package:daly_doc/widgets/swipeAction/flutter_swipe_action_cell.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class LookingForView extends StatefulWidget {
  LookingForView({
    Key? key,
  }) : super(key: key);

  @override
  State<LookingForView> createState() => _LookingForViewState();
}

class _LookingForViewState extends State<LookingForView> {
  List<LookingItemModel> savedCardList = [];
  //var manager = PaymentManager();
  late SwipeActionController controller;
  @override
  void initState() {
    super.initState();
    initSwipeController();
    savedCardList.add(LookingItemModel(title: "Doctor"));
    savedCardList.add(LookingItemModel(title: "Psychiatrist"));
    savedCardList.add(LookingItemModel(title: "Consultant"));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  initSwipeController() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "Looking for",
          needShadow: false,
          subtitle: "",
          subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  savedCardList.length == 0
                      ? Expanded(
                          child: NoDataWidget(
                          refresh: () {},
                        ))
                      : Expanded(child: bodyDesign()),
                  const SizedBox(
                    height: 20,
                  ),
                  // CustomButton.regular(
                  //   title: "Submit",
                  //   background: AppColor.theme,
                  //   onTap: () async {},
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                ])),
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
                height: 20,
              ),

              listView(),

              const SizedBox(
                height: 20,
              ),

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
      itemCount: savedCardList.length,
      itemBuilder: (conext, index) {
        return InkWell(
            onTap: () {
              Routes.pushSimple(context: context, child: ConsultantView());
            },
            child: _item(conext, index));
      },
      separatorBuilder: (BuildContext context, int index) {
        // ignore: prefer_const_constructors
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        );
      },
    );
  }

  Widget _item(BuildContext ctx, int index) {
    return LookingItemView(
      item: savedCardList[index],
      onDefaultSet: () {},
      onDeleted: () {},
    );
  }
}
