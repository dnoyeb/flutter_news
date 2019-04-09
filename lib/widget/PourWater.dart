import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';

import 'package:sensors/sensors.dart';

class PourWaterPage extends StatefulWidget {
  @override
  _PourWaterPageState createState() => new _PourWaterPageState();
}

class _PourWaterPageState extends State<PourWaterPage> {
  @override
  void initState() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      // Do something with the event.
      print(event);
      // [GyroscopeEvent (x: -0.0564117431640625, y: -0.1850433349609375, z: 0.072967529296875)]
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('123'),
    );
  }
}
