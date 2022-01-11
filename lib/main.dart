import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<int> s = [1];
  int t = 1;
  double o = 1;
  int r = 1;
  int b = 1;
  int g = 1;
  double a = 60;
  double a1 = 0;
  Tim() {
    const Sec = Duration(milliseconds: 550);
    Timer.periodic(Sec, (timer) {
      setState(() {
        t++;
        Random R = Random();
        o > 255 ? o = 0 : o += R.nextDouble().toDouble();
        r > 255 ? r = 1 : r += R.nextInt(255).toInt();
        g > 255 ? g = 2 : g += R.nextInt(255).toInt();
        b > 255 ? b = 0 : b += R.nextInt(255).toInt();
        a > 45 || a < 0 ? a = 0 : a += R.nextDouble().toDouble();
        a1 > 25 || a1 < 0 ? a1 = 0 : a1 += R.nextDouble().toDouble();
      });
    });
  }

  double widthh = 50;
  double heightt = 50;
  double bott = 200;
  double rig = 200;
  Color Col = Colors.green;
  double angle = 52;
  double val = 0;
  BorderRadius bv = BorderRadius.circular(8);
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    Tim();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  bool sa = true;
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              sa ? sa = false : sa = true;
            },
            child: Text('A'),
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: t,
          itemBuilder: (context, index) => Container(
            color: Color.fromRGBO(r, g, b, o),
            child: Row(
              children: [
                SizedBox(
                  width: a,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(g, r + b, r, 25),
                  maxRadius: 6,
                  minRadius: 6,
                ),
                SizedBox(
                  width: a1,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(g, r + b, r, 25),
                  maxRadius: 6,
                  minRadius: 6,
                ),
                SizedBox(
                  width: a,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(0, r + b, r, 25),
                  maxRadius: 6,
                  minRadius: 6,
                ),
                SizedBox(
                  width: a,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(g, r + b, r, 25),
                  maxRadius: 6,
                  minRadius: 6,
                ),
                SizedBox(width: a1),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(g, r + b, r, 25),
                  maxRadius: 6,
                  minRadius: 6,
                ),
                SizedBox(
                  width: a1,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(g, r + b, r, 25),
                  maxRadius: 6,
                  minRadius: 6,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(g, r + b, r, 25),
                  maxRadius: 6,
                  minRadius: 6,
                ),
                SizedBox(
                  width: a,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(g, r + b, r, 25),
                  maxRadius: 6,
                  minRadius: 6,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(
            () {
              Random R = Random();
              bott = R.nextInt(78).toDouble();
              rig = R.nextInt(100).toDouble();
              widthh = R.nextInt(300).toDouble();
              heightt = R.nextInt(300).toDouble();
              bv = BorderRadius.circular(R.nextInt(88).toDouble());
              Col = Color.fromRGBO(
                  R.nextInt(256), R.nextInt(256), R.nextInt(256), 1);
            },
          );
        },
      ),
    );
    /**
     * // Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformChannel extends StatefulWidget {
  const PlatformChannel({Key? key}) : super(key: key);

  @override
  State<PlatformChannel> createState() => _PlatformChannelState();
}

class _PlatformChannelState extends State<PlatformChannel> {
  static const MethodChannel methodChannel =
      MethodChannel('samples.flutter.io/battery');
  static const EventChannel eventChannel =
      EventChannel('samples.flutter.io/charging');

  String _batteryLevel = 'Battery level: unknown.';
  String _chargingStatus = 'Battery status: unknown.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int? result = await methodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level: $result%.';
    } on PlatformException {
      batteryLevel = 'Failed to get battery level.';
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  void _onEvent(Object? event) {
    setState(() {
      _chargingStatus =
          "Battery status: ${event == 'charging' ? '' : 'dis'}charging.";
    });
  }

  void _onError(Object error) {
    setState(() {
      _chargingStatus = 'Battery status: unknown.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_batteryLevel, key: const Key('Battery level label')),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _getBatteryLevel,
                  child: const Text('Refresh'),
                ),
              ),
            ],
          ),
          Text(_chargingStatus),
        ],
      ),
    );
  }
}
void main() {
  runApp(const MaterialApp(home: PlatformChannel()));
}
     */
  }
}
