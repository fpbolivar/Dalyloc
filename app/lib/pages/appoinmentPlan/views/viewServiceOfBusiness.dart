import 'package:daly_doc/pages/appoinmentPlan/components/serviceItemView.dart';
import 'package:daly_doc/pages/appoinmentPlan/manager/appointmentApi.dart';

import 'package:daly_doc/pages/appoinmentPlan/views/addAppointmentFormView.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';
import 'package:daly_doc/widgets/noDataWidget/noDataWidget.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class ViewServiceOfBusiness extends StatefulWidget {
  ViewServiceOfBusiness({Key? key, this.bizID = "", this.title = ""})
      : super(key: key);
  String bizID = "";
  String title = "";
  @override
  State<ViewServiceOfBusiness> createState() => _ViewServiceOfBusinessState();
}

class _ViewServiceOfBusinessState extends State<ViewServiceOfBusiness> {
  List<ServiceItemDataModel> serviceList = [];
  var selectedIndex = -1;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getServiceOfBizness();
    });
  }

  getServiceOfBizness() async {
    isLoading = true;
    setState(() {});
    var tempData = await AppointmentApi()
        .getUserBusinessServices(businessId: widget.bizID);
    isLoading = false;
    setState(() {});
    serviceList = tempData!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navBarWhite,
      appBar: CustomAppBarPresentCloseButton(
          colorNavBar: AppColor.navBarWhite,
          title: widget.title,
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
                      if (serviceList.length != 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            "Choose a service offered by business",
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
                          : serviceList.length == 0
                              ? Expanded(
                                  child: NoDataItemWidget(
                                  refresh: () {
                                    getServiceOfBizness();
                                  },
                                  msg: 'Services not found',
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
              // const SizedBox(
              //   height: 20,
              // ),

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
      itemCount: serviceList.length,
      itemBuilder: (conext, index) {
        return InkWell(
            onTap: () {
              selectedIndex = index;
              setState(() {});
              Routes.pushSimple(
                  context: context,
                  child: AddAppointmentFormView(
                    serviceDetail: serviceList[index],
                    title: widget.title,
                  ));
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
    return ServiceItemView(
      itemData: serviceList[index],
      currentIndex: index,
      selectedIndex: selectedIndex,
    );
  }
}
