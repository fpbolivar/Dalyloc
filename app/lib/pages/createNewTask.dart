import 'package:daly_doc/pages/eventDetail.dart';
import 'package:daly_doc/pages/onboardingScreen.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/gradient/gradient.dart';
import 'package:daly_doc/widgets/timeWidget/timewidget.dart';

import '../utils/exportPackages.dart';
import '../utils/exportScreens.dart';

class CreateNewTask extends StatefulWidget {
  CreateNewTask({Key? key}) : super(key: key);

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  List data = [
    "Once",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  List data2 = [
    "Mark Complete",
    "Repeat",
    "Strikethrough",
  ];
  List dataTimeDiffrence = [
    "15m",
    "30m",
    "45m",
    "1h",
    "1.5h",
  ];

  int rexIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.curveViewBgColor,
      body: BackgroundCurveView(
          child: Column(children: [
        CustomBackButton(
          title: "Create new task",
          rightTrailingWidget: IconButton(
              onPressed: () {
                Routes.pushSimple(
                    context: context, child: NotificationScreen());
              },
              icon: const Icon(Icons.notifications)),
        ),
        bodyView(),
      ])),
    );
  }

//METHOD : -  BodyView Method
  Widget bodyView() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              typeTaskTF(),
              const SizedBox(
                height: 20,
              ),
              timeSelectorWidget(),
              const SizedBox(
                height: 10,
              ),
              howLongSelectorWidget(),
              const SizedBox(
                height: 10,
              ),
              howOftenSelectorWidget(),
              markCompleteRepeatStrikeOptionWidget(),
              noteTFWidget(),
              const SizedBox(
                height: 20,
              ),
              continueButtonWidget(),
              const SizedBox(
                height: 50,
              ),
            ]),
      ),
    );
  }

//METHOD : -  typeTaskTF  ## TextField Task
  Widget typeTaskTF() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            "Type task below",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white),
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width - 100,
            child: const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                hintText: "Email light company",
              ),
            )),
      ],
    );
  }

//METHOD : -  timeSelectorWidget  ## TimeInteval
  Widget timeSelectorWidget() {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "when ?",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
        ),
        const TimeWidget(),
      ],
    );
  }

//METHOD : -  howLongSelectorWidget  ## MinutesInteval
  Widget howLongSelectorWidget() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "How Long ?",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
        ),
        ListData(
          data: dataTimeDiffrence,
        ),
      ],
    );
  }

//METHOD : -  howOftenSelectorWidget  ## DailyBaisisInteval
  Widget howOftenSelectorWidget() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "How often ?",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
        ),
        ListData(
          data: data,
        ),
      ],
    );
  }

//METHOD : -  markCompleteRepeatStrikeOptionWidget  ## Complete|Repeat|Strike
  Widget markCompleteRepeatStrikeOptionWidget() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.builder(
        itemCount: data2.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              InkWell(
                onTap: () {
                  print(data2[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data2[index],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              index != 2
                  ? const Text(
                      "|",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  : SizedBox(),
            ],
          );
        },
      ),
    );
  }

//METHOD : -  noteTFWidget  ## Textfield Note
  Widget noteTFWidget() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black54,
      ),
      width: MediaQuery.of(context).size.width - 50,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Notes:",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.red),
              ),
              TextField(
                maxLines: 3,
              )
            ],
          ),
        ),
      ),
    );
  }

//METHOD : -  continueButtonWidget ## ActionButton
  Widget continueButtonWidget() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: CustomButton(
          onTap: () {
            Routes.pushSimple(context: context, child: EventDetail());
          },
          title: "Continue",
          titleColor: Colors.black,
          background: Color.fromARGB(255, 13, 12, 12),
          height: 50,
          radius: 30,
          width: 250,
        ));
  }
}

class ListData extends StatefulWidget {
  List data = [];

  ListData({Key? key, required this.data}) : super(key: key);

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  int dataIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black54,
      ),
      child: ListView.builder(
        itemCount: widget.data.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    dataIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: index == dataIndex ? Colors.red : Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.data[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
