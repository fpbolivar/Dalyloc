import 'package:chewie/chewie.dart';
import 'package:daly_doc/utils/exportWidgets.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  VideoPlayerController videoPlayerController;
  bool? looping;
  double wAspect;
  double hAspect;
  ChewieListItem({
    Key? key,
    required this.videoPlayerController,
    required this.wAspect,
    required this.hAspect,
    this.looping,
  });

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  late ChewieController _chewieController;
  double val = 0.5;
  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
    double videoContainerRatio = 0.5;

    double videoRatio = widget.videoPlayerController.value.aspectRatio;
    if (videoRatio < videoContainerRatio) {
      ///for tall videos, we just return the inverse of the controller aspect ratio
      val = videoContainerRatio / videoRatio;
    } else {
      ///for wide videos, divide the video AR by the fixed container AR
      ///so that the video does not over scale

      val = videoRatio / videoContainerRatio;
    }
    _chewieController = ChewieController(
      showControls: true,
      fullScreenByDefault: false,
      videoPlayerController: widget.videoPlayerController,

      // aspectRatio: videoRatio, //widget.wAspect / widget.wAspect,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: false,
      autoPlay: true,

      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
      height: widget.wAspect - 40,
      // width: 350,
      child: _chewieController == null
          ? loaderList()
          : Chewie(
              controller: _chewieController,
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
