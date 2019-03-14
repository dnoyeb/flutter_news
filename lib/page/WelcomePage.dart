import 'package:flutter/material.dart';
// import '../common/model/MainModel.dart';
// import 'package:scoped_model/scoped_model.dart';
import 'LoginPage.dart';
import 'TabPage.dart';
import '../common//local/LocalStorage.dart';
/*
 * 欢迎页
 * Created by siyongkang
 * Date: 2018-07-16
 */

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;
  initUser() async {
    var userInfo = await LocalStorage.get('userInfo');
    userInfo == null
        ? Navigator.pushReplacementNamed(context, '/login')
        : Navigator.pushReplacementNamed(context, '/tab');
  }

  @override
  void initState() {
    super.initState();
    if (hadInit) {
      return;
    }
    hadInit = true;
    new Future.delayed(const Duration(seconds: 2), () {
      initUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      width:double.infinity,
      height:double.infinity,
      child: new Center(
        child: Image.asset(
          "assets/images/welcome.jpg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
