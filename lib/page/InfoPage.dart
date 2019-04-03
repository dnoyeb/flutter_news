import 'package:flutter/material.dart';
import '../common/model/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widget/photoScale.dart';

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
                    repeat: ImageRepeat.repeat,
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
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.control_point),
        //   onPressed: () {
        //     _tabController.animateTo(1,
        //         curve: Curves.bounceInOut,
        //         duration: Duration(milliseconds: 10));
        //     _scrollViewController
        //         .jumpTo(_scrollViewController.position.maxScrollExtent);
        //   },
        // ),
      ),
    );
  }
}

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  void showPhoto(BuildContext context, f, source) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('图片')),
        body: SizedBox.expand(
          child: Hero(
            tag: 1,
            child: new Photo(
              url: f,
              source: source,
            ),
          ),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new GestureDetector(
                onTap: () {
                  showPhoto(context, 'assets/images/timg3.jpg',1);
                },
                child: Hero(
                  tag: 1,
                  child: Image.asset(
                    'assets/images/timg3.jpg',
                    width: 260.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              model.imageData == null
                  ? Text('去拍照')
                  : new GestureDetector(
                      onTap: () {
                        showPhoto(context, model.imageData,2);
                      },
                      child: Hero(
                        tag: 2,
                        child: Image.file(
                          model.imageData,
                          width: 260.0,
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  List ListData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 160.0,
      itemCount: 11,
      itemBuilder: (context, index) => Container(
            margin: EdgeInsets.all(10.0),
            child: Material(
              elevation: 6.0,
              // borderRadius: BorderRadius.circular(5.0),
              color: index % 2 == 0 ? Colors.cyan : Colors.orangeAccent,
              child: Container(
                margin: new EdgeInsets.all(10.0),
                child: new Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/avatar.png',
                          width: 120.0,
                          height: 120.0,
                          fit: BoxFit.contain,
                        ),
                        new Container(
                          padding: new EdgeInsets.all(10.0),
                          // decoration: new BoxDecoration(
                          //   border:
                          //       new Border.all(color: Colors.green, width: 0.5),
                          // ),
                          width: 200.0,
                          // height: 100.0,
                          child: Column(
                            children: <Widget>[
                              Text(
                                '标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                index.toString() + '简介简介简介简介简介简介简介简介简介简介简介简介',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                                style: new TextStyle(
                                  color: Colors.black45,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    new Positioned(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        // width: 140.0,
                        // decoration: new BoxDecoration(
                        //   border: new Border.all(color: Colors.red, width: 0.5),
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new IconButton(
                              tooltip: '喜欢',
                              onPressed: () {
                                setState(() {
                                  ListData[index] =
                                      ListData[index] == 1 ? 0 : 1;
                                });
                              },
                              icon: Icon(
                                ListData[index] == 1
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                      ),
                      right: 0.0,
                      bottom: 0.0,
                    )
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
