import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum TriangleBubbleAxis{
  LEFT,TOP,RIGHT,BOTTOM
}
class BubbleRenderBoxWidget extends SingleChildRenderObjectWidget {
  final double triangleWidth;
  final double triangleHeight;
  final double offset;
  final TriangleBubbleAxis axis;
  final Color color;

  BubbleRenderBoxWidget({
    Widget child,
    this.triangleWidth,
    this.triangleHeight,
    this.offset,
    this.axis,
    this.color
  }):super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return BubbleRenderBox(
      triangleWidth:triangleWidth,
      triangleHeight:triangleHeight,
      offset:offset,
      axis:axis,
      color:color,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant BubbleRenderBox renderObject) {
    renderObject..triangleHeight = triangleHeight
        ..triangleWidth = triangleWidth
        ..color = color
        ..offset = offset
        ..axis = axis;

  }
}

class BubbleRenderBox extends RenderBox with RenderObjectWithChildMixin {
  Path _path;
  Paint _paint;

  double triangleWidth;
  double triangleHeight;
  double offset;
  TriangleBubbleAxis axis;
  Color color;

  BubbleRenderBox({
    this.triangleWidth,
    this.triangleHeight,
    this.offset,
    this.axis,
    this.color
  }){
    _path = Path();
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
  }

  @override
  void performLayout() {
    child.layout(constraints,parentUsesSize: true);
    size = (child as RenderBox).size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if(axis == TriangleBubbleAxis.BOTTOM){
      _path.moveTo(offset.dx + this.offset, offset.dy + size.height);
      _path.lineTo(offset.dx + this.offset +  triangleWidth / 2, offset.dy + size.height + triangleHeight);
      _path.lineTo(offset.dx + this.offset +  triangleWidth, offset.dy + size.height);
      _path.close();
    }else if(axis == TriangleBubbleAxis.LEFT){
      _path.moveTo(offset.dx, offset.dy + this.offset);
      _path.lineTo(offset.dx - triangleHeight, offset.dy + this.offset + triangleWidth / 2);
      _path.lineTo(offset.dx, offset.dy + this.offset + triangleWidth);
      _path.close();
    }else if(axis == TriangleBubbleAxis.RIGHT){
      _path.moveTo(offset.dx + size.width, offset.dy + this.offset);
      _path.lineTo(offset.dx + size.width + triangleHeight, offset.dy + this.offset + triangleWidth / 2);
      _path.lineTo(offset.dx + size.width, offset.dy + this.offset + triangleWidth);
      _path.close();
    }else{
      _path.moveTo(offset.dx + this.offset, offset.dy);
      _path.lineTo(offset.dx + this.offset +  triangleWidth / 2, offset.dy - triangleHeight);
      _path.lineTo(offset.dx + this.offset +  triangleWidth, offset.dy);
      _path.close();
    }
    context.canvas.drawPath(_path, _paint);
    context.paintChild(child, offset);
    super.paint(context, offset);
  }
}

/*
Container(
        margin: const EdgeInsets.all(35),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 12.0), //阴影xy轴偏移量
                blurRadius: 20.0, //阴影模糊程度
                spreadRadius: 0.1//阴影扩散程度
            )
          ],
          borderRadius: BorderRadius.circular(18),
          color: Colors.white
        ),
        child: BubbleRenderBoxWidget(
          triangleHeight: 15,
          triangleWidth: 30,
          color: Colors.white,
          offset: 45,
          axis: TriangleBubbleAxis.BOTTOM,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("我好爱你啊！！！！！",style: TextStyle(fontSize: 16,color: Colors.black),),
                Text("我好爱你啊！！！！！",style: TextStyle(fontSize: 16,color: Colors.black),),
                Text("我好爱你啊！！！！！",style: TextStyle(fontSize: 16,color: Colors.black),),
                Text("我好爱你啊！！！！！",style: TextStyle(fontSize: 16,color: Colors.black),),
                Text("我好爱你啊！！！！！",style: TextStyle(fontSize: 16,color: Colors.black),),
                Text("我好爱你啊！！！！！",style: TextStyle(fontSize: 16,color: Colors.black),),
                Text("我好爱你啊！！！！！",style: TextStyle(fontSize: 16,color: Colors.black),),
                Text("我好爱你啊！！！！！",style: TextStyle(fontSize: 16,color: Colors.black),),
                Text("我好爱你啊！！！！！",style: TextStyle(fontSize: 16,color: Colors.black),),
                Text("我好爱你啊！！！！！",style: TextStyle(fontSize: 16,color: Colors.black),),
              ],
            ),
          ),
        ),
      ),
 */