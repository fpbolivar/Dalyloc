import 'dart:async';

import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/excercisePlan/model/exerciseDataModel.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class AnimationPlayerDataManager {
  bool inAnimation = false;
  final FlickManager flickManager;
  final List<ExerciseDataModel> items;
  int currentIndex = 0;
  late Timer videoChangeTimer;

  AnimationPlayerDataManager(this.flickManager, this.items);

  playNextVideo() {
    var index = currentIndex;
    index++;
    if (index >= items.length) {
      return;
    }
    playVideo(index);
  }

  playVideo(index) {
    Constant.videoProvider.duration = 0;
    Constant.videoProvider.totalDuration = 0;
    Constant.videoProvider.textDurationCounter = 0;
    currentIndex = index;
    print("Video playing from ${items[index].exercise_video}");
    flickManager.handleChangeVideo(
        VideoPlayerController.network(items[index].exercise_video!),
        timerCancelCallback: (bool playNext) {});
  }

  playPrevVideo([Duration? duration]) {
    if (currentIndex > 0) {
      currentIndex--;
    }

    String nextVideoUrl = items[currentIndex - 1].exercise_video!;

    if (currentIndex > 0) {
      if (duration != null) {
        videoChangeTimer = Timer(duration, () {
          currentIndex--;
        });
      } else {
        currentIndex--;
      }

      flickManager.handleChangeVideo(
          VideoPlayerController.network(nextVideoUrl),
          videoChangeDuration: duration, timerCancelCallback: (bool playNext) {
        videoChangeTimer.cancel();
      });
    }
  }

  String getCurrentVideoTitle() {
    if (currentIndex != -1) {
      return items[currentIndex].exercise_name!;
    } else {
      return items[items.length - 1].exercise_name!;
    }
  }

  String getNextVideoTitle() {
    if (currentIndex != items.length - 1) {
      return items[currentIndex + 1].exercise_name!;
    } else {
      return items[0].exercise_name!;
    }
  }

  String getCurrentPoster() {
    if (currentIndex != -1) {
      return items[currentIndex].exercise_image!;
    } else {
      return items[items.length - 1].exercise_name!;
    }
  }
}
