import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syk_flutter/widget/Triangle.dart';

class CommonUtils {
  static showLoadingDialog(BuildContext context, String msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => new Future.value(false),
                child: Center(
                  child: new Container(
                    width: 200.0,
                    height: 200.0,
                    padding: new EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                            child: SpinKitCubeGrid(color: Colors.white)),
                        new Container(height: 10.0),
                        new Container(
                            child: new Text(msg ?? '正在加载',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ))),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  static showAlertDialog(BuildContext context, String title, String text) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  text ?? '',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('关闭'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showChooseDialog(BuildContext context, Size size, var vector3) {
    final double wx = size.height;
    final double dx = vector3[0];
    final double dy = vector3[1];
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return new Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Text(''),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Positioned(
                  left: 10.0,
                  top: dy < h / 2 ? dy + wx / 2 : null,
                  bottom: dy < h / 2 ? null : (h - dy + wx / 2),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Colors.white,
                    ),
                    width: w - 20.0,
                    child: GestureDetector(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                              leading: Icon(Icons.highlight_off),
                              title: Text('不感兴趣'),
                              subtitle: Text('减少这类内容')),
                          Divider(),
                          ListTile(
                              leading: Icon(Icons.error_outline),
                              title: Text('反馈垃圾内容'),
                              subtitle: Text('低俗、标题党等')),
                          Divider(),
                          ListTile(
                              leading: Icon(Icons.not_interested),
                              title: Text('屏蔽'),
                              subtitle: Text('请选择屏蔽的广告类型')),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.help_outline),
                            title: Text('为什么看到此广告'),
                          ),
                        ],
                      ),
                      onTap: () {
                        // final snackBar = SnackBar(
                        //   content: Text('随便写着玩的，别点了...'),
                        //   backgroundColor: Colors.blueAccent,
                        //   duration: Duration(minutes: 1), // 持续时间
                        //   //animation,
                        // );
                        // Scaffold.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: dx - 10.0,
                  top: dy < h / 2 ? dy - wx / 2 : null,
                  bottom: dy < h / 2 ? null : (h - dy - wx / 2),
                  child: ClipPath(
                    clipper: Triangle(dir: dy - h / 2),
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      color: Colors.white,
                      child: null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
