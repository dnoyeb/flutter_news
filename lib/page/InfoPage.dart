import 'package:flutter/material.dart';
import 'package:syk_flutter/widget/VideoPort.dart';
import 'package:video_player/video_player.dart';

class InfoPage extends StatefulWidget {

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with AutomaticKeepAliveClientMixin {
  VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/videos/video.mp4')
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: VideoPortWidget(
          controller: _controller,
          isFullScreen: false,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
