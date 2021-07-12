import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class PopupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PopupPageState();
  }
}

class _PopupPageState extends State<PopupPage> {
  @override
  void initState() {
    super.initState();
    // Message.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      child: _widget(),
      title: 'Popup',
    );
  }

  Widget _horizontalWidget({
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
    double? radius,
  }) {
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: (radius != null ? BorderRadius.all(Radius.circular(radius)) : null),
      ),
      // child: widget
    );
  }

  Widget _verticalWidget({
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
  }) {
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            // 示范内容
            ListTile(
              leading: Icon(Icons.bubble_chart),
              title: Text('item $index'),
            ),
            // 分割线
            Container(height: 1, color: Colors.black.withOpacity(0.1)),
          ]);
        },
      ),
    );
  }

  Widget _widget() {
    return ListView(children: [
      PageUtil.buildSubTitle('弹出位置'),
      PageUtil.outlinedButton(
          '顶部弹出',
          () => Popup.show(
                alignmentTemp: Alignment.topCenter,
                widget: _horizontalWidget(maxHeight: 328),
              )),
      PageUtil.outlinedButton(
          '底部弹出',
          () => Popup.show(
                alignmentTemp: Alignment.bottomCenter,
                onDismiss: () {
                  print('==============test callback==============');
                },
                widget: _horizontalWidget(maxHeight: 240, radius: 8),
              )),
      PageUtil.outlinedButton(
          '中部弹出',
          () => Popup.show(
                alignmentTemp: Alignment.center,
                widget: _horizontalWidget(maxWidth: 88, maxHeight: 88, radius: 4),
              )),
      PageUtil.outlinedButton(
          '左侧弹出',
          () => Popup.show(
                alignmentTemp: Alignment.centerLeft,
                widget: _verticalWidget(maxWidth: 307),
              )),
      PageUtil.outlinedButton(
          '右侧弹出',
          () => Popup.show(
                alignmentTemp: Alignment.centerRight,
                widget: _verticalWidget(maxWidth: 307),
              )),
      PageUtil.buildSubTitle('自定义内容区的动画'),
      PageUtil.outlinedButton(
          '1.5s的slide-fade动画',
          () => Popup.show(
                alignmentTemp: Alignment.bottomCenter,
                animationDurationTemp: Duration(milliseconds: 1500),
                onDismiss: () {
                  print('==============test callback==============');
                },
                widget: _horizontalWidget(maxHeight: 240, radius: 8),
              )),
    ]);
  }
}
