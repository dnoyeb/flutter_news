import 'package:flutter/material.dart';
import 'package:flutter_news/widget/VideoPort.dart';
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
    // _controller = VideoPlayerController.network(
    //     'http://v1-default.ixigua.com/b6f0066799e36e241c9f1bdc96a86e7f/5cc5280a/video/m/22008883060e638481b86d3453b346a21c71161ea11600009f0fdd415b37/?rc=anZxeTwzcnI2bTMzMzczM0ApQHRAbzU0NTU5MzQzMzg4NDUzNDVvQGgzdSlAZjN1KWRzcmd5a3VyZ3lybHh3Zjo1QGY1NGAtcWVfL18tLV4tMHNzLW8jbyMxNC0vMTAtLi81LTUxNi06I28jOmEtcSM6YHZpXGJmK2BeYmYrXnFsOiMuLl4%3D')
      ..addListener(() {
        setState(() {
          // print(_controller);
        });
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
