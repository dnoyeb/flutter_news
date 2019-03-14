import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "../common//local//LocalStorage.dart";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _userName = "";
  String _password = "";
  bool _userNameValid = true;
  bool _passwordValid = true;
  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();
  FocusNode _focusUserName = new FocusNode();
  FocusNode _focusPassword = new FocusNode();

  @override
  void initState() {
    initParams();
    _focusUserName.addListener(() {
      if (!_focusUserName.hasFocus) {
        setState(() {
          _userNameValid = RegExp(r'^1\d{10}').hasMatch(_userName);
        });
      }
    });
    _focusPassword.addListener(() {
      if (!_focusPassword.hasFocus) {
        setState(() {
          _passwordValid = RegExp(r'^[a-zA-Z\d_]{8,}$').hasMatch(_password);
        });
      }
    });
    super.initState();
  }

  void _userNameChanged(String str) {
    _userName = str;
    if (RegExp(r'^1\d{10}').hasMatch(str)) {
      setState(() {
        _userNameValid = true;
      });
    }
  }

  _passwordChanged(String str) {
    _password = str;
    if (RegExp(r'^[a-zA-Z\d_]{8,20}$').hasMatch(str)) {
      setState(() {
        _passwordValid = true;
      });
    }
  }

  initParams() async {
    _userName = await LocalStorage.get('userName');
    _password = await LocalStorage.get('password');
    userController.value = new TextEditingValue(text: _userName ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        padding: const EdgeInsets.all(30.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.account_circle),
                  labelText: '请输入账号',
                  helperText: _userNameValid ? '' : '请输入有效账号',
                ),
                focusNode: _focusUserName,
                maxLengthEnforced: false,
                inputFormatters: [LengthLimitingTextInputFormatter(11)],
                cursorColor: Colors.red,
                onChanged: _userNameChanged,
                autofocus: false,
              ),
              new TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.keyboard),
                  labelText: '请输入密码',
                  helperText: _passwordValid ? '' : '请输入有效密码',
                ),
                focusNode: _focusPassword,
                inputFormatters: [LengthLimitingTextInputFormatter(21)],
                obscureText: true,
                cursorColor: Colors.red,
                onChanged: _passwordChanged,
                autofocus: false,
              ),
              new Container(
                margin: EdgeInsets.only(top: 40),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new RaisedButton(
                      // 文本内容
                      child: new Flex(
                        mainAxisAlignment: MainAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: <Widget>[
                          new Text(
                            '登陆',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        
                      },
                      color: Colors.blue,
                    ),
                    new RaisedButton(
                      // 文本内容
                      child: new Flex(
                        mainAxisAlignment: MainAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: <Widget>[
                          new Text(
                            '注册',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {},
                      color: Colors.blue,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
