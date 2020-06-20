import 'package:flutter/material.dart';

class BeautyPage extends StatefulWidget {
  BeautyPage({Key key}) : super(key: key);

  _BeautyPageState createState() => _BeautyPageState();
}

class _BeautyPageState extends State<BeautyPage> {
  @override
  void initState() {
    // TODO: implement initState
    // Image.asset('assets/images/avatar.png')
    //     .image
    //     .resolve(createLocalImageConfiguration(context))
    //     .addListener((ImageInfo image, bool synchronousCall) {
    //       print('aaaaa');
    //     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('22'),
    );
  }
}
