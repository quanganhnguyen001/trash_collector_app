import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key, required this.videoId});
  final String videoId;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: const YoutubePlayerFlags(
            autoPlay: false, isLive: false, mute: true));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      builder: (context, player) {
        return const Scaffold();
      },
      player: YoutubePlayer(
        controller: controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.white,
        progressColors: const ProgressBarColors(
            playedColor: Colors.white, handleColor: Colors.red),
      ),
    );
  }
}
