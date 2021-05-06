import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign/tdesign.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

void main() {
  group('rate', () {
    testWidgets('默认Rate', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(value: 2)));

      // 默认存在5个star类型的图标
      expect(tester.iconCount(Icons.star), 5);

      // 目前打了两星，其中有三个star做了颜色混合
      expect(tester.typeCount(ColorFiltered), 3);

      // 默认是不存在描述文字的
      expect(tester.typeCount(Text), 0);

      expect(tester.typeCount(ClipRect), 0);

      // 点击了最后一个图标，就会打5星，颜色混合组件就会消失
      await tester.tap(find.byType(IgnorePointer).at(4));
      await tester.pumpAndSettle();
      expect(tester.typeCount(ColorFiltered), 0);
    });

    testWidgets('通过Builder提供Icon的Rate', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(
        value: 2,
        itemBuilder: (context, index) => Icon(Icons.ac_unit),
      )));

      expect(tester.iconCount(Icons.ac_unit), 5);
    });

    testWidgets('通过Config配置提供Icon的Rate', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(
        value: 2,
        ratingIcons: RatingIconConfig(
          empty: Icon(Icons.star_border),
          full: Icon(Icons.star),
          half: Icon(Icons.star_half),
        ),
      )));

      expect(tester.iconCount(Icons.star), 2);
      expect(tester.iconCount(Icons.star_border), 3);
    });

    testWidgets('支持半星的默认Rate', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(value: 2.5, allowHalf: true)));

      // 半星图标需要用到ClipRect，有且只有一个
      expect(tester.typeCount(ClipRect), 1);

      // 获取中间图标的中心位置
      Offset mid = tester.getCenter(find.byType(IgnorePointer).at(2));

      // 点击中间的图标靠右的位置，会将其补全
      await tester.tapAt(Offset(mid.dx + 1, mid.dy));
      await tester.pumpAndSettle();
      expect(tester.typeCount(ClipRect), 0);

      // 点击中间靠左的位置，会将其变为半星
      await tester.tapAt(Offset(mid.dx - 1, mid.dy));
      await tester.pumpAndSettle();
      expect(tester.typeCount(ClipRect), 1);

      // 获取首个图标的中心位置
      Offset first = tester.getCenter(find.byType(IgnorePointer).at(0));

      // 点击首个图标中心靠右位置，会先将其变为1星
      await tester.tapAt(Offset(first.dx + 1, first.dy));
      await tester.pumpAndSettle();
      expect(tester.typeCount(ColorFiltered), 4);

      // 再次点击首个图标中心靠右位置，会将其变为0星
      await tester.tapAt(Offset(first.dx + 1, first.dy));
      await tester.pumpAndSettle();
      expect(tester.typeCount(ColorFiltered), 5);

      // 点击首个图标中心靠右位置，会先将其变为0.5星
      await tester.tapAt(Offset(first.dx - 1, first.dy));
      await tester.pumpAndSettle();
      expect(tester.typeCount(ClipRect), 1);

      // 再次点击首个图标中心靠左位置，会将其变为0星
      await tester.tapAt(Offset(first.dx - 1, first.dy));
      await tester.pumpAndSettle();
      expect(tester.typeCount(ClipRect), 0);
      expect(tester.typeCount(ColorFiltered), 5);
    });

    testWidgets('支持半星的Config配置Rate', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(
        value: 2.5,
        allowHalf: true,
        ratingIcons: RatingIconConfig(
          empty: Icon(Icons.star_border),
          full: Icon(Icons.star),
          half: Icon(Icons.star_half),
        ),
      )));

      // 配置的图标，半星的情况是直接使用的提供的图标
      expect(tester.iconCount(Icons.star), 2);
      expect(tester.iconCount(Icons.star_border), 2);
      expect(tester.iconCount(Icons.star_half), 1);

      // 获取最后图标的中心位置
      Offset last = tester.getCenter(find.byType(IgnorePointer).at(4));

      // 点击最后图标靠右的位置，会打5星
      await tester.tapAt(Offset(last.dx + 1, last.dy));
      await tester.pumpAndSettle();
      expect(tester.iconCount(Icons.star), 5);
      expect(tester.iconCount(Icons.star_border), 0);
      expect(tester.iconCount(Icons.star_half), 0);

      // 点击最后图标靠左的位置，会打4.5星
      await tester.tapAt(Offset(last.dx - 1, last.dy));
      await tester.pumpAndSettle();
      expect(tester.iconCount(Icons.star), 4);
      expect(tester.iconCount(Icons.star_border), 0);
      expect(tester.iconCount(Icons.star_half), 1);
    });
  });
}
