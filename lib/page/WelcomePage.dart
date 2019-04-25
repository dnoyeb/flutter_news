import 'package:flutter/material.dart';
// import '../common/model/MainModel.dart';
// import 'package:scoped_model/scoped_model.dart';
import '../common//local/LocalStorage.dart';
import 'package:intro_slider/intro_slider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => new _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
// class _WelcomePageState extends State<WelcomePage>
//     with SingleTickerProviderStateMixin {
  // PageController _pageController = PageController();
  // TabController _tabController;
  // var imgUrlList = [
  //   'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg',
  //   'https://ws1.sinaimg.cn/large/0065oQSqly1fw8wzdua6rj30sg0yc7gp.jpg',
  //   'https://ws1.sinaimg.cn/large/0065oQSqly1fw0vdlg6xcj30j60mzdk7.jpg',
  //   'https://ws1.sinaimg.cn/large/0065oQSqly1fuo54a6p0uj30sg0zdqnf.jpg'
  // ];
  List<Slide> slides = new List();

  void initUser() async {
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

  // @override
  // void initState() {
  //   _tabController = TabController(length: 4, vsync: this);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   _tabController.dispose();
  //   super.dispose();
  // }

  // void _onPageChanged(int index) {
  //   print(index);
  //   _tabController.index = index;
  // }

  // Widget buildPageItem(int index, String imgUrl) {
  //   return Image.network(imgUrl);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Stack(
  //     children: <Widget>[
  //       PageView(
  //         onPageChanged: _onPageChanged,
  //         controller: _pageController,
  //         children: imgUrlList
  //             .map((item) => buildPageItem(imgUrlList.indexOf(item), item))
  //             .toList(),
  //       ),
  //       Align(
  //         alignment: Alignment(0.0, 0.5),
  //         child: TabPageSelector(
  //           color: Colors.white,
  //           selectedColor: Colors.black,
  //           controller: _tabController,
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
