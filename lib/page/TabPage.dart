import 'package:flutter/material.dart';
import '../page/MyPage.dart';
import '../page/HomePage.dart';
import '../page/InfoPage.dart';
import '../page/MyDrawer.dart';

class TabPage extends StatefulWidget {
  TabPage({Key key}) : super(key: key);
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // List<Widget> pages = List<Widget>();
  TabController _tabController;
  bool active = false;
  @override
  void initState() {
    // pages..add(HomePage())..add(InfoPage())..add(MyPage());
    _tabController = TabController(vsync: this, length: 3);
     
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: new MyDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          HomePage(),
          InfoPage(),
          MyPage(),
        ],
      ),
      //  pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 60.0,
        color: Colors.grey[300],
        child: TabBar(
          isScrollable: false,
          controller: _tabController,
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.blueAccent,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.info), text: 'Info'),
            Tab(icon: Icon(Icons.account_circle), text: 'My'),
          ],
        ),
      ),
      // BottomNavigationBar(
      //   // 底部导航
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
      //     BottomNavigationBarItem(icon: Icon(Icons.info), title: Text('Info')),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle), title: Text('My')),
      //   ],
      //   currentIndex: _selectedIndex,
      //   fixedColor: Colors.blue,
      //   onTap: _onItemTapped,
      // ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
}
