import 'package:chewie/chewie.dart';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/excercisePlan/manager/provider/videoProvider.dart';
import 'package:daly_doc/pages/excercisePlan/model/exerciseDataModel.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:daly_doc/widgets/extension/string+capitalize.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/colors/colors.dart';
import '../../utils/exportPackages.dart';
import '../../widgets/appBar/CustomAppBar.dart';
import '../../widgets/backgroundCurveView/backgroundCurveView.dart';
import '../../widgets/videoPlayer/videoplayer.dart';
import 'Comonent/timer.dart';

class WorkoutVideoScreen extends StatefulWidget {
  String? title = '';
  ExerciseDataModel? data;
  List<ExerciseDataModel>? dataList;
  WorkoutVideoScreen({super.key, this.title, this.data, this.dataList});

  @override
  State<WorkoutVideoScreen> createState() => _WorkoutVideoScreenState();
}

class _WorkoutVideoScreenState extends State<WorkoutVideoScreen> {
  String? sources;
  ExerciseDataModel? data;

  List<ExerciseDataModel>? dataList = [];
  late TargetPlatform platform;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  late int selectedIndex;
  bool isInitialized = false;
  bool isPlaying = false, isEndPlaying = false;
  List<Color> listItemColor = [];
  Future<void>? _initializeVideoPlayerFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
    dataList = widget.dataList;
    print("${widget.dataList!.length}");
    widget.dataList!.forEach((element) {
      print(element.exercise_video);
    });
    Constant.videoProvider.duration = 0;
    Constant.videoProvider.totalDuration = 0;
    Constant.videoProvider.textDurationCounter = 0;
    videoPlayerController =
        VideoPlayerController.network(dataList![0].exercise_video ?? "");
    selectedIndex = 0;
    //videoPlayerController.removeListener(() {});
    videoPlayerController.addListener(_videoListener);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,

      aspectRatio: 16 / 16,
      autoPlay: true,

      looping: false,

      // Try playing around with some of these other options:
      // showControls: true,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      placeholder: Container(
        color: Colors.grey,
      ),
      // autoInitialize: true,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Constant.videoProvider.initializeZero();

      videoPlayerController.initialize().then((value) {
        isInitialized = true;

        chewieController.play();
        setState(() {});
      });
    });
  }

  void _videoListener() {
    if (Constant.videoProvider.duration == 0) {
      calcutaionTotalDuration(isPosition: false);
    } else {
      calcutaionTotalDuration(isPosition: true);
    }
    print(
        "videoPlayerController.value.position${videoPlayerController.value.position}");
    if (videoPlayerController.value.position ==
        videoPlayerController.value.duration) {
      print('video ended');
      Constant.videoProvider.initializeZero();
      if (videoPlayerController.value.position.inSeconds != 0.0) {
        isEndPlaying = true;
        isPlaying = false;
      }
      // videoPlayerController.pause();

      // setState(() {
      //   listItemColor[selectedIndex] = Colors.grey;
      // });
    } else {
      if (!isEndPlaying) {
        //  print(
        //"textDurationCounter ${Constant.videoProvider.textDurationCounter}");
        calcutaionTotalDuration(isPosition: true);
      } else {
        // Constant.videoProvider.initializeZero();
        calcutaionTotalDuration(isPosition: true);
        //isPosition
      }
    }
  }

  calcutaionTotalDuration({
    isPosition = false,
  }) {
    // print(videoPlayerController.value.duration);
    var data = [];
    if (isPosition) {
      data = videoPlayerController.value.position.toString().split(":");
    } else {
      data = videoPlayerController.value.duration.toString().split(":");
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
    videoPlayerController.removeListener(() {});
    _initializeVideoPlayerFuture = null;
    videoPlayerController.dispose();
    chewieController.dispose();

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
        title: data!.exercise_name.toString().capitalize(),
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
                onTap: () {
                  _onPrevious();
                },
              ),
              CustomButton.regular(
                height: 40,
                width: 140,
                title: "Next",
                background: AppColor.weightScrollColor,
                onTap: () {
                  _onNext();
                },
              ),
              SizedBox(
                width: 1,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              _playView(),
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
              //   SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _playView() {
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 1.0),
              blurRadius: 0.0,
            ),
          ],
        ),
        height: MediaQuery.of(context).size.width - 40,
        width: MediaQuery.of(context).size.width - 40,
        child: !isInitialized
            ? loaderList()
            : Chewie(controller: chewieController));
  }

  void _onNext() async {
    var index = selectedIndex;
    index++;
    if (index >= dataList!.length) {
      return;
    }
    playVideo(index);
  }

  void _onPrevious() async {
    var index = selectedIndex;
    index--;
    if (index < 0) {
      return;
    }
    playVideo(index);
  }

  playVideo(index) {
    isPlaying = true;
    isEndPlaying = false;
    Constant.videoProvider.duration = 0;
    Constant.videoProvider.totalDuration = 0;
    Constant.videoProvider.textDurationCounter = 0;
    selectedIndex = index;
    print("Video playing from ${dataList![selectedIndex].exercise_video}");

    videoPlayerController = VideoPlayerController.network(
        dataList![selectedIndex].exercise_video ?? "");

    setState(() {
      chewieController.dispose();
      videoPlayerController.pause();
      videoPlayerController.seekTo(Duration(seconds: 0));
      videoPlayerController.removeListener(() {});
      videoPlayerController.addListener(_videoListener);
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 16 / 16,
        autoPlay: true,
        looping: false,
      );
    });
  }
}

class DefaultPlayer extends StatefulWidget {
  List<ExerciseDataModel>? dataList;
  DefaultPlayer({Key? key, this.dataList}) : super(key: key);

  @override
  _DefaultPlayerState createState() => _DefaultPlayerState();
}

class _DefaultPlayerState extends State<DefaultPlayer> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        widget.dataList!.first.exercise_video!,
      ),
    );
  }

  ///If you have subtitle assets
  Future<ClosedCaptionFile> _loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context)
        .loadString('images/bumble_bee_captions.srt');
    flickManager.flickControlManager!.toggleSubtitle();
    return SubRipCaptionFile(fileContents);
  }

  ///If you have subtitle urls
  // Future<ClosedCaptionFile> _loadCaptions() async {
  //   final url = Uri.parse('SUBTITLE URL LINK');
  //   try {
  //     final data = await http.get(url);
  //     final srtContent = data.body.toString();
  //     print(srtContent);
  //     return SubRipCaptionFile(srtContent);
  //   } catch (e) {
  //     print('Failed to get subtitles for ${e}');
  //     return SubRipCaptionFile('');
  //   }
  //}

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();
        }
      },
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: FlickVideoPlayer(
                flickManager: flickManager,
                flickVideoWithControls: FlickVideoWithControls(
                  closedCaptionTextStyle: TextStyle(fontSize: 8),
                  controls: FlickPortraitControls(),
                ),
                // flickVideoWithControlsFullscreen: FlickVideoWithControls(
                //   controls: FlickLandscapeControls(),
                // ),
              ),
            ),
            ElevatedButton(
              child: Text('Next video'),
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
