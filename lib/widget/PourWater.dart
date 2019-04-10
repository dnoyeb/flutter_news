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

class _PourWaterPageState extends State<PourWaterPage> {
  @override
  void initState() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      // Do something with the event.
      // print(event);
      // [GyroscopeEvent (x: -0.0564117431640625, y: -0.1850433349609375, z: 0.072967529296875)]
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
                paddingTop: 50.0,
                paddingBottom: 50.0,
                markCount: 12,
                lineWeight: 2.0,
                lineColor: Theme.of(context).primaryColor,
                bgColor: Colors.white,
              ),
            ),
            SlideWave(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SliderMarks(
                  paddingTop: 50.0,
                  paddingBottom: 50.0,
                  markCount: 12,
                  lineWeight: 2.0,
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
  SlideWave({this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SliderClipper(),
      child: child,
    );
  }
}

class SliderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;
    path.moveTo(0, h / 2);
    for (int i = 0; i < 2; i++) {
      var cp = Offset(i * w / 2 + w / 4, h/2 + 40 * (i % 2 == 0 ? -1 : 1) - 40);
      var ep = Offset((i + 1) * w / 2, h/2 - 40);
      path.quadraticBezierTo(cp.dx, cp.dy, ep.dx, ep.dy);
    }
    path.lineTo(w, h / 2);
    path.lineTo(w, h);
    path.lineTo(0, h);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
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
          -300.0,
          0.0,
          size.width*2,
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
