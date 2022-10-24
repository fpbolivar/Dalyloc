import '../utils/exportAllModels.dart';
import '../utils/exportPackages.dart';
import '../utils/exportScreens.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // PageController controller = PageController();

  List<SliderModel> mySLides = <SliderModel>[];
  int slideIndex = 0;
  late PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(gradient: GradientColor.getGradient()),
      child: Material(
        // backgroundColor: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Stack(
            children: [
              PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    slideIndex = index;
                  });
                },
                children: [
                  GetStartedScreen(
                    imagePath: mySLides[0].getImageAssetPath(),
                    title: mySLides[0].getTitle(),
                    desc: mySLides[0].getDesc(),
                    ontap: () {
                      controller.animateToPage(slideIndex + 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                  ),
                  ChooseAccountTypeScreen(
                    imagePath: mySLides[1].getImageAssetPath(),
                    title: mySLides[1].getTitle(),
                    desc: mySLides[1].getDesc(),
                    ontap: () {
                      controller.animateToPage(slideIndex + 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                  ),
                  wakeUpTime(
                    imagePath: mySLides[2].getImageAssetPath(),
                    ontap: () {
                      controller.animateToPage(slideIndex + 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                  ),
                  Reminder(
                    imagePath: "assets/icons/bell.png",
                    title: mySLides[3].getTitle(),
                    desc: mySLides[3].getDesc(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // TextButton(
                        //   onPressed: () {},
                        //   // splashColor: Colors.blue[50],
                        //   child: Text(
                        //     "SKIP",
                        //     style: TextStyle(
                        //         color: Colors.red,
                        //         fontSize: screenW <= 500 ? 15 : 20,
                        //         fontWeight: FontWeight.w600),
                        //   ),
                        // ),
                        Container(
                          child: Row(
                            children: [
                              for (int i = 0; i < 4; i++)
                                i == slideIndex
                                    ? _buildPageIndicator(true)
                                    : _buildPageIndicator(false),
                            ],
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () {},
                        //   // splashColor: Colors.blue[50],
                        //   child: Text(
                        //     slideIndex != 3 ? "NEXT" : "START",
                        //     style: TextStyle(
                        //         color: Color(0xFFffffff),
                        //         fontSize: screenW <= 500 ? 15 : 20,
                        //         fontWeight: FontWeight.w600),
                        //   ),
                        // ),
                      ],
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
