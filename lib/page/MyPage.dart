import 'package:flutter/material.dart';
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

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
              clipper: BottomClipper(),
              child: Container(
                color: Colors.deepPurpleAccent,
                height: 200.0,
              )),
        ],
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width / 4 * 3, size.height - 80);
    var secondEndPoint = Offset(size.width, size.height - 40);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

