import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/genericity/controller.dart';

class GenericityPage extends StatefulWidget {
  @override
  GenericityPageState createState() => new GenericityPageState();
}

class GenericityPageState extends State<GenericityPage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  TestController _testController = Get.put(TestController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _testController.len.value, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _testController.len.value,
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          bottom: TabBar(
            tabs: [
              Tab(text: "游戏",),
              Tab(text: "电影",),
              Tab(text: "音乐",),
              Tab(text: "消息",)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _testController.len.value = 3;
          },
        ),
        body: TabBarView(
          children: [
            TestPage(),
            TestPage(),
            TestPage(),
            TestPage(),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }
}

class TestPage extends StatefulWidget {
  @override
  TestPageState createState() => new TestPageState();
}

class TestPageState extends State<TestPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    print("#######  build" );
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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

  @override
  bool get wantKeepAlive => true;

}