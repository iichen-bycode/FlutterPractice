import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/custom_view/collapse.dart';
import 'package:untitled/renderbox/bubble_renderbox_widget.dart';

import 'custom_view/progress_slider.dart';
import 'custom_view/slider_delete.dart';
import 'custom_view/week_slider_chart.dart';
import 'custom_view_home.dart';

void main() => runApp(MyApp());
MediaQueryData mediaQuery;
double statusBarHeight;
double screenHeight;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/collapse': (context) => Collapse(),
        '/progress_slider': (context) => ProgressSlider(),
        '/slider_delete': (context) => SliderDelete(),
        '/week_slider_chart': (context) => WeekSliderChart(),
      },
      debugShowCheckedModeBanner: false,
      home: CustomViewHome(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}




