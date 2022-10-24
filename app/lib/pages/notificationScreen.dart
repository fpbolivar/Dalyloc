import '../utils/exportPackages.dart';
import '../utils/exportScreens.dart';
import '../utils/exportWidgets.dart';

class NotificationScreen extends StatefulWidget {
  String? red;
  NotificationScreen({Key? key, this.red}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.curveViewBgColor,
      body: BackgroundCurveView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomBackButton(
                title: LocalString.lblNotification,
                rightTrailingWidget: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_box_outlined,
                      color: Colors.red,
                    )),
              ),
              const SizedBox(
                height: 100,
              ),
              bodyDesign()
            ]),
      ),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.inbox_rounded,
              color: Color(0xffB46931),
              size: 200,
            ),
            const Text(
              LocalString.lblPlaceReminder,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              LocalString.lblInboxMsg,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFF7D5E47),
              ),
              width: MediaQuery.of(context).size.width - 50,
              child: Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      icon: const Icon(
                        Icons.add_circle_outline_sharp,
                        color: Colors.white,
                      )),
                ],
              ),
            )
          ]),
    );
  }
}
