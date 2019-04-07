// import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import '../common/model/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';
import '../page/MyPage.dart';
import '../page/HomePage.dart';
import '../page/InfoPage.dart';
// import 'page/WelcomePage.dart';
import '../page/MyDrawer.dart';
import 'package:image_picker/image_picker.dart';
// import '../common/model/MainModel.dart';
// import 'package:scoped_model/scoped_model.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;
  List<Widget> pages = List<Widget>();

  @override
  void initState() {
    pages..add(HomePage())..add(InfoPage())..add(MyPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 2
          ? AppBar(
              //导航栏
              title: Text("My"),
              elevation  : 0.0,
              backgroundColor: Colors.deepPurpleAccent,
            )
          : null,
      drawer: new MyDrawer(), //抽屉
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.info), title: Text('Info')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('My')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: ScopedModelDescendant<MainModel>(
        builder: (context, child, model) {
          return FloatingActionButton(
            // onPressed: model.increment,
            // tooltip: 'add',
            // child: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min, // 设置最小的弹出
                      children: <Widget>[
                        new ListTile(
                          leading: new Icon(Icons.photo_camera),
                          title: new Text("相机"),
                          onTap: () async {
                            Navigator.pop(context);
                            var image = await ImagePicker.pickImage(
                                source: ImageSource.camera);
                            model.setImage(image);
                          },
                        ),
                        new ListTile(
                          leading: new Icon(Icons.photo_library),
                          title: new Text("图库"),
                          onTap: () async {
                            Navigator.pop(context);
                            var image = await ImagePicker.pickImage(
                                source: ImageSource.gallery);
                            model.setImage(image);
                          },
                        ),
                      ],
                    );
                  });
            },
            tooltip: '选择照片',
            backgroundColor: Colors.deepPurple,
            child: Icon(
              Icons.camera,
            ),
          );
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
