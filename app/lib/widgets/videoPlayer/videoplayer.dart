import 'package:chewie/chewie.dart';
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

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      showControls: true,
      fullScreenByDefault: false,
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: widget.wAspect / widget.wAspect,
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
      child: Chewie(
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
