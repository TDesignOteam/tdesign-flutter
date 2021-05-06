import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

// 做基础组件测试时，用该接口包一下
Widget boilerplate(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: child,
  );
}

extension WidgetTesterExt on WidgetTester {
  // 获取指定finder匹配到元素的个数
  int count(Finder finder) => widgetList(finder).length;
}
