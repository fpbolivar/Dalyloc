import 'package:daly_doc/core/colors/colors.dart';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/excercisePlan/manager/provider/videoProvider.dart';
import 'package:daly_doc/pages/excercisePlan/model/exerciseDataModel.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/customRoundButton/customButton.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../animation_player/portrait_video_controls.dart';
import '../utils/mock_data.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

import './data_manager.dart';
import 'landscape_controls.dart';

class AnimationPlayer extends StatefulWidget {
  AnimationPlayer({Key? key, this.data, this.dataList}) : super(key: key);
  ExerciseDataModel? data;
  List<ExerciseDataModel>? dataList;
  @override
  _AnimationPlayerState createState() => _AnimationPlayerState();
}

class _AnimationPlayerState extends State<AnimationPlayer> {
  late FlickManager flickManager;
  late AnimationPlayerDataManager dataManager;
  List items = mockData['items'];
  bool _pauseOnTap = true;
  double playBackSpeed = 1.0;
  @override
  void initState() {
    super.initState();
    // String url = items[0]['trailer_url'];
    Constant.videoProvider.duration = 0;
    Constant.videoProvider.totalDuration = 0;
    Constant.videoProvider.textDurationCounter = 0;
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.network(widget.dataList![0].exercise_video!),
      // onVideoEnd: () => dataManager.playNextVideo(
      //   Duration(seconds: 5),
      // ),
    );
    flickManager.flickVideoManager!.videoPlayerController!
        .addListener(_videoListener);
    dataManager = AnimationPlayerDataManager(flickManager, widget.dataList!);
  }

  void _videoListener() {
    print(
        "videoPlayerController.value.position${flickManager.flickVideoManager!.videoPlayerController!.value.position}");
    if (Constant.videoProvider.duration == 0) {
      calcutaionTotalDuration(isPosition: false);
    } else {
      calcutaionTotalDuration(isPosition: true);
    }
  }

  calcutaionTotalDuration({
    isPosition = false,
  }) {
    // print(videoPlayerController.value.duration);
    var data = [];
    var vidz = flickManager.flickVideoManager!.videoPlayerController!;
    if (isPosition) {
      data = vidz.value.position.toString().split(":");
    } else {
      data = vidz.value.duration.toString().split(":");
    }
    var d1 = Duration();
    Constant.videoProvider.duration = 0;
    // setState(() {});

    if (data.length > 2) {
      double hr = double.tryParse(data[0].toString()) ?? 0;
      double min = double.tryParse(data[1].toString()) ?? 0;
      double seconds = double.tryParse(data[2].toString()) ?? 0;
      print("HH${data[0].toString()}");
      print("MM${data[1].toString()}");
      print("SS${data[2].toString()}");

      print("SSINT  ${seconds.toInt()}");
      print(seconds);
      d1 = Duration(
          hours: hr.toInt(), minutes: min.toInt(), seconds: seconds.toInt());

      Constant.videoProvider.duration = d1.inSeconds;

      if (!isPosition) {
        Constant.videoProvider.totalDuration = Constant.videoProvider.duration;
      } else {
        Constant.videoProvider.calculaterPercent();
      }
      //setState(() {});
      return;
    }
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.newBgcolor,
        appBar: CustomAppBar(
            onTap: () {
              Navigator.pop(context);
            },
            title: "TEST" //data!.exercise_name.toString().capitalize(),
            ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: AppColor.newBgcolor,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, -10),
                    blurRadius: 1.0,
                    spreadRadius: -10),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 1,
                ),
                dataManager.currentIndex > 0
                    ? CustomButton.regular(
                        height: 40,
                        width: 140,
                        title: "Previous",
                        background: Colors.grey,
                        titleColor: Colors.black,
                        onTap: () {
                          dataManager.playPrevVideo();
                        },
                      )
                    : Container(),
                (dataManager.currentIndex > 0 &&
                        dataManager.currentIndex < dataManager.items.length)
                    ? SizedBox(
                        width: 10,
                      )
                    : Container(),
                dataManager.currentIndex < dataManager.items.length - 1
                    ? CustomButton.regular(
                        height: 40,
                        width: 140,
                        title: "Next",
                        background: AppColor.weightScrollColor,
                        onTap: () {
                          dataManager.playNextVideo();
                        },
                      )
                    : Container(),
                SizedBox(
                  width: 1,
                ),
              ],
            ),
          ),
        ),
        body: VisibilityDetector(
          key: ObjectKey(flickManager),
          onVisibilityChanged: (visibility) {
            if (visibility.visibleFraction == 0 && this.mounted) {
              flickManager.flickControlManager!.autoPause();
            } else if (visibility.visibleFraction == 1) {
              flickManager.flickControlManager!.autoResume();
            }
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FlickVideoPlayer(
                    flickManager: flickManager,
                    flickVideoWithControls:
                        AnimationPlayerPortraitVideoControls(
                            dataManager: dataManager, pauseOnTap: _pauseOnTap),
                    flickVideoWithControlsFullscreen: FlickVideoWithControls(
                      controls: AnimationPlayerLandscapeControls(
                        animationPlayerDataManager: dataManager,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Consumer<VideoProvider>(builder: (context, object, child) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.timerbg,
                          borderRadius: BorderRadius.circular(75)),
                      child: CircularPercentIndicator(
                        radius: 75.0,
                        lineWidth: 6.0,
                        //  animation: true,
                        //   animationDuration: 500,
                        backgroundColor: AppColor.weightScrollColor,
                        percent: Constant.videoProvider.percentage,
                        //animateFromLastPercent: true,
                        center: Text(
                          Constant.videoProvider.textDurationCounter.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.grey[500],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ));
  }
}
