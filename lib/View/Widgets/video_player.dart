import 'package:flutter/material.dart';
import 'package:flutter_yt/Controllers/video_controller.dart';
import 'package:flutter_yt/Utils/initial_video_url.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController controller;

  final VideoControllers _videoController = VideoControllers();

  bool isFetchingRecommendedVideos = false;

  var _videoId = '';

  @override
  void initState() {
    super.initState();
    initController(initialVideoUrl);
  }

  initController(String url) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId != null) {
      _videoId = videoId;

      controller = YoutubePlayerController(
          initialVideoId: _videoId,
          flags: const YoutubePlayerFlags(
            mute: false,
          ))
        ..addListener(_videoListener);
    } else {
      throw ('id is null');
    }
  }

  void _videoListener() {
    if (controller.value.playerState == PlayerState.ended && !isFetchingRecommendedVideos) {
      controller.pause();

      isFetchingRecommendedVideos = true;

      _videoController.fetchRecommendedVideos(_videoId).then((newId) {
        if (newId.isNotEmpty) {
          _videoId = newId;

          controller.load(_videoId);
          controller.play();
        }
        isFetchingRecommendedVideos = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
        ),
        builder: (context, player) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Video Player Screen'),
                centerTitle: true,
              ),
              body: ListView(
                children: [
                  player,
                ],
              ));
        });
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
