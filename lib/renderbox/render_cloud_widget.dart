import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///CloudWidget RenderBox
///默认都会 mixins  ContainerRenderObjectMixin 和 RenderBoxContainerDefaultsMixin
class RenderCloudWidget extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, RenderCloudParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, RenderCloudParentData> {
  RenderCloudWidget({
    List<RenderBox> children,
  })  {
    addAll(children);
  }

  ///是否重复区域了
  bool overlaps(RenderCloudParentData data) {
    Rect rect = data.content;
    RenderBox child = data.previousSibling;

    if (child == null) {
      return false;
    }

    do {
      RenderCloudParentData childParentData = child.parentData as RenderCloudParentData;
      if (rect.overlaps(childParentData.content)) {
        return true;
      }
      child = childParentData.previousSibling;
    } while (child != null);
    return false;
  }

  ///设置为我们的数据
  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! RenderCloudParentData)
      child.parentData = RenderCloudParentData();
  }

  @override
  void performLayout() {
    ///没有 childCount 不玩
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    ///初始化区域
    var recordRect = Rect.zero;
    var previousChildRect = Rect.zero;

    RenderBox child = firstChild;

    while (child != null) {
      var curIndex = -1;
      ///提出数据
      final RenderCloudParentData childParentData = child.parentData as RenderCloudParentData;

      child.layout(constraints, parentUsesSize: true);

      var childSize = child.size;

      ///记录大小
      childParentData.width = childSize.width;
      childParentData.height = childSize.height;

      do {
        ++curIndex;

        ///设置为遏制
        childParentData.offset = Offset(0, curIndex * 8.toDouble());

        ///判处是否交叠
      } while (overlaps(childParentData));

      ///记录区域
      previousChildRect = childParentData.content;
      recordRect = recordRect.expandToInclude(previousChildRect);

      ///下一个
      child = childParentData.nextSibling;
    }

    ///调整布局大小
    size = constraints
        .tighten(
          height: recordRect.height,
          width: recordRect.width,
        )
        .smallest;
  }

  ///设置绘制默认
  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  @override
  bool hitTestChildren(HitTestResult result, { Offset position}) {
    return defaultHitTestChildren(result as BoxHitTestResult, position: position);
  }
}

/// CloudParentData
class RenderCloudParentData extends ContainerBoxParentData<RenderBox> {
  double width;
  double height;

  Rect get content => Rect.fromLTWH(
        offset.dx,
        offset.dy,
        width,
        height,
      );
}


class CloudWidget extends MultiChildRenderObjectWidget {
  CloudWidget({
    Key key,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCloudWidget();
  }
}