import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';
import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import 'exeercisePlanMainScreen.dart';

class ExcercisePlanScreen extends StatefulWidget {
  ExcercisePlanScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ExcercisePlanScreen> createState() => _ExcercisePlanScreenScreenState();
}

class _ExcercisePlanScreenScreenState extends State<ExcercisePlanScreen> {
  int pageIndex = 0;
  int _selected = 0;
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
          if (pageIndex > 0) {
            pageIndex = pageIndex - 1;
            setState(() {});
            print(pageIndex);
          } else {
            Navigator.pop(context);
          }
        },
        title: pageIndex == 0
            ? LocalString.lbltellUsTitle
            : pageIndex == 1
                ? LocalString.lblHowOldTitle
                : pageIndex == 2
                    ? LocalString.lblWeight
                    : pageIndex == 3
                        ? LocalString.lblheight
                        : LocalString.lblLevel,
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: bodyDesign()
            // adminPrayer == null
            //     ? Center(child: CircularProgressIndicator())
            //     :

            ),
      )),
    );
  }

  button() {
    return CustomButton.regular(
      title: "Continue",
      onTap: () {
        if (pageIndex < 4) {
          setState(() {
            pageIndex = pageIndex + 1;
            print(pageIndex);
          });
        } else {
          Routes.pushSimple(context: context, child: ExcercisePlanMainScreen());
        }
      },
    );
  }

  Widget bodyDesign() {
    return SingleChildScrollView(
        child: pageIndex == 0
            ? gender()
            : pageIndex == 1
                ? dob()
                : pageIndex == 2
                    ? weight()
                    : pageIndex == 3
                        ? height()
                        : physicalActivity());
  }

  Widget dob() {
    var time = "";

    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          LocalString.lblExcercisePlanScreenDc2,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w200,
          ),
        ),

        // This displays the selected fruit name.

        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: MediaQuery.of(context).size.height * 0.3,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newDateTime) {
              print(time);
              setState(() {
                time = DateFormat("dd/MM/yyyy").format(newDateTime).toString();
              });
            },
            maximumYear: DateTime.now().year,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.32),
        button(),
        const SizedBox(height: 50)
      ],
    );
  }

  Widget physicalActivity() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          LocalString.lblExcercisePlanScreenDc3,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w200,
          ),
        ),

        // This displays the selected fruit name.

        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        list(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.4),
        button(),
      ],
    );
  }

  Widget gender() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          LocalString.lblExcercisePlanScreenDc,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w200,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        imageGender(imagePath: "assets/icons/Female.png", text: "Female"),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        imageGender(imagePath: "assets/icons/Male.png", text: "Male"),
        //
        SizedBox(height: MediaQuery.of(context).size.height * 0.14),
        button(),
        const SizedBox(height: 50)
      ],
    );
  }

  Widget weight() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          LocalString.lblExcercisePlanScreenDc2,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w200,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        RotatedBox(
          quarterTurns: 1,
          child: Container(
            width: 100,
            child: CupertinoPicker(
              magnification: 1,

              useMagnifier: false,

              itemExtent: 120,
              // This is called when selected item is changed.
              onSelectedItemChanged: (int selectedItem) {
                setState(() {
                  _selected = selectedItem;
                  print("${_selected} Kg Weight");
                });
              },
              children: List<Widget>.generate(200, (int index) {
                return Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: AppColor.weightScrollColor),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        Image.asset("assets/icons/Polygon.png"),
        // This displays the selected fruit name.

        //
        SizedBox(height: MediaQuery.of(context).size.height * 0.47),
        button(),
      ],
    );
  }

  Widget height() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          LocalString.lblExcercisePlanScreenDc2,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w200,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotatedBox(
                quarterTurns: 1,
                child: Image.asset("assets/icons/Polygon.png")),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 150,
              height: MediaQuery.of(context).size.height * 0.4,
              child: CupertinoPicker(
                magnification: 1.5,

                useMagnifier: false,

                itemExtent: 80,
                // This is called when selected item is changed.
                onSelectedItemChanged: (int selectedItem) {
                  setState(() {
                    _selected = selectedItem;
                  });
                  print("${_selected}CM Height");
                },
                children: List<Widget>.generate(200, (int index) {
                  return Center(
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColor.weightScrollColor),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),

        // This displays the selected fruit name.

        //
        SizedBox(height: MediaQuery.of(context).size.height * 0.219),
        button(),
        const SizedBox(height: 50)
      ],
    );
  }

  Widget imageGender({imagePath, text}) {
    return InkWell(
      onTap: () {
        print(text);
      },
      child: Column(
        children: [
          Image.asset(imagePath.toString()),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  list() {
    List data = [
      {"name": "Beginner", "index": "0"},
      {"name": "Intermediate", "index": "1"},
      {"name": "Advanced", "index": "2"},
    ];
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _selected == index
                    ? AppColor.weightScrollColor
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    _selected = index;
                  });
                  print(_selected);
                  _selected.toString() == index;
                },
                title: Text(
                  data[index]["name"].toString(),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _selected == index ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: data.length);
  }
}
