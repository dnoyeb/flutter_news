import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
// import '../widget/photoScale.dart';
import '../common//net/http.dart';
import 'dart:convert';

// class MyPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => MyPageState();
// }

// class MyPageState extends State<MyPage> {
//   String test = '132';
//   @override
//   void initState() {
//     dio
//         .get(
//             'https://result.eolinker.com/VI1Wbcdb5a5f53e8621a1e4c252df9124da6a9030246781?uri=mall')
//         .then((res) {
//       print(json.decode(res.data)['limit']);
//       setState(() {
//         test = json.decode(res.data)['limit'].toString();
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(test),
//     );
//   }
// }
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  Animation<double> tween;
  AnimationController controller;
  /*初始化状态*/
  @override
  initState() {
    /*创建动画控制类对象*/
    controller = new AnimationController(
        duration: const Duration(seconds: 5), vsync: this);

    /*创建补间对象*/
    tween = new Tween(begin: 0.0, end: 1.0).animate(controller) //返回Animation对象
      ..addListener(() {
        //添加监听
        setState(() {
          print(tween.value); //打印补间插值
        });
      });
    // controller.repeat(); //执行动画
    super.initState();
  }

  @override
  dispose() {
    //销毁控制器对象
    controller.dispose();
    super.dispose();
  }

  startAnimtaion() {
    setState(() {
      controller.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          border: new Border.all(color: Colors.red, width: 0.5),
        ),
        child: Transform(
          transform: Matrix4.translationValues(50.0, 0.0, 0.0),
          child: ClipPath(
            clipper: BottomClipper(),
            child: SizedOverflowBox(
              size: Size(width * 2, 200.0),
              child: Container(
                color: Colors.deepPurpleAccent,
                height: 200.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double w = size.width;
    double h = size.height;
    path.moveTo(-w, 0);
    path.lineTo(-w, h - 80);

    for (int i = -2; i < 2; i++) {
      var cp = Offset(i * w / 2 + w / 4, h + 40 * (i % 2 == 0 ? -1 : 1) - 40);
      var ep = Offset((i + 1) * w / 2, h - 40);
      path.quadraticBezierTo(cp.dx, cp.dy, ep.dx, ep.dy);
    }

    path.lineTo(w, h - 80);
    path.lineTo(w, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
