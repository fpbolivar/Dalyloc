import 'package:daly_doc/pages/mealPlan/manager/mealApi.dart';
import 'package:daly_doc/pages/mealPlan/model/foodTagModel.dart';
import 'package:daly_doc/widgets/ToastBar/toastMessage.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';

class AllergiesFoodListView extends StatefulWidget {
  String? red;
  AllergiesFoodListView({Key? key, this.red, this.gotoNext = false})
      : super(key: key);
  bool? gotoNext = false;
  @override
  State<AllergiesFoodListView> createState() => _AllergiesFoodListViewState();
}

class _AllergiesFoodListViewState extends State<AllergiesFoodListView> {
  List<FoodTagsModel> tags = [];
  MealApis manager = MealApis();
  var goToNext = true;
  var selecteIndex = -1;
  @override
  void initState() {
    super.initState();
    goToNext = widget.gotoNext ?? false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getTag();
    });
  }

  getTag() async {
    List<FoodTagsModel>? tempResponse = await manager.getAllergiesFood();
    if (tempResponse != null) {
      tags = [];
      tags = tempResponse;
      for (int i = 0; i < tags.length; i++) {
        if (tags[i].selected == true) {
          selecteIndex = i;
          break;
        }
      }
      setState(() {});
    } else {
      tags = [];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "Do you have any",
          subtitle: "Allergies?",
          subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: tags.length == 0
                ? simpleMessageShow("Currently,Item not found.")
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(child: bodyDesign()),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton.regular(
                          title: "Continue",
                          background: selecteIndex == -1
                              ? Colors.grey[400]
                              : AppColor.theme,
                          onTap: () async {
                            List<int> ids = getSelectedIDS();
                            bool? result =
                                await manager.createMeal(allergies_id: ids);
                            if (result != null && goToNext) {
                              if (result == true) {
                                Routes.pushSimple(
                                    context: context,
                                    child: LikesFoodListView(gotoNext: true));
                              }
                            } else {
                              if (result == true) {
                                ToastMessage.showSuccessMessage(
                                    msg:
                                        "Your allergies items has been updated.",
                                    color: AppColor.purple);
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ])),
      )),
    );
  }

  getSelectedIDS() {
    List<int> ids = [];

    for (int i = 0; i < tags.length; i++) {
      if (tags[i].selected == true) {
        ids.add(tags[i].id);
      }
    }
    print(ids);
    return ids;
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

              tagList(),
              const SizedBox(
                height: 20,
              ),

              //
            ]),
      ),
    );
  }

  tagList() {
    return tags.length == 0
        ? Container()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 5.0,
                      alignment: WrapAlignment.start,
                      children: List<Widget>.generate(tags.length, (int index) {
                        return Container(
                          height: 38,
                          child: ActionChip(
                              label: Text(
                                tags[index].title,
                                style: TextStyle(
                                    color: tags[index].selected
                                        ? Colors.white
                                        : AppColor.theme),
                              ),
                              backgroundColor: tags[index].selected
                                  ? AppColor.stripGreen
                                  : AppColor.tagBgColor,
                              elevation: 1.0,
                              //shadowColor: Colors.grey[60],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9)),
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                tags[index].selected = !tags[index].selected;
                                List<int> ids = getSelectedIDS();
                                if (ids.length == 0) {
                                  selecteIndex = -1;
                                } else {
                                  selecteIndex = 1;
                                }
                                setState(() {});
                              }),
                        );
                      }),
                    ),
                  ),
                ]),
          );
  }
}
