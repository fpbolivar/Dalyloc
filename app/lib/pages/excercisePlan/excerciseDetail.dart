import 'package:daly_doc/pages/excercisePlan/manager/exerciseApi.dart';
import 'package:daly_doc/pages/excercisePlan/model/exerciseDataModel.dart';
import 'package:daly_doc/pages/excercisePlan/workoutVideoScreen.dart';
import 'package:daly_doc/widgets/components/imageLoadView.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';
import 'package:daly_doc/widgets/noDataWidget/noDataWidget.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../../widgets/carousel/carousel_controller.dart';
import '../../widgets/carousel/carousel_slider.dart';
import 'Comonent/carouselHeaderSliver.dart';

class ExcerciseDetailScreen extends StatefulWidget {
  String? title = "";
  String? id = "";
  ExcerciseDetailScreen({Key? key, this.title, this.id}) : super(key: key);

  @override
  State<ExcerciseDetailScreen> createState() => _ExcerciseDetailScreenState();
}

class _ExcerciseDetailScreenState extends State<ExcerciseDetailScreen>
    with SingleTickerProviderStateMixin {
  int pageIndex = 0;
  int _selected = 0;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  bool isLoading = false;

  var managerExercise = ExerciseAPI();
  List dataChips = [];
  ExerciseReponseModel? dataExercise;
  final ScrollController _sliverScrollController = ScrollController();
  var isPinned = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollListner();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getExercise();
    });
  }

  scrollListner() {
    _sliverScrollController.addListener(() {
      print("_sliverScrollController.offset${_sliverScrollController.offset}");
      print("_sliverScrollController.kToolbarHeight${kToolbarHeight}");
      if (_sliverScrollController.offset > 190) {
        setState(() {
          isPinned = true;
        });
      } else {
        setState(() {
          isPinned = false;
        });
      }
      // if (!isPinned &&
      //     _sliverScrollController.hasClients &&
      //     _sliverScrollController.offset > kToolbarHeight) {
      //   setState(() {
      //     isPinned = true;
      //   });
      // } else if (isPinned &&
      //     _sliverScrollController.hasClients &&
      //     _sliverScrollController.offset < kToolbarHeight) {
      //   setState(() {
      //     isPinned = false;
      //   });
      // }
    });
  }

  getExercise() async {
    isLoading = true;
    setState(() {});
    print(" widget.id${widget.id}");
    ExerciseReponseModel? data =
        await managerExercise.getExerciseByWorkOutID(workOutID: widget.id);
    isLoading = false;
    setState(() {});
    if (data != null) {
      dataExercise = data;
      dataChips = [];
      dataChips.add("${dataExercise!.levelData!.workout_name}");
      dataChips.add("${dataExercise!.workout_time} seconds");
      dataChips.add("${dataExercise!.exerciseList!.length} Exercise");
    } else {
      dataExercise = ExerciseReponseModel(
          exerciseList: [],
          total_time: "",
          workout_name: "",
          workout_time: "",
          workout_image: "");
    }
    setState(() {});
  }

  var duration = const Duration(milliseconds: 300);
  noWorkOutData() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: NoDataItemWidget(
        refresh: () {
          getExercise();
        },
        msg: 'Exercise not found.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      floatingActionButton: dataExercise == null
          ? null
          : dataExercise!.exerciseList!.length == 0
              ? null
              : FloatingActionButton.extended(
                  onPressed: () {
                    managerExercise.startWorkOut(workOutID: widget.id);

                    Routes.pushSimple(
                      context: context,
                      child: WorkoutVideoScreen(
                        data: dataExercise!.exerciseList!.first,
                        dataList: dataExercise!.exerciseList!,
                        // title: dataExercise!
                        //     .exerciseList![index].exercise_name
                        //     .toString(),
                      ),
                    );
                    // Add your onPressed code here!
                  },
                  label: const Text('Start'),
                  icon: const Icon(Icons.thumb_up),
                  backgroundColor: AppColor.theme,
                ),
      // appBar: CustomAppBar(onTap: () {
      //   Navigator.pop(context);
      // }),
      body: isLoading
          ? appBar()
          : dataExercise == null
              ? appBar()
              : dataExercise!.exerciseList!.length == 0
                  ? appBar()
                  : viewBodySliverList(),
    );
  }

  appBar() {
    return SafeArea(
      child: DefaultTabController(
          length: 3,
          child: CustomScrollView(slivers: <Widget>[
            CarouselHeaderImagView(
              imgList: "",
            ),
            SliverFillRemaining(
              child: isLoading ? loaderList() : noWorkOutData(),
            )
          ])),
    );
  }

  viewBodySliverList() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: CustomScrollView(
                controller: _sliverScrollController,
                slivers: <Widget>[
                  CarouselHeaderImagView(
                    imgList: HttpUrls.WS_BASEURL + dataExercise!.workout_image!,
                  ),
                  SliverAppBar(
                      expandedHeight: 135,
                      automaticallyImplyLeading: false,
                      collapsedHeight: 135,
                      pinned: true,
                      floating: true,
                      backgroundColor: AppColor.newBgcolor,
                      flexibleSpace: Container(
                        //height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedSlide(
                              duration: duration,
                              offset:
                                  isPinned ? Offset.zero : const Offset(0, 2),
                              child: AnimatedOpacity(
                                duration: duration,
                                opacity: isPinned ? 1 : 0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(Icons.arrow_back_ios)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isPinned ? 10 : 0,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${dataExercise!.workout_name.toString().capitalize()}",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 40,
                              child: list(),
                            )
                          ],
                        ),
                      )),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Workout Activity",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverAnimatedList(
                      initialItemCount: dataExercise!.exerciseList!.length,
                      itemBuilder: (_, index, ___) {
                        ExerciseDataModel item =
                            dataExercise!.exerciseList![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        child: ImageLoadFromURL(
                                          fit: BoxFit.cover,
                                          imgURL: HttpUrls.WS_BASEURL +
                                              item.exercise_image.toString(),
                                        ),
                                      )),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Text(
                                          item.exercise_name
                                              .toString()
                                              .capitalize(),
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Text(
                                          "${item.exercise_time} Seconds",
                                          maxLines: 2,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        );
                      }),
                ],
              ),
            ),
          ),

          // ReceipeBottomButtonView(
          //   fromMyMealScrren: widget.fromMyMealScrren,
          //   addMealAction: () {
          //     if (mealItem == null) return;
          //     List<MealItemModel> data = [mealItem!];
          //     Routes.pushSimpleRootNav(
          //         context: context,
          //         child: ReviewAllMealPlanView(data: data));
          //   },
          // )
        ],
      ),
    );
  }

  list() {
    return Container(
      height: 40.0,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          //shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          //physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Container(
                // width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _selected == index
                      ? AppColor.weightScrollColor
                      : Colors.white,
                  border:
                      Border.all(color: AppColor.weightScrollColor, width: 2),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      dataChips[index].toString(),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16.0,
                          color:
                              _selected == index ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 15,
            );
          },
          itemCount: dataChips.length),
    );
  }
}
