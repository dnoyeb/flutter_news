import 'dart:async';
import 'package:flutter/material.dart';
// import '../common/model/MainModel.dart';
// import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../page/MyDrawer.dart';
// import '../common/config/Config.dart';
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isShow = false;

  bool isLoading = false;

  int page = 0;
  List dataList;

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

  _renderRow(int index) {
    return ListTile(
      title: Text(dataList[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        title: Text("Home"),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: EasyRefresh(
        key: _easyRefreshKey,
        behavior: ScrollOverBehavior(),
        refreshHeader: ClassicsHeader(
          key: _headerKey,
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        refreshFooter: ClassicsFooter(
          key: _footerKey,
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        child: new ListView.builder(
            //ListView的Item
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  height: 70.0,
                  child: Card(
                    child: new Center(
                      child: new Text(
                        dataList[index],
                        style: new TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ));
            }),
        onRefresh: _onRefresh,
        loadMore: _getMore,
      ),
    );
  }
}
