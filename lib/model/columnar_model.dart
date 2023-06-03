import 'dart:ui';

import 'package:untitled/model/week_model.dart';

class ColumnarModel {
  List<WeekModel> source;
  double padding;
  double factor;
  double maxWidth;

  double dashWidth;

  int dashTime;
  Color dashColor;
  Color dashTextColor;
  double dashTextSize;
  double dashGap;

  Color normalColor;
  Color upColor;
  Color downColor;

  Color dashBottomColor;
  double dashBottomGap;

  Color textColor;
  double textSize;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColumnarModel &&
          runtimeType == other.runtimeType &&
          source == other.source;

  @override
  int get hashCode => source.hashCode;
}