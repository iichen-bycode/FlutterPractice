import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SliderDelete extends StatefulWidget {
  @override
  SliderDeleteState createState() => new SliderDeleteState();
}

class SliderDeleteState extends State<SliderDelete>
    with SingleTickerProviderStateMixin {
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe to Delete'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 16),
              child: Dismissible(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "周一",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333)),
                          ),
                        ),
                        Switch(value: true, onChanged: (v) {})
                      ],
                    ),
                  ),
                  innerChild: Container(
                    margin: const EdgeInsets.only(left: 6),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Color(0xffFB9494),
                      ),
                      child: Text("删除"),
                      onPressed: () {},
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }
}

class Dismissible extends StatefulWidget {
  final Widget child;
  final Widget innerChild;

  const Dismissible({this.child, this.innerChild});

  @override
  DismissibleState createState() => new DismissibleState();
}

class DismissibleState extends State<Dismissible>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _moveAnimation;
  AnimationController _moveController;

  // 拖拽距离
  double _dragExtent = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      dragStartBehavior: DragStartBehavior.start,
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: (details) {
        _dragExtent = 0;
        _moveController.value = 0;
        setState(() {
          _updateMoveAnimation();
        });
      },
      onHorizontalDragUpdate: (details) {
        double delta = details.primaryDelta;
        double oldDragExtent = _dragExtent;
        if (_dragExtent + delta < 0) _dragExtent += delta;
        if (oldDragExtent.sign != _dragExtent.sign) {
          setState(() {
            _updateMoveAnimation();
          });
        }
        if (!_moveController.isAnimating) {
          double progress = _dragExtent.abs();
          print(">>>>>>>> $progress $maxFlap");
          if(progress >= maxFlap) {
            progress = maxFlap;
          }
          _moveController.value = progress / context.size.width;
        }
      },
      onHorizontalDragEnd: (details) {},
      child: Stack(children: [
        Align(
          alignment: Alignment.centerRight,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              maxFlap = constraints.minWidth;
              return widget.innerChild;
            },
          ),
        ),
        SlideTransition(
          position: _moveAnimation,
          child: widget.child,
        ),
      ]),
    );
  }

  double maxFlap = 0;

  @override
  void initState() {
    _moveController = AnimationController(vsync: this);
    _updateMoveAnimation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateMoveAnimation() {
    final double end = _dragExtent.sign;
    _moveAnimation = _moveController.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: Offset(end, 0),
      ),
    );
  }
}

class _SlidableClipper extends CustomClipper<Rect> {
  _SlidableClipper({
    this.controller,
  }) : super();

  AnimationController controller;

  @override
  Rect getClip(Size size) {
    final double offset = controller.value * size.width;
    if (offset < 0) {
      return Rect.fromLTRB(size.width + offset, 0, size.width, size.height);
    }
    return Rect.fromLTRB(0, 0, offset, size.height);
  }

  @override
  Rect getApproximateClipRect(Size size) => getClip(size);

  @override
  bool shouldReclip(_SlidableClipper oldClipper) {
    return true;
  }
}
