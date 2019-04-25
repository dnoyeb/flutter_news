import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:screen/screen.dart';
import 'package:flutter/services.dart';

class VideoPortWidget extends StatefulWidget {
  final url;
  //source :assets   file   net
  final String source;
  final isFullScreen;

  /// Defines the system overlays visible after exiting fullscreen
  final List<SystemUiOverlay> systemOverlaysAfterFullScreen;

  /// Defines the set of allowed device orientations after exiting fullscreen
  final List<DeviceOrientation> deviceOrientationsAfterFullScreen;

  VideoPortWidget({
    Key key,
    @required this.url,
    @required this.source,
    this.isFullScreen = false,
    this.systemOverlaysAfterFullScreen = SystemUiOverlay.values,
    this.deviceOrientationsAfterFullScreen = const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  }) : super(key: key);

  _VideoPortWidgetState createState() => _VideoPortWidgetState();
}

class _VideoPortWidgetState extends State<VideoPortWidget> {
  VideoPlayerController _controller;

  bool playEnd = false;
  double videoWidth;

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
        // print(_controller);
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
    Future<dynamic> _pushFullScreenWidget(BuildContext context) async {
      final isAndroid = Theme.of(context).platform == TargetPlatform.android;
      // final TransitionRoute<Null> route = PageRouteBuilder<Null>(
      //   settings: RouteSettings(isInitialRoute: false),
      //   pageBuilder: _fullScreenRoutePageBuilder,
      // );

      // if (!widget.controller.allowedScreenSleep) {
      //   Screen.keepOn(true);
      // }
      Screen.keepOn(true);
      // await Navigator.push(
      //   context,
      //   new PageRouteBuilder(
      //     transitionDuration: const Duration(milliseconds: 300),
      //     pageBuilder: (context, _, __) => Scaffold(
      //           resizeToAvoidBottomPadding: false,
      //           body: Container(
      //             alignment: Alignment.center,
      //             color: Colors.black,
      //             child: VideoPortWidget(
      //               url: widget.url,
      //               source: widget.source,
      //               isFullScreen: true,
      //             ),
      //           ),
      //         ),
      //     transitionsBuilder:
      //         (_, Animation<double> animation, __, Widget child) =>
      //             new FadeTransition(
      //               opacity: animation,
      //               child: new RotationTransition(
      //                 turns: new Tween<double>(begin: 0.0, end: 1.0)
      //                     .animate(animation),
      //                 child: child,
      //               ),
      //             ),
      //   ),
      // );
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            SystemChrome.setEnabledSystemUIOverlays([]);
            if (isAndroid) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
            }
            return Scaffold(
              resizeToAvoidBottomPadding: false,
              body: Container(
                alignment: Alignment.center,
                color: Colors.black,
                child: VideoPortWidget(
                  url: widget.url,
                  source: widget.source,
                  isFullScreen: true,
                ),
              ),
            );
          },
        ),
      );
      bool isKeptOn = await Screen.isKeptOn;
      if (isKeptOn) {
        Screen.keepOn(false);
      }

      SystemChrome.setEnabledSystemUIOverlays(
          widget.systemOverlaysAfterFullScreen);
      SystemChrome.setPreferredOrientations(
          widget.deviceOrientationsAfterFullScreen);
    }

    final RenderBox box = context.findRenderObject();
    if (_controller.value.initialized) {
      setState(() {
        videoWidth = box.size.width;
      });
    }

    return _controller.value.initialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                // Hero(
                //   tag: widget.url.toString(),
                //   child: VideoPlayer(_controller),
                // ),
                VideoPlayer(_controller),
                Container(
                  color: Color.fromARGB(80, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          width: 40.0,
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
                      Container(
                        width: 80.0,
                        child: Text(
                          '${_controller.value.position.toString().substring(2, 7)}/${_controller.value.duration.toString().substring(2, 7)}',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        height: 50.0,
                        width: 240.0,
                        child: DIYVideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          videoWidth: 240.0,
                          padding: const EdgeInsets.only(top: 0.0),
                          colors: VideoProgressColors(
                            playedColor: Colors.blue,
                            bufferedColor: Colors.grey[400],
                            backgroundColor: Colors.grey[800],
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          width: 40.0,
                          child: Icon(
                            widget.isFullScreen
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          widget.isFullScreen
                              ? Navigator.of(context).pop()
                              : _pushFullScreenWidget(context);
                        },
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
    this.videoWidth,
    this.allowScrubbing,
    this.padding = const EdgeInsets.only(top: 5.0),
  }) : colors = colors ?? VideoProgressColors();

  final VideoPlayerController controller;
  final VideoProgressColors colors;
  final bool allowScrubbing;
  final double videoWidth;
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
                width: widget.videoWidth,
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
              width: widget.videoWidth,
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
