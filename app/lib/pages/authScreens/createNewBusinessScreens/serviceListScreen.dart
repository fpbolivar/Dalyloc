import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/components/serviceItemWidget.dart';
import 'package:daly_doc/pages/authScreens/createNewBusinessScreens/createNewBusinessService.dart';

import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class ServiceListVCView extends StatefulWidget {
  ServiceListVCView({Key? key}) : super(key: key);

  @override
  State<ServiceListVCView> createState() => _ServiceListVCViewState();
}

class _ServiceListVCViewState extends State<ServiceListVCView> {
  List<ServiceItemDataModel> allServices = [];
  BusinessApis manager = BusinessApis();
  var goToNext = true;
  var selecteIndex = -1;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMenu();
    });
  }

  getMenu() async {
    List<ServiceItemDataModel>? tempResponse =
        await manager.getUserBusinessServices();
    // await manager.getUserBusinessServices("1");
    if (tempResponse != null) {
      allServices = [];
      allServices = tempResponse;
      for (int i = 0; i < allServices.length; i++) {
        if (allServices[i].isSelected == true) {
          selecteIndex = i;
          break;
        }
      }
      setState(() {});
    } else {
      allServices = [];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "Your Services",
          subtitle: "",
          subtitleColor: AppColor.textGrayBlue),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Routes.pushSimple(
              context: context, child: CreateNewBusinessServiceScreen());
        },
        backgroundColor: AppColor.theme,
        child: const Icon(Icons.add),
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: allServices.length == 0
                ? simpleMessageShow(
                    "Currently,You are not add any service.\nAdd Service by Click + add button.")
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(child: bodyDesign()),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton.regular(
                          title: "Add New Service",
                          background: selecteIndex == -1
                              ? Colors.grey[400]
                              : AppColor.theme,
                          onTap: () async {
                            //   if (selecteIndex == -1) {
                            //     return;
                            //   }
                            //   bool? result = await manager.createMeal(
                            //       menu_type_id: allDiet[selecteIndex].id);
                            //   if (result != null && goToNext) {
                            //     if (result == true) {
                            //       Routes.pushSimple(
                            //           context: context,
                            //           child: AllergiesFoodListView(
                            //             gotoNext: true,
                            //           ));
                            //     }
                            //   } else {
                            //     if (result == true) {
                            //       ToastMessage.showSuccessMessage(
                            //           msg: "Your diet item has been updated.",
                            //           color: AppColor.purple);
                            //     }
                            //   }
                          },
                        ),
                        const SizedBox(
                          height: 20,
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
      itemCount: allServices.length,
      itemBuilder: (conext, index) {
        return InkWell(
            onTap: () {},
            child: ServiceItemView(
              itemData: allServices[index],
              onSelected: () {
                // allDiet.forEach((element) {
                //   element.isSelected = false;
                // });
                // allDiet[index].isSelected = !allDiet[index].isSelected;
                // selecteIndex = index;
                setState(() {});
              },
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        // ignore: prefer_const_constructors
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
        );
      },
    );
  }
}
