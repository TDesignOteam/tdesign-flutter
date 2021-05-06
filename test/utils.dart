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

  // 统计指定Icon出现的次数
  int iconCount(IconData icon) => count(find.byIcon(icon));

  // 统计指定type出现的次数
  int typeCount(Type type) => count(find.byType(type));

  Future<void> tapRight(Finder finder) {
    Offset o = getCenter(finder);
    return tapAt(Offset(o.dx + 1, o.dy));
  }

  Future<void> tapLeft(Finder finder) {
    Offset o = getCenter(finder);
    return tapAt(Offset(o.dx - 1, o.dy));
  }
}
