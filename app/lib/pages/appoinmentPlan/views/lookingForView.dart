import 'package:daly_doc/pages/appoinmentPlan/components/lookingItemWidget.dart';
import 'package:daly_doc/pages/appoinmentPlan/manager/appointmentApi.dart';

import 'package:daly_doc/pages/appoinmentPlan/views/consultantView.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/businessCatModel.dart';
import 'package:daly_doc/widgets/noDataWidget/noDataWidget.dart';
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
  List<BusinessCatModel> catData = [];
  bool isLoading = false;
  //var manager = PaymentManager();
  late SwipeActionController controller;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCategories();
    });
  }

  getCategories() async {
    isLoading = true;
    setState(() {});
    var catDataTemp = await AppointmentApi().getBusinessCat();
    isLoading = false;
    setState(() {});
    catData = catDataTemp!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navBarWhite,
      appBar: CustomAppBarPresentCloseButton(
          colorNavBar: AppColor.navBarWhite,
          title: "Looking for",
          needShadow: false,
          subtitle: "",
          subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
          color: AppColor.navBarWhite,
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isLoading
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: loaderList(),
                            )
                          : catData.length == 0
                              ? Expanded(
                                  child: NoDataItemWidget(
                                  refresh: () {
                                    getCategories();
                                  },
                                  msg: 'Categories not found',
                                ))
                              : Expanded(child: bodyDesign()),

                      // CustomButton.regular(
                      //   title: "Submit",
                      //   background: AppColor.theme,
                      //   onTap: () async {},
                      // ),
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

              //
            ]),
      ),
    );
  }

  Widget listView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 20),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: catData.length,
      itemBuilder: (conext, index) {
        return InkWell(
            onTap: () {
              Routes.pushSimple(
                  context: context,
                  child: ConsultantView(
                    catId: catData[index].id ?? "",
                    title: catData[index].name ?? "",
                  ));
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
      item: catData[index],
      onDefaultSet: () {},
      onDeleted: () {},
    );
  }
}
