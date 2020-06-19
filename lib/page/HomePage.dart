import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_news/common/net/http.dart';
import 'package:flutter_news/widget/HomeItem.dart';
import '../common/model/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import './WebviewPage.dart';

// import '../page/MyDrawer.dart';
// import '../common/config/Config.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;
  List dataList = [
    'assets/images/Avengers1.png',
    'assets/images/Avengers2.png',
    'assets/images/Avengers3.png',
    'assets/images/Avengers4.png',
    'assets/images/Avengers5.png',
    'assets/images/Avengers6.png',
    'assets/images/Avengers7.png',
    'assets/images/Avengers8.png',
    'assets/images/Avengers9.png',
    'assets/images/Avengers10.png',
    'assets/images/Avengers11.png',
    'assets/images/Avengers12.png',
    'assets/images/Avengers13.png',
  ];
  var imgUrlList = [
    'assets/images/Avengers1.png',
    'assets/images/Avengers2.png',
    'assets/images/Avengers3.png',
    'assets/images/Avengers4.png',
  ];

  @override
  void initState() {
    // CommonUtils.showLoadingDialog(context, '正在加载');
    // loadData();
    _controller = EasyRefreshController();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  // Future loadData() async {
  //   await dio
  //       .get(
  //           'https://result.eolinker.com/VI1Wbcdb5a5f53e8621a1e4c252df9124da6a9030246781?uri=imgUrlList')
  //       .then(
  //     (res) {
  //       setState(
  //         () {
  //           dataList = json.decode(res.data)['list'];
  //         },
  //       );
  //     },
  //   );
  // }

  Future _refresh() async {
    // await loadData();
    await new Future.delayed(const Duration(seconds: 2), () {
      // loadData();
    });
  }

  Future _onLoad() async {
    await new Future.delayed(const Duration(seconds: 2), () {
      List list = [];
      int count = 5;
      while (count > 0) {
        list.add(dataList[count]);
        count--;
      }
      setState(() {
        dataList.addAll(list);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return EasyRefresh(
          controller: _controller,
          header: ClassicalHeader(
            bgColor: Colors.transparent,
            textColor: Colors.black87,
          ),
          footer: ClassicalFooter(
            bgColor: Colors.transparent,
            textColor: Colors.black87,
          ),
          child: new ListView.builder(
            //ListView的Item
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  height: 240.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 280.0,
                        width: double.infinity,
                        child: Stack(
                          children: <Widget>[
                            Image.asset(
                              model.imageUrl ?? 'assets/images/Avengers1.png',
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            BackdropFilter(
                              filter:
                                  new ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                              child: new Container(
                                color: Colors.white.withOpacity(0.1),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                imgUrlList[index],
                                fit: BoxFit.fitWidth,
                              ),
                            );
                          },
                          onIndexChanged: (index) {
                            model.setSlideImage(imgUrlList[index]);
                          },
                          itemCount: 4,
                          viewportFraction: 0.8,
                          scale: 0.9,
                          onTap: (index) {
                            return Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return WebviewPage(url: imgUrlList[index]);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return HomeItemWidget(index: index, dataList: dataList);
              }
            },
          ),
          onRefresh: _refresh,
          onLoad: _onLoad,
        );
      },
    );
  }
}
