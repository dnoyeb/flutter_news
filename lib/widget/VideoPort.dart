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
  bool playEnd = false;
  @override
  void initState() {
    super.initState();
    _controller = widget.source == 'assets'
        ? VideoPlayerController.asset(widget.url)
        : widget.source == 'file'
            ? VideoPlayerController.file(widget.url)
            : VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(() {
        if (_controller.value.duration <= _controller.value.position) {
          setState(() {
            playEnd = true;
          });
        } else if (playEnd = true) {
          playEnd = false;
        }
        print(_controller);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size videoSize;
    final RenderBox box = context.findRenderObject();
    if (_controller.value.initialized) {
      setState(() {
        videoSize = box.size;
      });
    }
    return _controller.value.initialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                VideoPlayer(_controller),
                Container(
                  color: Color.fromARGB(80, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          child: playEnd
                              ? Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                )
                              : _controller.value.isPlaying
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
                              playEnd
                                  ? _controller
                                      .seekTo(_controller.value.duration * 0)
                                  : _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                              playEnd = false;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${_controller.value.position.toString().substring(0, 7)}/${_controller.value.duration.toString().substring(0, 7)}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          height: 50.0,
                          child: DIYVideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            videoSize: videoSize,
                            padding: const EdgeInsets.only(top: 0.0),
                            colors: VideoProgressColors(
                              playedColor: Colors.blue,
                              bufferedColor: Colors.grey[400],
                              backgroundColor: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.crop_free,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}

class DIYVideoProgressIndicator extends StatefulWidget {
  DIYVideoProgressIndicator(
    this.controller, {
    VideoProgressColors colors,
    this.videoSize,
    this.allowScrubbing,
    this.padding = const EdgeInsets.only(top: 5.0),
  }) : colors = colors ?? VideoProgressColors();

  final VideoPlayerController controller;
  final VideoProgressColors colors;
  final bool allowScrubbing;
  final Size videoSize;
  final EdgeInsets padding;
  @override
  _DIYVideoProgressIndicatorState createState() =>
      _DIYVideoProgressIndicatorState();
}

class _DIYVideoProgressIndicatorState extends State<DIYVideoProgressIndicator> {
  VideoPlayerController get controller => widget.controller;

  VideoProgressColors get colors => widget.colors;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {});
  }

  @override
  void deactivate() {
    controller.removeListener(() {});
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget progressIndicator;
    if (controller.value.initialized) {
      final int duration = controller.value.duration.inMilliseconds;
      final int position = controller.value.position.inMilliseconds;

      int maxBuffering = 0;
      for (DurationRange range in controller.value.buffered) {
        final int end = range.end.inMilliseconds;
        if (end > maxBuffering) {
          maxBuffering = end;
        }
      }

      progressIndicator = Container(
        child: Stack(
          fit: StackFit.passthrough,
          alignment: AlignmentDirectional.topStart,
          children: <Widget>[
            Positioned(
                left: 1.0,
                top: 25,
                width: widget.videoSize.width / 2,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    height: 2.0,
                    child: LinearProgressIndicator(
                      value: maxBuffering / duration,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(colors.bufferedColor),
                      backgroundColor: colors.backgroundColor,
                    ),
                  ),
                )),
            Positioned(
              width: widget.videoSize.width / 2,
              left: 0.0,
              top: 10.0,
              child: Container(
                child: Slider(
                  value:
                      (position / duration) < 1.0 ? (position / duration) : 1.0,
                  activeColor: colors.playedColor,
                  inactiveColor: Colors.transparent,
                  onChanged: (double value) {
                    if (!controller.value.initialized) {
                      return;
                    }
                    final Duration position = controller.value.duration * value;
                    controller.seekTo(position);
                  },
                ),
              ),
            )
          ],
        ),
      );
    } else {
      progressIndicator = LinearProgressIndicator(
        value: null,
        valueColor: AlwaysStoppedAnimation<Color>(colors.playedColor),
        backgroundColor: colors.backgroundColor,
      );
    }
    final Widget paddedProgressIndicator = Padding(
      padding: widget.padding,
      child: progressIndicator,
    );
    return paddedProgressIndicator;
  }
}
