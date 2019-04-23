import 'package:flutter/material.dart';

class Triangle extends CustomClipper<Path> {
  double dir;
  Triangle({this.dir});
  @override
  Path getClip(Size size) {
    var path = Path();
    double w = size.width;
    double h = size.height;
    if (dir < 0) {
      path.moveTo(0, h);
      path.quadraticBezierTo(0, 0, w * 2 / 3, 0);
      path.quadraticBezierTo(w / 4, h / 2, w, h);
    } else {
      path.quadraticBezierTo(0, h / 2, w * 2 / 3, h);
      path.quadraticBezierTo(w / 3, h / 3, w, 0);
      path.lineTo(0, 0);
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
