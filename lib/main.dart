import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/renderbox/bubble_renderbox_widget.dart';

import 'custom_view_home.dart';

void main() => runApp(MyApp());
MediaQueryData mediaQuery;
double statusBarHeight;
double screenHeight;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomViewHome(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}




