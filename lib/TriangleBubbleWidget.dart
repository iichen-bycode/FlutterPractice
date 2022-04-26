import 'package:flutter/material.dart';

enum TriangleBubbleAxis{
  LEFT,TOP,RIGHT,BOTTOM
}

// 需要配合padding撑开 绘制三角的距离
class TriangleBubbleClipper extends CustomClipper<Path> {
  double radius;
  double offset;
  double triangleWidth;
  TriangleBubbleAxis axis;

  TriangleBubbleClipper({
    this.radius = 8,
    this.axis = TriangleBubbleAxis.BOTTOM,
    this.offset = 10,
    this.triangleWidth = 20
  }):assert(offset >= 0);

  @override
  Path getClip(Size size) {
    if(axis == TriangleBubbleAxis.BOTTOM){
      return paintBottomBubblePath(size);
    }else if(axis == TriangleBubbleAxis.RIGHT){
      return paintRightBubblePath(size);
    }else if(axis == TriangleBubbleAxis.LEFT){
      return paintLeftBubblePath(size);
    }else if(axis == TriangleBubbleAxis.TOP){
      return paintTopBubblePath(size);
    }
    return Path();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    var clipper = oldClipper as TriangleBubbleClipper;
    // return this.radius!=clipper.radius ||
    //     this.offset!=clipper.offset ||
    //     this.axis!=clipper.axis ||
    //     this.triangleWidth!=clipper.triangleWidth;

    return true;
  }

  Path paintBottomBubblePath(Size size) {
    Path path = Path();

    path.moveTo(radius, 0);
    // 左上圆角
    path.quadraticBezierTo(0, 0, 0, radius);
    path.lineTo(0, size.height - radius - triangleWidth / 2);
    // 左下圆角
    path.quadraticBezierTo(0, size.height - triangleWidth / 2, radius, size.height - triangleWidth / 2);

    // line到底部 开始绘制三角的起始位置
    path.lineTo(offset, size.height - triangleWidth / 2);

    path.lineTo(offset + triangleWidth / 2, size.height);
    path.lineTo(offset + triangleWidth, size.height - triangleWidth / 2);
    path.lineTo(size.width - radius, size.height - triangleWidth / 2);
    // 右下角圆角
    path.quadraticBezierTo(size.width, size.height - triangleWidth / 2, size.width, size.height - radius - triangleWidth / 2);
    path.lineTo(size.width,radius);
    // 右上圆角
    path.quadraticBezierTo(size.width,0, size.width-radius, 0);
    path.close();

    return path;
  }

  Path paintRightBubblePath(Size size) {
    Path path = Path();

    path.moveTo(0, radius);
    // 左上圆角
    path.quadraticBezierTo(0, 0, radius, 0);

    path.lineTo(size.width - radius - triangleWidth / 2, 0);

    // 右上圆角
    path.quadraticBezierTo(size.width - triangleWidth / 2, 0, size.width - triangleWidth / 2, radius);

    // 三角
    path.lineTo(size.width - triangleWidth / 2, offset);
    path.lineTo(size.width, offset + triangleWidth / 2);
    path.lineTo(size.width - triangleWidth / 2, offset + triangleWidth);

    path.lineTo(size.width - triangleWidth / 2, size.height - radius);
    // 右下圆角
    path.quadraticBezierTo(size.width - triangleWidth / 2, size.height, size.width - radius - triangleWidth / 2, size.height);

    path.lineTo(radius, size.height);
    // 左下圆角
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    path.close();
    return path;
  }

  Path paintLeftBubblePath(Size size) {
    Path path = Path();

    path.moveTo(triangleWidth / 2, radius);
    // 左上圆角
    path.quadraticBezierTo(triangleWidth / 2, 0, radius + triangleWidth / 2, 0);

    path.lineTo(size.width - radius, 0);
    // 右上圆角
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    path.lineTo(size.width, size.height - radius);
    // 右下圆角
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);

    path.lineTo(radius + triangleWidth / 2, size.height);
    // 左下圆角
    path.quadraticBezierTo(triangleWidth / 2, size.height, triangleWidth / 2, size.height - radius);

    // 三角
    path.lineTo(triangleWidth / 2, radius + offset + triangleWidth);
    path.lineTo(0,  radius + offset + triangleWidth / 2);
    path.lineTo(triangleWidth / 2, radius + offset);

    path.close();
    return path;
  }

  Path paintTopBubblePath(Size size) {
    Path path = Path();

    path.moveTo(0, radius + triangleWidth / 2);
    // 左上圆角
    path.quadraticBezierTo(0, triangleWidth / 2, radius, triangleWidth / 2);
    path.lineTo(offset, triangleWidth / 2);
    // 三角
    path.lineTo(offset + triangleWidth / 2, 0);
    path.lineTo(offset + triangleWidth , triangleWidth / 2);
    path.lineTo(size.width - radius, triangleWidth / 2);
    // 右上圆角
    path.quadraticBezierTo(size.width, triangleWidth / 2, size.width, triangleWidth / 2 + radius);

    path.lineTo(size.width, size.height - radius);
    // 右下圆角
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);

    path.lineTo(radius, size.height);

    // 左下圆角
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    path.close();

    return path;
  }
}
/*
Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                  blurRadius: 20.0, //阴影模糊程度
                  spreadRadius: 0.1//阴影扩散程度
              )
            ]
        ),
        margin: const EdgeInsets.all(35),
        child: ClipPath(
          clipper: TriangleBubbleClipper(radius:18,axis:TriangleBubbleAxis.LEFT,offset:0,triangleWidth:18),
          child: Container(
            padding: const EdgeInsets.only(bottom: 15,left: 25,right: 15,top: 15),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("我爱你爱的好幸福！",style: TextStyle(fontSize: 16,color: Colors.black54),),
                Text("我爱你爱的好幸福！",style: TextStyle(fontSize: 16,color: Colors.black54),),
                Text("我爱你爱的好幸福！",style: TextStyle(fontSize: 16,color: Colors.black54),),
                Text("我爱你爱的好幸福！",style: TextStyle(fontSize: 16,color: Colors.black54),),
                Text("我爱你爱的好幸福！,style: TextStyle(fontSize: 16,color: Colors.black54),),
                Text("我爱你爱的好幸福！",style: TextStyle(fontSize: 16,color: Colors.black54),),
                Text("我爱你爱的好幸福！",style: TextStyle(fontSize: 16,color: Colors.black54),),
                Text("我爱你爱的好幸福！",style: TextStyle(fontSize: 16,color: Colors.black54),),
                Text("我爱你爱的好幸福！",style: TextStyle(fontSize: 16,color: Colors.black54),),
                Text("我爱你爱的好幸福！",style: TextStyle(fontSize: 16,color: Colors.black54),),
                Text("我爱你爱的好幸福！",style: TextStyle(fontSize: 16,color: Colors.black54),),
              ],
            ),
          ),
        ),
      )
 */