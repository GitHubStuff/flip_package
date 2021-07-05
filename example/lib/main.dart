// Copyright 2021 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:flip_package/flip_package.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pushed = false;
  Widget _scaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${DateTime.now().toLocal()}',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text('Have you pushed the button?', style: Theme.of(context).textTheme.headline5),
            Text(
              pushed ? '😈' : '😇',
              style: Theme.of(context).textTheme.headline3,
            ),
            Container(
              height: 200,
              width: 200,
              child: flipWidget(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            pushed = !pushed;
          });
        },
        tooltip: 'Push',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget flipWidget() {
    return FlipWidget(
      frontWidget: Container(height: 100, width: 100, color: Colors.blue),
      backWidget: Container(height: 100, width: 100, color: Colors.green),
      flipXAxis: false,
      flipCallback: (side) {
        debugPrint('Side: $side');
      },
    );
  }
}
