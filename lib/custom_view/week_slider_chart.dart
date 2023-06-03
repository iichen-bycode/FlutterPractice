import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' as intl;
import 'package:untitled/model/columnar_model.dart';
import 'package:untitled/model/week_model.dart';

class WeekSliderChart extends StatefulWidget {
  @override
  WeekSliderChartState createState() => new WeekSliderChartState();
}

class WeekSliderChartState extends State<WeekSliderChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WeekSliderChart'),
      ),
      body: ColoredBox(
        color: Colors.black12,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 200,
            child: GestureDetector(
              child: PageView.builder(
                reverse: true,
                onPageChanged: (page) {
                  if(page == data.length - 2) {
                    // 预加载
                    getData(previousMonth);
                    print(">>>>>>>>> $page 添加");
                  }
                  print(">>>>>>>>> $page");
                },
                itemBuilder: (BuildContext context, int index) {
                  return CustomPaint(
                    painter: WeekColumnarPainter(
                        data[index]
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
  List<ColumnarModel> data = [];

  DateTime previousMonth;
  @override
  void initState() {
    // 获取当前时间
    DateTime now = DateTime.now();


    getData(now);
    setState(() {
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getData(DateTime now) {
    Random random = Random();

    // 获取前一个月的日期范围
    previousMonth = now.subtract(Duration(days: 7));
    DateTime startOfMonth = DateTime(previousMonth.year, previousMonth.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month, 0);
    previousMonth = startOfMonth;

    // 遍历前一个月每一天的日期
    DateTime currentDate = startOfMonth;
    int i = 1;
    List<WeekModel> source = [];
    while (currentDate.isBefore(endOfMonth)) {
      currentDate = currentDate.add(Duration(days: 1));

      // 生成随机的时间戳
      final randomTimestamp = random.nextInt(12);

      source.add(WeekModel(intl.DateFormat('MM/dd').format(currentDate), "6小时", randomTimestamp));
      if(i % 7 == 0) {
        i = 1;
        data.add(ColumnarModel()..source = source.reversed.toList()
          ..padding = 8
          ..dashColor = Color(0xff59C889)
          ..dashGap = 2
          ..dashTime = 60 * 60 * 2
          ..dashTextSize = 12
          ..dashTextColor = Color(0xff59C889)
          ..textSize = 12
          ..textColor = Color(0xff999999)
          ..normalColor = Color(0xffF6F8FA)
          ..upColor = Color(0xff59C889)
          ..downColor = Color(0xffFFAA4D)
          ..dashBottomColor = Color(0xffcccccc)
          ..dashBottomGap = 2
          ..dashWidth = 4);
        source.clear();
      } else {
        i++;
      }
    }
  }

}

class WeekColumnarPainter extends CustomPainter {
  ColumnarModel model;

  Paint dashLinePaint;
  Paint dashTextPaint;

  Paint dashBottomLinePaint;

  Paint timeTextPaint;

  Paint normalRectPaint;
  Paint upRectPaint;
  Paint downRectPaint;

  WeekColumnarPainter(ColumnarModel model) {
    this.model = model;
    dashLinePaint = Paint()..color = model.dashColor..strokeWidth = 1..style = PaintingStyle.stroke;
    dashTextPaint = Paint()..color = model.dashColor;

    dashBottomLinePaint = Paint()..color = model.dashBottomColor..strokeWidth = 2..style = PaintingStyle.stroke;

    timeTextPaint = Paint()..color = model.textColor;

    normalRectPaint = Paint()..color = model.normalColor;
    upRectPaint = Paint()..color = model.upColor;
    downRectPaint = Paint()..color = model.downColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    TextPainter dashTextPainter = doGetTextPainter("6小时",model.dashTextSize,model.dashTextColor);
    dashTextPainter.layout();

    // 设置左右padding
    double rightGap = size.width - dashTextPainter.width - model.padding;
    double leftGap = model.padding;
    // 最终绘制区域
    double contentW = size.width - dashTextPainter.width - model.padding * 2;

    // itemGap = 0.7itemW 计算出的 11
    double itemW = contentW / 10;
    double itemGap = (contentW - 7 * itemW) / 6;

    double startX = leftGap;

    // 绘制虚线下的文本
    for(int i = 0;i < model.source.length;i++) {
      WeekModel weekModel = model.source[i];


      // 12 换成数组里最大的那个  mock数据 最大是这个
      TextPainter textPainter = doGetTextPainter(weekModel.textTime,model.textSize,model.textColor);
      textPainter.layout();
      double textHeight = textPainter.height;
      double textWidth = textPainter.width;

      // 使得矩形中心与 文本中心对齐
      double rectCenter = startX + itemW / 2;
      Offset offset = Offset(rectCenter - textWidth / 2, size.height - textHeight);
      textPainter.paint(canvas, offset);

      // 修正矩形等 最底部高度
      double realH = size.height - textHeight;

      // 背景默认矩形
      RRect rRect = RRect.fromLTRBAndCorners(startX, 0, startX + itemW, realH, topLeft: Radius.circular(5), topRight: Radius.circular(5));
      canvas.drawRRect(rRect, normalRectPaint);

      // 绘制中间虚线
      drawDashLine(size, canvas,rightGap,realH/2,model.dashGap,model.dashWidth,dashLinePaint);
      // 绘制中心虚线对应的文本
      Offset dashOffset = Offset(rightGap + 5, (realH - dashTextPainter.height) / 2);
      dashTextPainter.paint(canvas, dashOffset);

      // 矩形
      // 12 换成数组里最大的那个  mock数据 最大是这个
      RRect rect = RRect.fromLTRBAndCorners(startX, realH * (weekModel.time / 12), startX + itemW, realH, topLeft: Radius.circular(5), topRight: Radius.circular(5));
      // 取中间数
      canvas.drawRRect(rect,weekModel.time >= 6 ? downRectPaint : upRectPaint);

      // 底部虚线
      drawDashLine(size, canvas,rightGap,realH,model.dashBottomGap,model.dashWidth,dashBottomLinePaint);

      startX += itemW + itemGap;
    }
  }

  TextPainter doGetTextPainter(String text,double fontSize,Color fontColor) {
    TextSpan textSpan = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
      ),
    );
    TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr
    );
    return textPainter;
  }

  void drawDashLine(Size size, Canvas canvas,double w,double h,double gap,double dashWidth,Paint paint) {
    Path path = Path();
    double startW = 0;
    for(;startW <= w;startW += dashWidth + gap){
      path.moveTo(startW, h);
      path.lineTo(startW + dashWidth, h);
    }
    canvas.drawPath(path, paint);
  }


  @override
  bool shouldRepaint(covariant WeekColumnarPainter oldDelegate) {
    return true;
  }
}