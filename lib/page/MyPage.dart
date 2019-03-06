import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import '../common//net/http.dart';
import 'dart:convert';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  String test = '132';
  @override
  void initState() {
    dio
        .get(
            'https://result.eolinker.com/VI1Wbcdb5a5f53e8621a1e4c252df9124da6a9030246781?uri=mall')
        .then((res) {
      print(json.decode(res.data)['limit']);
      setState(() {
        test = json.decode(res.data)['limit'].toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(test),
    );
  }
}
