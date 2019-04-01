
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text('Info'),
                pinned: true,
                floating: true,
                forceElevated: boxIsScrolled,
                expandedHeight: 200.0,
                flexibleSpace: Container(
                  child: Image.asset(
                    'assets/images/timg1.jpg',
                    width: double.infinity,
                    // repeat: ImageRepeat.repeat,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(
                      text: "page1",
                      icon: Icon(Icons.filter_1),
                    ),
                    Tab(
                      text: "page2",
                      icon: Icon(Icons.filter_2),
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            children: <Widget>[
              PageOne(),
              PageTwo(),
            ],
            controller: _tabController,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.control_point),
          onPressed: () {
            _tabController.animateTo(1,
                curve: Curves.bounceInOut,
                duration: Duration(milliseconds: 10));
            _scrollViewController
                .jumpTo(_scrollViewController.position.maxScrollExtent);
          },
        ),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(
          'assets/images/timg2.jpg',
          width: 300.0,
          fit: BoxFit.contain,
        ),
        Image.asset(
          'assets/images/timg3.jpg',
          width: 300.0,
          fit: BoxFit.contain,
        ),
      ],
    ));
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
            padding: EdgeInsets.all(10.0),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(5.0),
              color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
              child: Center(
                child: Text(index.toString()),
              ),
            ),
          ),
    );
  }
}
