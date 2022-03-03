import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/renderbox/render_cloud_widget.dart';

class CustomLayoutPage extends StatefulWidget {
  @override
  CustomLayoutPageState createState() => new CustomLayoutPageState();
}


class CustomLayoutPageState extends State<CustomLayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义布局'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CusRenderBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon( Icons.ac_unit_outlined)),
                    Text("哈哈")
                  ],
                )
              ),
              CusRenderBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon( Icons.ac_unit_outlined)),
                      Text("哈哈")
                    ],
                  )
              ),
              CusRenderBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon( Icons.ac_unit_outlined)),
                      Text("哈哈")
                    ],
                  )
              ),
              Container(
                color: Colors.indigoAccent,
                child: CloudWidget(
                  children: <Widget>[
                    Text(
                      "哈哈1",
                      style: new TextStyle(
                        fontSize:  18,
                        color: Colors.lightBlue,
                      ),
                    ),
                    Text(
                      "哈哈2",
                      style: new TextStyle(
                        fontSize:  20,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "哈哈3",
                      style: new TextStyle(
                        fontSize:  14,
                        color: Colors.deepOrangeAccent,
                      ),
                    )
                 ]
                ),
              )
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

class CusRenderBox extends SingleChildRenderObjectWidget{
  final double size;

  CusRenderBox({Widget child,this.size = 0}):super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCusRenderBox(size);
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderCusRenderBox renderObject) {
    renderObject.sizes = size;
  }
}

// class RenderCusRenderBox extends RenderBox with RenderObjectWithChildMixin{
class RenderCusRenderBox extends RenderProxyBox{
  double sizes = 5;

  Paint _paint = Paint()
    ..color = Colors.yellow
    ..strokeWidth = 3;

  RenderCusRenderBox(this.sizes);

  @override
  void paint(PaintingContext context, Offset offset) {
    print("##########  ${size.width}  ${size.height} ${offset.dx} ${offset.dy}");
    context.canvas.drawRect(Rect.fromLTRB(offset.dx, offset.dy, offset.dx + 5, offset.dy + size.height), _paint);
    context.canvas.drawCircle(offset + Offset(2,size.height / 2), 5, _paint..color = Colors.black);
    context.canvas.drawCircle(offset + Offset(2,size.height / 2), 8, _paint..color = Colors.black.withAlpha(124));
    context.paintChild(child, offset);
  }
}