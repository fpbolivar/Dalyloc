import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import 'excerciseDetail.dart';

class ExcercisePlanMainScreen extends StatefulWidget {
  ExcercisePlanMainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ExcercisePlanMainScreen> createState() =>
      _ExcercisePlanMainScreenScreenState();
}

class _ExcercisePlanMainScreenScreenState
    extends State<ExcercisePlanMainScreen> {
  int pageIndex = 0;
  int _selected = 0;
  List data1 = [
    {
      "name": "Squat Movement",
      "index": "0",
      "image": "assets/icons/Tint.png",
      "subtitle": "30 min  450 kcal"
    },
  ];
  List data2 = [
    {
      "name": "Full Body Strecting",
      "index": "1",
      "image": "assets/icons/image2.png",
      "subtitle": "30 min  450 kcal"
    },
    {
      "name": "Yoga Women",
      "index": "2",
      "image": "assets/icons/image3.png",
      "subtitle": "30 min  450 kcal"
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
      appBar: CustomAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        title: "Hi, John",
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: bodyDesign()
            // adminPrayer == null
            //     ? Center(child: CircularProgressIndicator())
            //     :

            ),
      )),
    );
  }

  Widget bodyDesign() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text(
          "Workout Levels",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        list(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        dataList(data1, "Pending Workout"),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        dataList(data2, "Explore"),
      ],
    ));
  }

  list() {
    List data = [
      {"name": "Beginner", "index": "0"},
      {"name": "Intermediate", "index": "1"},
      {"name": "Advanced", "index": "2"},
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

  dataList(data, title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: AppColor.weightScrollColor),
          ),
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Routes.pushSimple(
                      context: context,
                      child: ExcerciseDetailScreen(
                        title: data[index]["name"],
                      ));
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                data[index]["name"].toString(),
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
                                data[index]["subtitle"].toString(),
                                maxLines: 2,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          data[index]["image"],
                          fit: BoxFit.cover,
                          height: 80,
                        ),
                      ],
                    )
                    // ListTile(
                    //   onTap: () {
                    //     setState(() {
                    //       _selected = index;
                    //     });
                    //     print(_selected);
                    //     _selected.toString() == index;
                    //   },
                    //   title: Text(
                    //     data[index]["name"].toString(),
                    //     maxLines: 2,
                    //     textAlign: TextAlign.left,
                    //     style: TextStyle(fontSize: 16.0, color: Colors.black),
                    //   ),
                    //   subtitle: Text(
                    //     data[index]["subtitle"].toString(),
                    //     maxLines: 2,
                    //     textAlign: TextAlign.left,
                    //     style: TextStyle(fontSize: 14.0, color: Colors.black),
                    //   ),
                    //   trailing: Image.asset(
                    //     data[index]["image"],
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: data.length),
      ],
    );
  }
}
