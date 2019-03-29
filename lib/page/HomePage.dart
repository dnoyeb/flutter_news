import 'dart:async';
import 'package:flutter/material.dart';
// import '../common/model/MainModel.dart';
// import 'package:scoped_model/scoped_model.dart';
import '../widget/pullToResresh.dart';
// import '../common/config/Config.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isShow = false;

  bool isLoading = false;

  int page = 1;
  int value1 = 0;
  int value2 = 0;
  List dataList;

  final PullToRefreshWidgetControl pullLoadWidgetControl =
      new PullToRefreshWidgetControl();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        dataList = List.generate(15, (i) => '哈喽,我是原始数据 $i');
      });
    });
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('刷新');
      setState(() {
        dataList = List.generate(20, (i) => '哈喽,我是新刷新的 $i');
      });
    });
  }

  Future _getMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('加载更多');
      setState(() {
        dataList.addAll(List.generate(5, (i) => '第 $page 次上拉来的数据'));
      });
    });
  }

  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 1;
    var result = await _onRefresh();
    setState(() {
      pullLoadWidgetControl.needLoadMore = (result != null);
    });
    isLoading = false;
    return null;
  }

  Future<Null> onLoadMore() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page++;
    var result = await _getMore();
    setState(() {
      pullLoadWidgetControl.needLoadMore = (result != null);
    });
    isLoading = false;
    return null;
  }

  Widget _renderRow(int index) {
    return ListTile(
      title: Text(dataList[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PullToRefreshWidget(
      pullLoadWidgetControl,
      (BuildContext context, int index) =>
          _renderRow(pullLoadWidgetControl.dataList[index]),
      handleRefresh,
      onLoadMore,
      refreshKey: refreshIndicatorKey,
    );
  }
}
