import 'package:flutter/material.dart';
import 'package:intro_slider/slide_object.dart';
import '../common//local/LocalStorage.dart';
import 'package:intro_slider/intro_slider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => new _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  List<Slide> slides = new List();

  void initUser() async {
    await LocalStorage.remove('hasLogin');
    var hasLogin = await LocalStorage.get('hasLogin');
    hasLogin == null
        ? Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
             (route) => route == null,
          )
        : Navigator.pushNamedAndRemoveUntil(
            context,
            '/tab',
             (route) => route == null,
          );
  }


  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "PAST",
        description: "say bye",
        backgroundColor: Colors.red,
      ),
    );
    slides.add(
      new Slide(
        title: "NOW",
        description: "say yes",
        backgroundColor: Colors.blue,
      ),
    );
    slides.add(
      new Slide(
        title: "FUTURE",
        description: "say hi",
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      onDonePress: this.initUser,
    );
  }
}
