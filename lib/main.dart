import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled/renderbox/custom_layout.dart';

void main() => runApp(MyApp());
MediaQueryData mediaQuery;
double statusBarHeight;
double screenHeight;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomLayoutPage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

