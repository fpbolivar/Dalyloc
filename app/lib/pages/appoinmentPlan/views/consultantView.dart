import 'package:daly_doc/pages/appoinmentPlan/components/consultantItemView.dart';
import 'package:daly_doc/pages/appoinmentPlan/components/noDataWidget.dart';
import 'package:daly_doc/pages/appoinmentPlan/model/consultantModel.dart';
import 'package:daly_doc/widgets/swipeAction/flutter_swipe_action_cell.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class ConsultantView extends StatefulWidget {
  ConsultantView({
    Key? key,
  }) : super(key: key);

  @override
  State<ConsultantView> createState() => _ConsultantViewState();
}

class _ConsultantViewState extends State<ConsultantView> {
  List<ConsultantItemModel> savedCardList = [];
  //var manager = PaymentManager();
  late SwipeActionController controller;
  @override
  void initState() {
    super.initState();
    initSwipeController();
    savedCardList.add(ConsultantItemModel(
        title: "Bryant & Fulton",
        description: "211 Carr Town Rd, Rose Hill,NC 28458",
        price: "12.99"));
    savedCardList.add(ConsultantItemModel(
        title: "Code Optimal Solutions",
        description: "211 Carr Town Rd, Rose Hill,NC 28458",
        price: "12.99"));
    savedCardList.add(ConsultantItemModel(
        title: "Consultant",
        description: "211 Carr Town Rd, Rose Hill,NC 28458",
        price: "12.99"));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  initSwipeController() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "Consultant",
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
              // Routes.presentSimple(
              //     context: context,
              //     child: PlanDetailView(
              //       data: freePlan[index],
              //     ));
              //onTap!(itemList[index].section ?? 0, index);
            },
            child: _item(conext, index));
      },
      separatorBuilder: (BuildContext context, int index) {
        // ignore: prefer_const_constructors
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
        );
      },
    );
  }

  Widget _item(BuildContext ctx, int index) {
    return ConsultantItemView(
      itemData: savedCardList[index],
    );
  }
}
