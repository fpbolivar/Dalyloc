import '../utils/exportPackages.dart';
import '../utils/exportScreens.dart';
import '../utils/exportWidgets.dart';

class EventDetail extends StatefulWidget {
  EventDetail({Key? key}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  List data = [
    "Once",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  List weekDays = [
    "Sunday",
    "Manday",
    "Thuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
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
      backgroundColor: const Color.fromARGB(164, 12, 4, 123),
      body: Container(
        margin: const EdgeInsets.only(top: 70),
        height: MediaQuery.of(context).size.height - 70,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color.fromARGB(164, 12, 4, 123),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
              color: Color(0xFF575555)),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const Text(
                  "Event Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white),
                ),
                TextButton(
                    onPressed: () {
                      Routes.pushSimple(
                          context: context, child: ScheduleOptionScreen());
                    },
                    child: const Text(
                      "Share",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Colors.blue),
                    )),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      boxWidget(
                        title: "Days and times",
                        height: 290,
                        width: MediaQuery.of(context).size.width - 50,
                        data: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "DATE RANGE",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.black26,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.white,
                                        size: 15,
                                      )),
                                )
                              ],
                            ),
                            const Break(),
                            const SizedBox(
                              height: 10,
                            ),
                            ListData(data: weekDays),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width - 100,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.data.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    dataIndex = index;
                  });
                  print(widget.data[dataIndex]);
                },
                child:
                    //  Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //     // color: index == dataIndex ? Colors.red : Colors.transparent,
                    //   ),
                    //   child:
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        widget.data[index],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      index == 0 || index == widget.data.length - 1
                          ? "Unavaliable"
                          : "9am - 6pm",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              // ),
              index == widget.data.length - 1 ? const SizedBox() : const Break()
            ],
          );
        },
      ),
    );
  }
}

class boxWidget extends StatelessWidget {
  String? imagePath, title;
  IconData? icon;
  double? height;
  double? width;
  Widget? data;
  Function()? ontap;
  boxWidget(
      {this.imagePath,
      this.title,
      this.ontap,
      this.data,
      this.icon,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    print(
      0.20 * height!,
    );
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Colors.black26),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: height,
      width: width,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              icon == null ? const SizedBox() : Icon(icon)
            ],
          ),
          Container(
            child: data,
          )
        ],
      ),
    );
  }
}

class Break extends StatelessWidget {
  const Break({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      // width: ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Colors.black26,
      ),
    );
  }
}
