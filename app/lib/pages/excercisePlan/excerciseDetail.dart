import 'package:daly_doc/pages/excercisePlan/workoutVideoScreen.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../../widgets/carousel/carousel_controller.dart';
import '../../widgets/carousel/carousel_slider.dart';

class ExcerciseDetailScreen extends StatefulWidget {
  String? title = "";
  ExcerciseDetailScreen({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<ExcerciseDetailScreen> createState() => _ExcerciseDetailScreenState();
}

class _ExcerciseDetailScreenState extends State<ExcerciseDetailScreen> {
  int pageIndex = 0;
  int _selected = 0;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  List data1 = [
    {
      "name": "Side Plank",
      "index": "0",
      "image": "assets/icons/Tint.png",
      "subtitle": "20 Seconds"
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  getData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      body: SingleChildScrollView(
        child: BackgroundCurveView(
            child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items: imgList
                      .map((item) => ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          child: Image.network(item,
                              fit: BoxFit.cover, width: 1200.0)))
                      .toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                      viewportFraction: 1,
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      aspectRatio: 100,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  top: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          // ignore: prefer_const_constructors
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == entry.key
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: bodyDesign()
                // adminPrayer == null
                //     ? Center(child: CircularProgressIndicator())
                //     :

                ),
          ],
        )),
      ),
    );
  }

  list() {
    List data = [
      {"name": "Beginner", "index": "0"},
      {"name": "10 minutes", "index": "1"},
      {"name": "10 workouts", "index": "2"},
    ];
    return Container(
      height: 40.0,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selected = index;
                });
                print(_selected);
                _selected.toString() == index;
              },
              child: Container(
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _selected == index
                      ? AppColor.weightScrollColor
                      : Colors.white,
                  border:
                      Border.all(color: AppColor.weightScrollColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    data[index]["name"].toString(),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16.0,
                        color:
                            _selected == index ? Colors.white : Colors.black),
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
          itemCount: data.length),
    );
  }

  Widget bodyDesign() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.title}",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        list(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Container(
          height: 1,
          color: Colors.black38,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
          "Workout Activity",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        dataList(data1),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CustomButton.regular(
          title: "Continue",
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      ],
    ));
  }

  dataList(data) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Routes.pushSimple(
                context: context,
                child: WorkoutVideoScreen(
                  title: data[0]["name"].toString(),
                ),
              );
            },
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
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      child: Image.asset(
                        data[0]["image"],
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            data[0]["name"].toString(),
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            data[0]["subtitle"].toString(),
                            maxLines: 2,
                            textAlign: TextAlign.right,
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 5);
  }
}
