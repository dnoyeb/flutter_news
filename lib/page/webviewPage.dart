import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key key, @required this.url}) : super(key: key);
  final String url;
  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(widget.url),
        backgroundColor: Colors.blue,
      ),
      body: new WebviewScaffold(
        url: "https://www.baidu.com",
      ),
    );
  }
}
