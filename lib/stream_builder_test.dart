import 'dart:async';

import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  TestState createState() => new TestState();
}

class TestState extends State<Test> {
  StreamController _streamController = StreamController();

  int index = 0;

  Stream<DateTime> getDate() async*{
    while(true) {
      await Future.delayed(Duration(seconds: 1));
      yield DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: getDate(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            // snapshot.connectionState
            if(snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // initialData
            if(snapshot.hasData) {
              return Text("数据 ${snapshot.data}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _streamController.sink.add("event ${index++}");
        },
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }
}
