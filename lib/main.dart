import 'package:flutter/material.dart';
import 'package:untitled/renderbox/bubble_renderbox_widget.dart';

void main() => runApp(MyApp());
MediaQueryData mediaQuery;
double statusBarHeight;
double screenHeight;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}


class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('布局'),
      ),
      body: Container(
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
          axis: TriangleBubbleAxis.TOP,
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




