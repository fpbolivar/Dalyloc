import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

import '../../core/colors/colors.dart';
import '../../utils/exportPackages.dart';
import '../../widgets/appBar/CustomAppBar.dart';
import '../../widgets/backgroundCurveView/backgroundCurveView.dart';
import '../../widgets/videoPlayer/videoplayer.dart';
import 'Comonent/timer.dart';

class WorkoutVideoScreen extends StatefulWidget {
  String? title = '';
  WorkoutVideoScreen({super.key, this.title});

  @override
  State<WorkoutVideoScreen> createState() => _WorkoutVideoScreenState();
}

class _WorkoutVideoScreenState extends State<WorkoutVideoScreen> {
  String? sources;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.newBgcolor,
        appBar: CustomAppBar(
          onTap: () {
            Navigator.pop(context);
          },
          title: "Yoga Women",
        ),
        body: BackgroundCurveView(
            child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: bodyDesign()),
        )),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: AppColor.newBgcolor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 1,
              ),
              CustomButton.regular(
                height: 40,
                width: 140,
                title: "Previous",
                background: Colors.grey,
                titleColor: Colors.black,
              ),
              CustomButton.regular(
                height: 40,
                width: 140,
                title: "Next",
                background: AppColor.weightScrollColor,
              ),
              SizedBox(
                width: 1,
              ),
            ],
          ),
        ));
  }

  Widget bodyDesign() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Padding(
          padding: const EdgeInsets.only(right: 130.0),
          child: Text(
            widget.title!,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ChewieListItem(
            hAspect: 0,
            wAspect: MediaQuery.of(context).size.width,
            videoPlayerController: VideoPlayerController.network(
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Center(
          child: TimerWidget(
            time: 30,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      ],
    );
  }
}
