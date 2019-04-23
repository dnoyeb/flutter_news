import 'package:flutter/material.dart';
import 'package:syk_flutter/widget/VideoPort.dart';

class InfoPage extends StatefulWidget {
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: VideoPortWidget(
          url: 'assets/videos/video.mp4',
          source: 'assets',
        ),
      ),
    );
  }
}
