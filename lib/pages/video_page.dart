import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../models/level.dart';

/// This page handles displaying the youtube video for each level.
/// Most of the code here is from the example for youtube_player_iframe on pubdev
class VideoPage extends StatefulWidget {
  final Level level;

  const VideoPage({Key? key, required this.level}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.level.video.isNotEmpty) {
      _controller = YoutubePlayerController(
          initialVideoId: widget.level.video,
          params: const YoutubePlayerParams(
            showControls: true,
            showFullscreenButton: true,
          ));
      _controller!.onEnterFullscreen = () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      };
      _controller!.onExitFullscreen = () {
      };
    }
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();

    return Center(
      child: widget.level.video.isEmpty
          ? const Center(child: Text("No video for this course!"))
          : YoutubePlayerControllerProvider(
              controller: _controller!,
              child: Stack(
                children: [
                  player,
                  Positioned.fill(
                    child: YoutubeValueBuilder(
                      controller: _controller,
                      builder: (context, value) {
                        if (value.hasError) {
                          return Text(value.error.name);
                        }
                        return AnimatedCrossFade(
                          firstChild: const SizedBox.shrink(),
                          secondChild: Material(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    YoutubePlayerController.getThumbnail(
                                      videoId: _controller!.initialVideoId,
                                      quality: ThumbnailQuality.medium,
                                    ),
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: Colors.white),
                              ),
                            ),
                          ),
                          crossFadeState: value.isReady
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
