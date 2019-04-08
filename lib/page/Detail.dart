import 'package:flutter/material.dart';
import '../widget/SliverAppBarDelegate.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key key, @required this.imgUrl}) : super(key: key);
  final String imgUrl;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        //AppBar，包含一个导航栏
        // SliverAppBar(
        //   pinned: true,
        //   expandedHeight: 250.0,
        //   flexibleSpace: FlexibleSpaceBar(
        //     title: const Text('Detail'),
        //     background: Image.asset(
        //       widget.imgUrl,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        SliverPersistentHeader(
          pinned: false,
          floating: false,
          delegate: SliverAppBarDelegate(
            minHeight: 60.0,
            maxHeight: 220.0,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  child: Image.network(
                    widget.imgUrl,
                    fit: BoxFit.fill,
                    height: 220.0,
                    width: double.infinity,
                  ),
                ),
                AppBar(
                  title: Text("Detail"),
                  automaticallyImplyLeading: true,
                  backgroundColor: Color.fromRGBO(2, 2, 2, 0),
                ),
                Positioned(
                  bottom: -20.0,
                  right: 30.0,
                  child: FloatingActionButton(
                    child: Icon(Icons.favorite),
                  ),
                )
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: new SliverGrid(
            //Grid
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //Grid按两列显示
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //创建子widget
                return new Container(
                  alignment: Alignment.center,
                  color: Colors.cyan[100 * (index % 9)],
                  child: new Text(
                    'grid item $index',
                    style: TextStyle(
                      inherit: false,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ),
        //List
        new SliverFixedExtentList(
          itemExtent: 50.0,
          delegate:
              new SliverChildBuilderDelegate((BuildContext context, int index) {
            //创建列表项
            return new Container(
              alignment: Alignment.center,
              color: Colors.lightBlue[100 * (index % 9)],
              child: new Text(
                'list item $index',
                style: TextStyle(
                  inherit: false,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            );
          }, childCount: 50 //50个列表项
                  ),
        ),
      ],
    );
  }
}
