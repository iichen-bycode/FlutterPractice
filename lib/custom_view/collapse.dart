import 'package:flutter/material.dart';

class Collapse extends StatefulWidget {
  @override
  CollapseState createState() => new CollapseState();
}

// 可以看 ListTile的内部实现 就是ClipRect+Align
class CollapseState extends State<Collapse> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation<double> _heightFactor;
  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 250));
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('伸缩组件'),
      ),
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _controller.view,
          builder: (BuildContext context, Widget child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "完善更多信息，获得精准实例方案(选填)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black
                          ),
                        ),
                      ),
                      IconButton(icon:Icon(isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down), onPressed: () {
                        setState(() {
                          isExpand = !isExpand;
                        });
                        if(_controller.isCompleted)
                          _controller.reverse();
                        else
                          _controller.forward();
                      },)
                    ],
                  ),
                  ClipRect(
                    child: Align(
                      alignment: Alignment.center,
                      heightFactor: _heightFactor.value,
                      child: Container(
                        child: Column(
                          children: [
                            Container(height: 200, color: Colors.pinkAccent,),
                            Container(height: 200, color: Colors.blueGrey,),
                            Container(height: 200, color: Colors.deepPurpleAccent,),
                            Container(height: 200, color: Colors.green,)
                          ],
                        ),
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Text("hah "),
        ),
      ),
    );
  }


}