import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPortWidget extends StatefulWidget {
  final url;
  //source :assets   file   net
  final String source;

  VideoPortWidget({Key key, @required this.url, @required this.source})
      : super(key: key);

  _VideoPortWidgetState createState() => _VideoPortWidgetState();
}

class _VideoPortWidgetState extends State<VideoPortWidget> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.source == 'assets') {
      _controller = VideoPlayerController.asset(widget.url)
        ..initialize().then((_) {
          setState(() {});
        })
        ..addListener(() {
          print(_controller);
        });
    } else if (widget.source == 'file') {
      _controller = VideoPlayerController.file(widget.url)
        ..initialize().then((_) {
          setState(() {});
        })
        ..addListener(() {
          print(_controller);
        });
    } else {
      _controller = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          setState(() {});
        })
        ..addListener(() {
          print(_controller);
        });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    return _controller.value.initialized
        ? Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                height: 50.0,
                width: w,
                child: Container(
                  color: Color.fromARGB(80, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        child: _controller.value.isPlaying
                            ? Icon(
                                Icons.pause,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                        onTap: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                      ),
                      Text(
                        '20:25/54:16',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 50.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              //总进度条
                              margin: EdgeInsets.only(top: 24.0),
                              color: Colors.grey[800],
                              width: w * 3 / 5,
                              height: 2.0,
                              alignment: Alignment.topLeft,
                              child: UnconstrainedBox(
                                //缓冲进度条
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                  ),
                                  width: 100.0,
                                  height: 2.0,
                                  alignment: Alignment.topLeft,
                                  child: UnconstrainedBox(
                                    //播放进度条
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                      ),
                                      width: 50.0,
                                      height: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              child: Icon(
                                Icons.fiber_manual_record,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.crop_free,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        : Container();

    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       setState(() {
    //         _controller.value.isPlaying
    //             ? _controller.pause()
    //             : _controller.play();
    //       });
    //     },
    //     child: Icon(
    //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //     ),
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    // );
  }
}
