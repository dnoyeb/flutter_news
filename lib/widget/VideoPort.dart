import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:screen/screen.dart';
import 'package:flutter/services.dart';

class VideoPortWidget extends StatefulWidget {
  //source :assets   file   net
  final isFullScreen;
  final controller;

  /// Defines the system overlays visible after exiting fullscreen
  final List<SystemUiOverlay> systemOverlaysAfterFullScreen;

  /// Defines the set of allowed device orientations after exiting fullscreen
  final List<DeviceOrientation> deviceOrientationsAfterFullScreen;

  VideoPortWidget({
    Key key,
    @required this.controller,
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
  bool playEnd = false;
  VideoPlayerController get controller => widget.controller;
  @override
  void initState() {
    super.initState();
    if (!controller.value.initialized) {
      controller
        ..initialize().then((_) {
          setState(() {});
        })
        ..addListener(() {
          if (controller.value.duration <= controller.value.position) {
            setState(() {
              playEnd = true;
            });
          } else if (playEnd = true) {
            playEnd = false;
          }
          // print(_controller);
        });
    }
  }

  double setValue = 0.0;
  bool isDragLeft = true;
  bool isDraging = false;
  bool showMaskTap = false;
  @override
  Widget build(BuildContext context) {
    Future<dynamic> _pushFullScreenWidget(BuildContext context) async {
      final isAndroid = Theme.of(context).platform == TargetPlatform.android;
      // final TransitionRoute<Null> route = PageRouteBuilder<Null>(
      //   settings: RouteSettings(isInitialRoute: false),
      //   pageBuilder: _fullScreenRoutePageBuilder,
      // );

      // if (!controller.allowedScreenSleep) {
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
                  controller: controller,
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

    return controller.value.initialized
        ? AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    VideoPlayer(controller),
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: GestureDetector(
                        child: Container(
                          color: isDraging||showMaskTap
                              ? Color.fromRGBO(0, 0, 0, 0.5)
                              : Color.fromRGBO(0, 0, 0, 0),
                          child: Center(
                            child: isDraging&&!showMaskTap
                                ? Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      color: Color.fromRGBO(0, 0, 0, 0.8),
                                    ),
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          isDragLeft
                                              ? Icons.brightness_6
                                              : Icons.volume_up,
                                          size: 40.0,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        LinearProgressIndicator(
                                          value: setValue,
                                          backgroundColor: Colors.grey,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                        onHorizontalDragUpdate: (DragUpdateDetails details) {
                          print(details);
                        },
                        onVerticalDragStart: (DragStartDetails details) {
                          isDragLeft =
                              details.globalPosition.dx < context.size.width / 2
                                  ? true
                                  : false;
                        },
                        onVerticalDragUpdate:
                            (DragUpdateDetails details) async {
                          if (isDragLeft) {
                            double brightness = await Screen.brightness;

                            if (details.delta.dy > 0) {
                              brightness -= 0.1;
                            } else {
                              brightness += 0.1;
                            }

                            brightness = brightness > 1.0
                                ? 1.0
                                : brightness < 0 ? 0 : brightness;
                            Screen.setBrightness(brightness);
                            setState(() {
                              isDraging = true;
                              setValue = brightness;
                            });
                          } else {
                            //音量控制
                            double volume = controller.value.volume;
                            if (details.delta.dy > 0) {
                              volume -= 0.1;
                            } else {
                              volume += 0.1;
                            }
                            volume =
                                volume > 1.0 ? 1.0 : volume < 0 ? 0 : volume;
                            controller.setVolume(volume);
                            setState(() {
                              isDraging = true;
                              setValue = volume;
                            });
                          }
                        },
                        onVerticalDragEnd: (DragEndDetails) {
                          setState(() {
                            isDraging = false;
                          });
                        },
                        onVerticalDragCancel: () {
                          setState(() {
                            isDraging = false;
                          });
                        },
                        onHorizontalDragEnd: (DragEndDetails) {
                          setState(() {
                            isDraging = false;
                          });
                        },
                        onHorizontalDragCancel: () {
                          setState(() {
                            isDraging = false;
                          });
                        },
                        onTap: () {
                          setState(() {
                            showMaskTap = !showMaskTap;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                showMaskTap?Container(
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
                              : controller.value.isPlaying
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
                                ? controller
                                    .seekTo(controller.value.duration * 0)
                                : controller.value.isPlaying
                                    ? controller.pause()
                                    : controller.play();
                            playEnd = false;
                          });
                        },
                      ),
                      Container(
                        width: 80.0,
                        child: Text(
                          '${controller.value.position.toString().substring(2, 7)}/${controller.value.duration.toString().substring(2, 7)}',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50.0,
                          child: DIYVideoProgressIndicator(
                            controller,
                            allowScrubbing: true,
                            padding: const EdgeInsets.only(top: 0.0),
                            colors: VideoProgressColors(
                              playedColor: Colors.blue,
                              bufferedColor: Colors.grey[400],
                              backgroundColor: Colors.grey[800],
                            ),
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
                ):Container(),
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
    this.allowScrubbing,
    this.padding = const EdgeInsets.only(top: 5.0),
  }) : colors = colors ?? VideoProgressColors();

  final VideoPlayerController controller;
  final VideoProgressColors colors;
  final bool allowScrubbing;
  final EdgeInsets padding;
  @override
  _DIYVideoProgressIndicatorState createState() =>
      _DIYVideoProgressIndicatorState();
}

class _DIYVideoProgressIndicatorState extends State<DIYVideoProgressIndicator> {
  VideoPlayerController get controller => widget.controller;

  VideoProgressColors get colors => widget.colors;
  _DIYVideoProgressIndicatorState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  VoidCallback listener;
  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
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
                right: 0.0,
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
              right: 0.0,
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
