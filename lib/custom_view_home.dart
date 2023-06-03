import 'package:flutter/material.dart';

import 'custom_view/collapse.dart';

class CustomViewHome extends StatefulWidget {
  @override
  CustomViewHomeState createState() => new CustomViewHomeState();
}

class CustomViewHomeState extends State<CustomViewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义View'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("伸缩组件"),
                )),
                onTap: () => Navigator.pushNamed(context, '/collapse'),
              ),
              SizedBox(height: 12,),
              InkWell(
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("进度Bar"),
                )),
                onTap: () => Navigator.pushNamed(context, '/progress_slider'),
              ),
              SizedBox(height: 12,),
              InkWell(
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("侧滑删除"),
                )),
                onTap: () => Navigator.pushNamed(context, '/slider_delete'),
              ),
              SizedBox(height: 12,),
              InkWell(
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("周滑动柱状表"),
                )),
                onTap: () => Navigator.pushNamed(context, '/week_slider_chart'),
              ),
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