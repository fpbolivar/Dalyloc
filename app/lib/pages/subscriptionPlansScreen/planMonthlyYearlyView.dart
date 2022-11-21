import 'package:daly_doc/pages/settingsScreen/ApiManager/AllPlansApiManager.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import 'package:daly_doc/widgets/htmlRender/htmlRender.dart';

import 'package:daly_doc/widgets/socialLoginButton/socialLoginButton.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportScreens.dart';
import '../../../utils/exportWidgets.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/carousel/carousel_slider.dart';
import '../settingsScreen/model/allPlanMode.dart';
import 'model/PlanInfoModel.dart';

class PlanMonthlyYearlyView extends StatefulWidget {
  String? title;
  List<SubscriptionSubPlansModel>? subscriptionSubPlans;
  PlanMonthlyYearlyView({Key? key, this.title, this.subscriptionSubPlans})
      : super(key: key);

  @override
  State<PlanMonthlyYearlyView> createState() => _PlanMonthlyYearlyViewState();
}

class _PlanMonthlyYearlyViewState extends State<PlanMonthlyYearlyView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<PlanInfoModel> data = [
    PlanInfoModel(
        title: "Meal Plan",
        description:
            "<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Exclusive Deals</li></ul>",
        periodDuration: PlanType.monthly,
        price: "\$2.99",
        image: ""),
    PlanInfoModel(
        title: "Meal Plan",
        description:
            "<ul><li>Upload Video with HD Resolution</li><li>Attachment &amp; Post Scheduling</li><li>Set your rates</li><li>Offers on Supplyments</li><li>Free booster drinks</li><li>No charge to join health community.</li><li>Exclusive Deals</li></ul>",
        price: "\$32.99",
        periodDuration: PlanType.yearly,
        image: ""),
  ];
  SubscriptionSubPlansModel? selectedItem;
  var title = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.subscriptionSubPlans != null)
      selectedItem = widget.subscriptionSubPlans!.first;
    title = widget.title ?? "";
    print(title);
    title = title.replaceAll("Plans", "");
    title = title.replaceAll("plans", "");
    title = title.replaceAll("plan", "");
    title = title.replaceAll("Plan", "");
    title = title.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: title, subtitle: "Plan", subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: bodyDesign()),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {
            ToastMessage.confrimationToast(
                msg: LocalString.msgWantBuyPlanTask,
                OnTap: () {
                  print(selectedItem!.type.toString());
                  AllPlansApiManager().planSubcribe(
                    planId: selectedItem!.subscriptionPlanId.toString(),
                    type: selectedItem!.type.toString(),
                  );
                });
          },
          child: Container(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 50,
                      color: AppColor.theme,
                      // ignore: prefer_const_constructors
                      child: Center(
                        child: const Text("Proceed",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  color: AppColor.segmentBarSelectedColor,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("\$ ${selectedItem?.price}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white)),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: data.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: 12.0,
            height: 12.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );
  }

  Widget carouselView() {
    return Container(
      child: CarouselSlider(
        carouselController: _controller,
        options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.8,
            autoPlay: false,
            viewportFraction: 1,
            //   aspectRatio: 2.0,
            //   enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              print(index);

              setState(() {
                _current = index;
              });
            }),
        items: itemCarousel(),
      ),
    );
  }

  List<Widget> itemCarousel() {
    return widget.subscriptionSubPlans!
        .map((item) => Container(
              child: InkWell(
                onTap: () {
                  print("d");
                  setState(() {
                    selectedItem = item;
                    //selectedID = item.id ?? 0;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      child: Container(
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 1.5, color: AppColor.theme
                                  //                   <--- border width here
                                  ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      item.type.toString().toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: AppColor.textBlackColor),
                                    ),
                                    HTMLRender(
                                      data: item.description.toString(),
                                    ),
                                    IgnorePointer(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 20),
                                        child: CustomButton.regular(
                                          fontSize: 23,
                                          fontweight: FontWeight.w600,
                                          title: "\$ ${item.price}.00",
                                          height: 40,
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                                    indicator(),
                                  ],
                                ),
                                if (selectedItem != null)
                                  if (selectedItem?.id == item.id)
                                    Positioned(
                                        top: 5,
                                        right: 10,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: Icon(Icons.check_circle),
                                        ))
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ))
        .toList();
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
          Text(
            "Your daily planner app to help you organise your life, automating you success towards achieving you goals each day.",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColor.halfGrayTextColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Choose the best plan fit your needs",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColor.textBlackColor),
          ),
          const SizedBox(
            height: 20,
          ),
          carouselView(),
        ],
      )),
    );
  }
}
