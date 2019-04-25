import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syk_flutter/common/net/http.dart';
import 'package:syk_flutter/widget/HomeItem.dart';
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
  List dataList = [];
  var imgUrlList = [
    'http://pic162.nipic.com/file/20180420/26806460_165258143000_2.jpg',
    'http://img1.juimg.com/141011/330800-1410111R61550.jpg',
    'http://pic150.nipic.com/file/20171219/26316369_132213731000_2.jpg',
    'http://img5.imgtn.bdimg.com/it/u=3255342426,1145076963&fm=200&gp=0.jpg'
  ];

  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  @override
  void initState() {
    // CommonUtils.showLoadingDialog(context, '正在加载');
    loadData();
    // Navigator.of(context).pop();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Future loadData() async {
    await dio
        .get(
            'https://result.eolinker.com/VI1Wbcdb5a5f53e8621a1e4c252df9124da6a9030246781?uri=imgUrlList')
        .then(
      (res) {
        setState(
          () {
            dataList = json.decode(res.data)['list'];
          },
        );
      },
    );
  }

  Future _refresh() async {
    // await loadData();
    await new Future.delayed(const Duration(seconds: 2), () {
      loadData();
    });
  }

  Future _loadMore() async {
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
          key: _easyRefreshKey,
          behavior: ScrollOverBehavior(),
          refreshHeader: ClassicsHeader(
            key: _headerKey,
            refreshText: '下拉刷新',
            refreshReadyText: '松开刷新',
            refreshingText: '正在刷新...',
            refreshedText: '刷新完成',
            moreInfo: '更新时间 %T',
            bgColor: Colors.transparent,
            textColor: Colors.black87,
            moreInfoColor: Colors.black54,
            showMore: true,
          ),
          refreshFooter: ClassicsFooter(
            key: _footerKey,
            loadText: '上拉加载',
            loadReadyText: '松开加载',
            loadingText: '正在加载...',
            noMoreText: '没有更多数据...',
            loadedText: '加载完成',
            moreInfo: '加载时间 %T',
            bgColor: Colors.transparent,
            textColor: Colors.black87,
            moreInfoColor: Colors.black54,
            showMore: true,
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
                            Image.network(
                              model.imageUrl ??
                                  'http://pic162.nipic.com/file/20180420/26806460_165258143000_2.jpg',
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
                              child: Image.network(
                                imgUrlList[index],
                                fit: BoxFit.fill,
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
              } else{
                return HomeItemWidget(index: index, dataList: dataList);
              }
            },
          ),
          onRefresh: _refresh,
          loadMore: _loadMore,
        );
      },
    );
  }
}
