import 'package:flutter/material.dart';

import 'custom_view/collapse.dart';

class CustomViewHome extends StatefulWidget {
  @override
  CustomViewHomeState createState() => new CustomViewHomeState();
}

class CustomViewHomeState extends State<CustomViewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义View'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.black12,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Collapse(),
            ],
          ),
        ),
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
  }
}