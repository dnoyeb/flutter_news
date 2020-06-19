import 'package:flutter/material.dart';
import '../page/MyPage.dart';
import '../page/HomePage.dart';
import '../page/InfoPage.dart';
import '../page/MyDrawer.dart';
import '../page/BeautyPage.dart';

class TabPage extends StatefulWidget {
  TabPage({Key key}) : super(key: key);
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  List<Widget> pages = List<Widget>();
  int _selectedIndex = 0;
  TabController _tabController;
  @override
  void initState() {
    pages..add(HomePage())..add(BeautyPage())..add(InfoPage())..add(MyPage());
    _tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new MyDrawer(),
      body: pages[_selectedIndex],
      // TabBarView(
      //   controller: _tabController,
      //   children: <Widget>[
      //     HomePage(),
      //     BeautyPage(),
      //     InfoPage(),
      //     MyPage(),
      //   ],
      // ),
      //  pages[_selectedIndex],
      // bottomNavigationBar: Container(
      //   height: 60.0,
      //   color: Colors.grey[300],
      //   child: TabBar(
      //     isScrollable: false,
      //     controller: _tabController,
      //     indicatorColor: Colors.blueAccent,
      //     labelColor: Colors.blueAccent,
      //     onTap: (value) {
      //       // print(value);
      //     },
      //     tabs: <Widget>[
      //       Tab(icon: Icon(Icons.home), text: 'Home'),
      //       Tab(icon: Icon(Icons.remove_red_eye), text: 'Beauty'),
      //       Tab(icon: Icon(Icons.info), text: 'Info'),
      //       Tab(icon: Icon(Icons.account_circle), text: 'My'),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor:Theme.of(context).primaryColor,
        backgroundColor:Colors.white,
        // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.grey[300],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            title: Text('Beauty'),
            backgroundColor: Colors.grey[300],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('Info'),
            backgroundColor: Colors.grey[300],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('My'),
            backgroundColor: Colors.grey[300],
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
