import 'package:flutter/material.dart';
import 'package:syk_flutter/widget/PourWater.dart';
import '../widget//WaterCup.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String choose = 'PourWater';
  renderPage() {
    switch (choose) {
      case "PourWater":
        return PourWaterPage();
      case "WaterCup":
        return WaterPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(choose),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    PopupMenuItem<String>(
                        value: "PourWater", child: Text('PourWater')),
                    PopupMenuItem<String>(
                        value: "WaterCup", child: Text('WaterCup')),
                  ],
              onSelected: (String action) {
                switch (action) {
                  case "PourWater":
                    setState(() {
                      choose = "PourWater";
                    });
                    break;
                  case "WaterCup":
                    setState(() {
                      choose = "WaterCup";
                    });
                    break;
                }
              })
        ],
      ),
      body: renderPage(),
    );
  }
}
