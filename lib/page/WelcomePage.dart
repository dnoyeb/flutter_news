import 'package:flutter/material.dart';
/*
 * 欢迎页
 * Created by siyongkang
 * Date: 2018-07-16
 */

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: const Color(0xFF00FF00),
      child: Text('Hello',
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.white)),
    );
  }
}
