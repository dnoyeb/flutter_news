import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../widget/SliverAppBarDelegate.dart';
import '../common/model/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:syk_flutter/page/Detail.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// import '../page/MyDrawer.dart';
// import '../common/config/Config.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isShow = false;

  bool isLoading = false;

  int page = 0;
  List dataList;
  var imgUrlList = [
    'assets/images/slide1.png',
    'assets/images/slide2.png',
    'assets/images/slide3.png',
    'assets/images/slide4.png',
  ];

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    setState(() {
      dataList = List.generate(15, (i) => '原始数据 $i');
    });
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        dataList = List.generate(20, (i) => '刷新数据 $i');
      });
    });
  }

  Future _getMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      page++;
      setState(() {
        dataList.addAll(List.generate(10, (i) => '第 $page 次上拉加载的数据'));
      });
    });
  }

  // _renderRow(int index) {
  //   return ListTile(
  //     title: Text(dataList[index]),
  //   );
  // }

  void goDetail(BuildContext context, imgUrl, index) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            body: SizedBox.expand(
              child: Hero(
                tag: index,
                child: new DetailPage(
                  imgUrl: imgUrl,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: SliverAppBarDelegate(
              minHeight: 60.0,
              maxHeight: 180.0,
              child: Container(
                  child: Stack(
                children: <Widget>[
                  Container(
                    height: 180.0,
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          model.imageUrl ?? 'assets/images/slide1.png',
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        BackdropFilter(
                          filter: new ImageFilter.blur(sigmaX: 6, sigmaY: 6),
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
                        return Hero(
                          tag: index,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              imgUrlList[index],
                              fit: BoxFit.fill,
                            ),
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
                        return new MaterialApp(
                          routes: {
                            "/": (_) => new WebviewScaffold(
                                  url: "https://www.baidu.com",
                                  appBar: new AppBar(
                                    title: new Text(imgUrlList[index]),
                                  ),
                                )
                          },
                        );
                        // goDetail(context, imgUrlList[index], index);
                      },
                    ),
                  )
                ],
              )),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Text('123');
              },
              childCount: 100,
            ),
          )
          // EasyRefresh(
          //   key: _easyRefreshKey,
          //   behavior: ScrollOverBehavior(),
          //   refreshHeader: ClassicsHeader(
          //     key: _headerKey,
          //     bgColor: Colors.transparent,
          //     textColor: Colors.black87,
          //     moreInfoColor: Colors.black54,
          //     showMore: true,
          //   ),
          //   refreshFooter: ClassicsFooter(
          //     key: _footerKey,
          //     bgColor: Colors.transparent,
          //     textColor: Colors.black87,
          //     moreInfoColor: Colors.black54,
          //     showMore: true,
          //   ),
          //   child: new ListView.builder(
          //     //ListView的Item
          //     itemCount: dataList.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return new Container(
          //         height: 160.0,
          //         child: Container(
          //           margin: new EdgeInsets.all(10.0),
          //           color: index % 2 == 0 ? Colors.brown : Colors.deepOrange,
          //           child: new Center(
          //             child: new Text(
          //               dataList[index],
          //               style: new TextStyle(fontSize: 18.0),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          //   onRefresh: _onRefresh,
          //   loadMore: _getMore,
          // ),
        ],
      );
    });
  }
}
