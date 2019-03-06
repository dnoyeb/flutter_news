import 'package:flutter/material.dart';
import '../common/model/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(child:
        ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return Text('点击${model.count.toString()} 次');
    }));
  }
}
