import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign/tdesign.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

void main() {
  group('rate', () {
    testWidgets('Default', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(value: 2)));

      // 默认存在5个star类型的图标
      expect(tester.count(find.byIcon(Icons.star)), 5);

      // 目前打了两星，其中有三个star做了颜色混合
      expect(tester.count(find.byType(ColorFiltered)), 3);

      // 默认是不存在描述文字的
      expect(tester.count(find.byType(Text)), 0);

      expect(tester.count(find.byType(IgnorePointer)), 5);

      // 点击了最后一个图标，就会打5星，颜色混合组件就会消失
      await tester.tap(find.byType(IgnorePointer).at(4));
      await tester.pumpAndSettle();
      expect(tester.count(find.byType(ColorFiltered)), 0);
    });
  });
}
