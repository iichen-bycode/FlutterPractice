import 'dart:async';
import 'dart:ui' as dartUi;
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';

class CustomCardRenderBox extends StatefulWidget {
  @override
  CustomCardRenderBoxState createState() => new CustomCardRenderBoxState();
}

class CustomCardRenderBoxState extends State<CustomCardRenderBox> {
  TextEditingController _widthFiledController;
  TextEditingController _heightFiledController;

  GlobalKey key = GlobalKey();
  GlobalKey imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _widthFiledController = TextEditingController(text: "450");
    _heightFiledController = TextEditingController(text: "450");
  }

  Offset point = Offset(0, 0);
  /// 当前小球的 x 坐标
  double currentX = 0;
  /// 当前小球的 y 坐标
  double currentY = 0;

  double scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(''),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Text("改变"),
            onPressed: (){
              setState(() {

              });
            },
          ),
          FloatingActionButton(
            child: Text("截屏"),
            onPressed: () async {
              RenderRepaintBoundary boundary = imageKey.currentContext.findRenderObject() as RenderRepaintBoundary;
              print("######### ${ window.devicePixelRatio}");
              dartUi.Image image = await boundary.toImage(pixelRatio: window.devicePixelRatio);
              ByteData byteData = await (image.toByteData(format: dartUi.ImageByteFormat.png));
              if (byteData != null) {
                final result =
                    await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
                print(result);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _widthFiledController,
            ),
            TextField(
              controller: _heightFiledController,
            ),
            RepaintBoundary(
              key: imageKey,
              child: Container(
                width: double.parse(_widthFiledController.text),
                height: double.parse(_heightFiledController.text),
                color: Colors.black38,
                child: Stack(
                  children: [
                    ClipRect(
                      clipper:_MyClipper(),
                      child: PhotoView(
                          imageProvider: AssetImage("asserts/card.png")
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(currentX,currentY),
                      child: GestureDetector(
                        onPanDown: (detail){
                          // RenderBox render = key.currentContext.findRenderObject();
                        },
                        onPanUpdate: (detail){
                          RenderBox render = key.currentContext.findRenderObject();
                          setState(() {
                            currentX += detail.delta.dx;
                            if(currentX<=0)
                              currentX = 0;
                            else if(currentX >= double.parse(_widthFiledController.text) - render.size.width){
                              currentX = double.parse(_widthFiledController.text) - render.size.width;
                            }

                            currentY += detail.delta.dy;
                            if(currentY<=0)
                              currentY = 0;
                            else if(currentY>=double.parse(_heightFiledController.text) - render.size.height){
                              currentY = double.parse(_heightFiledController.text) - render.size.height;
                            }
                          });
                        },
                        child: Transform(
                          alignment: getSweepBasePoint(),
                          transform: Matrix4.rotationZ(math.pi / 180 * angle),
                          child: Container(
                            key: key,
                            color: Colors.transparent,
                            child: IntrinsicWidth(
                              child: TextField(
                                style: TextStyle(
                                  color: pickerColor,
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  letterSpacing: letterSpacing,
                                  wordSpacing: 30,
                                ),
                                decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    border: InputBorder.none,
                                    hintText: '输入提示占位字符',
                                    hintStyle: TextStyle(color: pickerColor, fontSize: 16.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            setTextSize(),
            setTextFontWeight(),
            setTextletterSpacing(),
            setTextAngle(),
            setRotatePoint(),
            TextButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select a color'),
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: pickerColor,
                            onColorChanged: (color){
                              setState(() {
                                pickerColor = color;
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text("文字颜色")
            )
            // CustomPaint(
            //   painter: CardPainter(),
            //   size: Size(double.parse(_widthFiledController.text), double.parse(_heightFiledController.text)),
            // ),
          ],
        ),
      )
    );
  }

  int groupValue = 0;
  Column setRotatePoint(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Row(
              children: [
                Text("左上"),
                Radio(
                    value: 0,
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value;
                      });
                    }
                )
              ],
            ),
            Row(
              children: [
                Text("中上"),
                Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value;
                      });
                    }
                )
              ],
            ),
            Row(
              children: [
                Text("右上"),
                Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value;
                      });
                    }
                )
              ],
            ),
          ],
        ),
        Row(
          children: [
            Row(
              children: [
                Text("左中"),
                Radio(
                    value: 3,
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value;
                      });
                    }
                )
              ],
            ),
            Row(
              children: [
                Text("中心"),
                Radio(
                    value: 4,
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value;
                      });
                    }
                )
              ],
            ),
            Row(
              children: [
                Text("右中"),
                Radio(
                    value: 5,
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value;
                      });
                    }
                )
              ],
            ),
          ],
        ),
        Row(
          children: [
            Row(
              children: [
                Text("下左"),
                Radio(
                    value: 6,
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value;
                      });
                    }
                )
              ],
            ),
            Row(
              children: [
                Text("下右"),
                Radio(
                    value: 7,
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value;
                      });
                    }
                )
              ],
            ),
            Row(
              children: [
                Text("下右"),
                Radio(
                    value: 8,
                    groupValue: groupValue,
                    onChanged: (value){
                      setState(() {
                        groupValue = value;
                      });
                    }
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  double angle = 0;
  Row setTextAngle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("文字旋转角度"),
        Slider(
            min: 0,
            max: 360,
            value: angle,
            label: "$angle",
            onChanged: (value){
              setState(() {
                angle = value;
              });
            }
        ),
      ],
    );
  }
  
  Color pickerColor = Colors.redAccent;

  double letterSpacing = 0;
  Row setTextletterSpacing() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("文字间距"),
              Slider(
                  min: 0,
                  max: 50,
                  value: letterSpacing,
                  label: "$letterSpacing",
                  onChanged: (value){
                    setState(() {
                      letterSpacing = value;
                    });
                  }
              ),
            ],
          );
  }

  Row setTextFontWeight() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("文字粗细"),
              Slider(
                  min: 0,
                  max: 8,
                  value: fontWeightIndex,
                  label: "$fontWeightIndex",
                  onChanged: (value){
                    setState(() {
                      fontWeightIndex = value;
                      fontWeight = FontWeight.values[fontWeightIndex.toInt()];
                    });
                  }
              ),
            ],
          );
  }

  Row setTextSize() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("文字大小"),
              Slider(
                min: 12,
                max: 50,
                value: fontSize,
                label: "$fontSize",
                onChanged: (value){
                  setState(() {
                    fontSize = value;
                  });
                }
              ),
            ],
          );
  }
  double fontSize = 12;
  double fontWeightIndex = 0;
  FontWeight fontWeight = FontWeight.values[0];

  @override
  void dispose() {
    super.dispose();
  }

  getSweepBasePoint() {
    Alignment alignment;
    switch(groupValue){
      case 0:
        alignment = Alignment.topLeft;
        break;
      case 1:
        alignment = Alignment.topCenter;
        break;
      case 2:
        alignment = Alignment.topRight;
        break;
      case 3:
        alignment = Alignment.centerLeft;
        break;
      case 4:
        alignment = Alignment.center;
        break;
      case 5:
        alignment = Alignment.centerRight;
        break;
      case 6:
        alignment = Alignment.bottomLeft;
        break;
      case 7:
        alignment = Alignment.bottomCenter;
        break;
      case 8:
        alignment = Alignment.bottomRight;
        break;
    }
    return alignment;
 }
}



class _MyClipper extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
    return new Rect.fromLTRB(0, 0, size.width,  size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class CardPainter extends CustomPainter{
  Paint _paint;

  Offset beforePoint = Offset(0, 0);
  CardPainter(){
    _paint = Paint();
    _paint.style = PaintingStyle.fill;
    _paint.color = Colors.black38;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), _paint);
    ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
      textAlign: TextAlign.start, // 对齐方式
      fontWeight: FontWeight.w600, // 粗体
      fontStyle: FontStyle.normal, // 正常 or 斜体
      fontSize: 18,
    ))
      ..pushStyle(dartUi.TextStyle(color: Colors.black26))
      ..addText("测试文本的绘制");
  // 绘制的宽度
    ParagraphConstraints pc = ParagraphConstraints(width:size.width);
    Paragraph paragraph = pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, Offset(0,0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}