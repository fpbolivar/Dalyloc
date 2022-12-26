import 'package:daly_doc/pages/appoinmentPlan/components/consultantItemView.dart';
import 'package:daly_doc/pages/appoinmentPlan/components/noDataWidget.dart';
import 'package:daly_doc/pages/appoinmentPlan/manager/appointmentApi.dart';

import 'package:daly_doc/pages/appoinmentPlan/views/viewServiceOfBusiness.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/userBusinesModel.dart';
import 'package:daly_doc/widgets/noDataWidget/noDataWidget.dart';
import 'package:daly_doc/widgets/swipeAction/flutter_swipe_action_cell.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class ConsultantView extends StatefulWidget {
  ConsultantView({Key? key, this.catId = "", this.title = ""})
      : super(key: key);
  String catId = "";
  String title = "";
  @override
  State<ConsultantView> createState() => _ConsultantViewState();
}

class _ConsultantViewState extends State<ConsultantView> {
  List<UserBusinessModel> businessData = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getBizness();
    });
  }

  getBizness() async {
    isLoading = true;
    setState(() {});
    var catDataTemp =
        await AppointmentApi().getBusinessByCatID(id: widget.catId);
    isLoading = false;
    setState(() {});
    businessData = catDataTemp!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navBarWhite,
      appBar: CustomAppBarPresentCloseButton(
          colorNavBar: AppColor.navBarWhite,
          title: "Consultant",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "${widget.title}",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      isLoading
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: loaderList(),
                            )
                          : businessData.isEmpty
                              ? Expanded(
                                  child: NoDataItemWidget(
                                  refresh: () {
                                    getBizness();
                                  },
                                  msg: 'Consultant businesses not found',
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
      itemCount: businessData.length,
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
    return InkWell(
      onTap: () {
        Routes.pushSimple(
            context: context,
            child: ViewServiceOfBusiness(
              bizID: businessData[index].id ?? "",
              title: businessData[index].businessName ?? "",
            ));
      },
      child: ConsultantItemView(
        itemData: businessData[index],
      ),
    );
  }
}
