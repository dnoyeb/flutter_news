import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';

import 'package:sensors/sensors.dart';

class PourWaterPage extends StatefulWidget {
  @override
  _PourWaterPageState createState() => new _PourWaterPageState();
}

class _PourWaterPageState extends State<PourWaterPage>
    with TickerProviderStateMixin {
  Animation<double> tween;
  Animation<double> tweenLight;
  AnimationController controller;
  AnimationController controllerLight;
  final double paddingTop = 50.0;
  final double paddingBottom = 50.0;
  final int markCount = 12;
  final double lineWeight = 2.0;
  final double amplitude = 50.0;
  @override
  void initState() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      // Do something with the event.
      // print(event);
      // [GyroscopeEvent (x: -0.0564117431640625, y: -0.1850433349609375, z: 0.072967529296875)]
    });
    //     /*创建动画控制类对象*/
    controller = new AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    controllerLight = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);

    /*创建补间对象*/
    tween = new Tween(begin: 0.0, end: 1.0).animate(controller) //返回Animation对象
      ..addListener(() {
        //添加监听
        setState(() {});
      });
    controller.repeat(); //重复动画

    tweenLight =
        new Tween(begin: 0.0, end: 1.0).animate(controllerLight) //返回Animation对象
          ..addListener(() {
            //添加监听
            setState(() {});
          });
    controllerLight.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    controllerLight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: SliderMarks(
                paddingTop: paddingTop,
                paddingBottom: paddingBottom,
                markCount: markCount,
                lineWeight: lineWeight,
                lineColor: Theme.of(context).primaryColor,
                bgColor: Colors.white,
              ),
            ),
            SlideWave(
              offsetX: tweenLight.value,
              amplitude: amplitude,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SliderMarks(
                  paddingTop: paddingTop,
                  paddingBottom: paddingBottom,
                  markCount: markCount,
                  lineWeight: lineWeight,
                  lineColor: Colors.white,
                  bgColor: Theme.of(context).primaryColorLight,
                ),
              ),
            ),
            SlideWave(
              offsetX: tween.value,
              amplitude: amplitude,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SliderMarks(
                  paddingTop: paddingTop,
                  paddingBottom: paddingBottom,
                  markCount: markCount,
                  lineWeight: lineWeight,
                  lineColor: Colors.white,
                  bgColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideWave extends StatelessWidget {
  Widget child;
  double offsetX;
  double amplitude;
  SlideWave({this.child, this.offsetX, this.amplitude});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SliderClipper(offsetX: offsetX, amplitude: amplitude),
      child: child,
    );
  }
}

class SliderClipper extends CustomClipper<Path> {
  double offsetX;
  double amplitude; //幅度
  SliderClipper({this.offsetX, this.amplitude});
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;
    double dm = w / 3;
    double ow = offsetX * dm * 2;

    path.moveTo(-2 * dm + ow, h / 2);
    for (int i = -2; i < 3; i++) {
      var cp = Offset(
          i * dm + dm / 2 + ow, h / 2 + amplitude * (i % 2 == 0 ? -1 : 1));
      var ep = Offset((i + 1) * dm + ow, h / 2);
      path.quadraticBezierTo(cp.dx, cp.dy, ep.dx, ep.dy);
    }
    path.lineTo(w + ow, h / 2);
    path.lineTo(w + ow, h);
    path.lineTo(-2 * dm + ow, h);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class SliderMarks extends StatelessWidget {
  final double paddingTop;
  final double paddingBottom;
  final int markCount;
  final double lineWeight;
  final Color lineColor;
  final Color bgColor;

  SliderMarks({
    this.paddingTop,
    this.paddingBottom,
    this.markCount,
    this.lineWeight,
    this.lineColor,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SliderMarksPainter(
        paddingTop: paddingTop,
        paddingBottom: paddingBottom,
        markCount: markCount,
        lineWeight: lineWeight,
        lineColor: lineColor,
        bgColor: bgColor,
      ),
      child: null,
    );
  }
}

class SliderMarksPainter extends CustomPainter {
  final double paddingTop;
  final double paddingBottom;
  final int markCount;
  final double lineWeight;
  final Color lineColor;
  final Color bgColor;
  final Paint markPaint;
  final Paint bgPaint;

  SliderMarksPainter({
    this.paddingTop,
    this.paddingBottom,
    this.markCount,
    this.lineWeight,
    this.lineColor,
    this.bgColor,
  })  : markPaint = new Paint()
          ..color = lineColor
          ..strokeWidth = lineWeight
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
        bgPaint = new Paint()
          ..color = bgColor
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(
          0.0,
          0.0,
          size.width,
          size.height,
        ),
        bgPaint);
    double itemHeight =
        (size.height - paddingBottom - paddingTop) / (markCount - 1);
    //刻度线
    for (int i = 0; i < markCount; i++) {
      canvas.drawLine(
          Offset(size.width - 60.0 + (i.isEven ? 5.0 : -5.0),
              paddingTop + i * itemHeight),
          Offset(size.width - 30.0, paddingTop + i * itemHeight),
          markPaint);
    }
  }

  @override
  bool shouldRepaint(SliderMarksPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SliderMarksPainter oldDelegate) => false;
}
