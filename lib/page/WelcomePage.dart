import 'package:flutter/material.dart';
// import '../common/model/MainModel.dart';
// import 'package:scoped_model/scoped_model.dart';
/*
 * 欢迎页
 * Created by siyongkang
 * Date: 2018-07-16
 */

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _tabController =
        TabController(vsync: this, length: 6); // 和下面的 TabBar.tabs 数量对应
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 如果省略了 leading ，但 AppBar 在带有 Drawer 的 Scaffold 中，则会插入一个 button 以打开 Drawer。
    // 否则，如果最近的 Navigator 具有任何先前的 router ，则会插入BackButton。
    // 这种行为可以通过设置来关闭automaticallyImplyLeading 为false。在这种情况下，空的 leading widget 将导致 middle/title widget 拉伸开始。
    return SizedBox(
        height: 500,
        child: Scaffold(
          appBar: AppBar(
            // 大量配置属性参考 SliverAppBar 示例
            title: Text('首页'),
            backgroundColor: Colors.amber[1000],
            bottom: TabBar(
              isScrollable: true,
              controller: _tabController,
              tabs: <Widget>[
                Tab(text: "Tabs 1"),
                Tab(text: "Tabs 2"),
                Tab(text: "Tabs 3"),
                Tab(text: "Tabs 4"),
                Tab(text: "Tabs 5"),
                Tab(text: "Tabs 6"),
              ],
            ),
          ),
          body: TabBarView(controller: _tabController, children: <Widget>[
            Text('TabsView 1'),
            Text('TabsView 2'),
            Text('TabsView 3'),
            Text('TabsView 4'),
            Text('TabsView 5'),
            Text('TabsView 6'),
          ]),
        ));
  }
}

// extends State<WelcomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       // grey box
//       child: Column(
//         // Column is also layout widget. It takes a list of children and
//         // arranges them vertically. By default, it sizes itself to fit its
//         // children horizontally, and tries to be as tall as its parent.
//         //
//         // Invoke "debug painting" (press "p" in the console, choose the
//         // "Toggle Debug Paint" action from the Flutter Inspector in Android
//         // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//         // to see the wireframe for each widget.
//         //
//         // Column has various properties to control how it sizes itself and
//         // how it positions its children. Here we use mainAxisAlignment to
//         // center the children vertically; the main axis here is the vertical
//         // axis because Columns are vertical (the cross axis would be
//         // horizontal).
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           ScopedModelDescendant<MainModel>(
//             builder: (context, child, model) {
//               return Text(
//                 '结果页显示${model.count.toString()} 次了',
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 33.0,
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//       width: 320.0,
//       height: 240.0,
//       color: Colors.grey[300],
//       margin: new EdgeInsets.only(top: 56.0),
//     );
//   }
// }
