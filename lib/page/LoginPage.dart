import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "../common//local//LocalStorage.dart";
import '../common/utils/CommonUtils.dart';
import 'package:common_utils/common_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _userName = "";
  String _password = "";
  bool _userNameValid = true;
  bool _passwordValid = true;
  final TextEditingController userController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  FocusNode _focusUserName = FocusNode();
  FocusNode _focusPassword = FocusNode();
  VideoPlayerController _controller;

  @override
  void initState() {
    initParams();
    _focusUserName.addListener(() {
      if (!_focusUserName.hasFocus) {
        if (_userName == null || _userName == '' || _userName.isEmpty) {
          _userNameValid = false;
        } else {
          setState(() {
            _userNameValid = !RegexUtil.isMobileExact(_userName);
          });
        }
      }
    });
    _focusPassword.addListener(() {
      if (!_focusPassword.hasFocus) {
        if (_password == null || _password == '' || _password.isEmpty) {
          _passwordValid = false;
        } else {
          setState(() {
            _passwordValid = !RegExp('^(\\w){6,20}\$').hasMatch(_password);
          });
        }
      }
    });
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/avengers.mp4');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _userNameChanged(String str) {
    if (str == null || str == '' || str.isEmpty) {
      _userNameValid = false;
    } else {
      setState(() {
        _userNameValid = !RegexUtil.isMobileExact(str);
      });
    }
  }

  void _passwordChanged(String str) {
    if (str == null || str == '' || str.isEmpty) {
      _passwordValid = false;
    } else {
      setState(() {
        _passwordValid = !RegExp('^(\\w){6,20}\$').hasMatch(str);
      });
    }
  }

  initParams() async {
    _userName = await LocalStorage.get('userName');
    _password = await LocalStorage.get('password');
    userController.value = TextEditingValue(text: _userName ?? "");
    pwController.value = TextEditingValue(text: _password ?? "");
  }

  saveUser() async {
    if (userController.text != '' && pwController.text != '') {
      await LocalStorage.save('userName', userController.value.toString());
      await LocalStorage.save('password', pwController.value.toString());
      await LocalStorage.save('hasLogin', 'yes');
      Timer(Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/tab',
          (route) => route == null,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(),
                  child: VideoPlayer(_controller),
                ),
                Opacity(
                    opacity: 0.6,
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      color: Colors.black,
                    )),
                Positioned(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            controller: userController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              labelStyle: TextStyle(
                                color: Colors.blue,
                              ),
                              icon: Icon(
                                Icons.account_circle,
                                color: Colors.blue,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              labelText: '请输入账号',
                              helperText: _userNameValid ? '' : '请输入有效账号',
                              helperStyle: TextStyle(
                                color: Colors.yellow,
                              ),
                              fillColor: Colors.white,
                            ),
                            focusNode: _focusUserName,
                            maxLengthEnforced: false,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11)
                            ],
                            cursorColor: Colors.red,
                            onChanged: _userNameChanged,
                            autofocus: false,
                          ),
                          TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            controller: pwController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              labelStyle: TextStyle(
                                color: Colors.blue,
                              ),
                              icon: Icon(
                                Icons.keyboard,
                                color: Colors.blue,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              labelText: '请输入密码',
                              helperText: _passwordValid ? '' : '请输入有效密码',
                              helperStyle: TextStyle(
                                color: Colors.yellow,
                              ),
                            ),
                            focusNode: _focusPassword,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(21)
                            ],
                            obscureText: true,
                            cursorColor: Colors.red,
                            onChanged: _passwordChanged,
                            autofocus: false,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RaisedButton(
                                  // 文本内容
                                  child: Flex(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Text(
                                        '登陆',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    CommonUtils.showLoadingDialog(
                                        context, '正在登陆');
                                    saveUser();
                                  },
                                  color: Colors.blue,
                                ),
                                RaisedButton(
                                  // 文本内容
                                  child: Flex(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Text(
                                        '注册',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    CommonUtils.showAlertDialog(
                                        context, '~~', '暂未开发');
                                  },
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
