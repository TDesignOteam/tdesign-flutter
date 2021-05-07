import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign/tdesign.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

void main() {
  group('rate', () {
    testWidgets('默认 | 状态验证', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(value: 2)));

      // 默认存在5个star类型的图标
      expect(tester.iconCount(Icons.star), 5);

      // 目前打了两星，其中有三个star做了颜色混合
      expect(tester.typeCount(ColorFiltered), 3);

      // 默认是不存在描述文字的
      expect(tester.typeCount(Text), 0);

      expect(tester.typeCount(ClipRect), 0);
    });

    testWidgets('Builder | 状态验证', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(
        value: 2,
        itemBuilder: (context, index) => Icon(Icons.ac_unit),
      )));

      expect(tester.iconCount(Icons.ac_unit), 5);
    });

    testWidgets('Config | 状态验证', (WidgetTester tester) async {
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

    testWidgets('默认 | 切换逻辑验证', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(value: 2)));

      // 点击了最后一个图标，就会打5星，颜色混合组件就会消失
      await tester.tap(find.byType(IgnorePointer).at(4));
      await tester.pumpAndSettle();
      expect(tester.typeCount(ColorFiltered), 0);
      expect(tester.iconCount(Icons.star), 5);
    });

    testWidgets('默认 | 支持半星 | 状态验证', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(value: 2.5, allowHalf: true)));

      // 半星图标需要用到ClipRect，有且只有一个
      expect(tester.typeCount(ClipRect), 1);

      // 因为半星的图标位置，会放两个Icons.star，所以有半星时，就会多出一个图标
      expect(tester.iconCount(Icons.star), 6);

      // 目前打了2.5星，仍然是有三个star做了颜色混合
      expect(tester.typeCount(ColorFiltered), 3);
    });

    testWidgets('Config | 支持半星 | 状态验证', (WidgetTester tester) async {
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
    });

    testWidgets('默认 | 支持半星 | 首个星星 | 操作逻辑验证', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(value: 2.5, allowHalf: true)));

      // 获取首个图标的finder
      final first = find.byType(IgnorePointer).at(0);

      // 点击首个图标中心靠右位置，会先将其变为1星
      await tester.tapRight(first);
      await tester.pumpAndSettle();
      expect(tester.typeCount(ColorFiltered), 4);

      // 再次点击首个图标中心靠右位置，会将其变为0星
      await tester.tapRight(first);
      await tester.pumpAndSettle();
      expect(tester.typeCount(ColorFiltered), 5);

      // 点击首个图标中心靠左位置，会先将其变为0.5星
      await tester.tapLeft(first);
      await tester.pumpAndSettle();
      expect(tester.typeCount(ClipRect), 1);

      // 再次点击首个图标中心靠左位置，会将其变为0星
      await tester.tapLeft(first);
      await tester.pumpAndSettle();
      expect(tester.typeCount(ClipRect), 0);
      expect(tester.typeCount(ColorFiltered), 5);
    });

    testWidgets('默认 | 支持半星 | 非首个星星 | 操作逻辑验证', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(value: 2.5, allowHalf: true)));

      // 获取中间图标的finder
      final mid = find.byType(IgnorePointer).at(2);

      // 点击中间的图标靠右的位置，会将其补全
      await tester.tapRight(mid);
      await tester.pumpAndSettle();
      expect(tester.typeCount(ClipRect), 0);

      // 点击中间靠左的位置，会将其变为半星
      await tester.tapLeft(mid);
      await tester.pumpAndSettle();
      expect(tester.typeCount(ClipRect), 1);
    });
    
    testWidgets('Config | 支持半星 | 非首个星星 | 操作逻辑验证', (WidgetTester tester) async {
      await tester.pumpWidget(boilerplate(Rate(
        value: 2.5,
        allowHalf: true,
        ratingIcons: RatingIconConfig(
          empty: Icon(Icons.star_border),
          full: Icon(Icons.star),
          half: Icon(Icons.star_half),
        ),
      )));

      // 获取最后图标的finder
      final last = find.byType(IgnorePointer).at(4);

      // 点击最后图标靠右的位置，会打5星
      await tester.tapRight(last);
      await tester.pumpAndSettle();
      expect(tester.iconCount(Icons.star), 5);
      expect(tester.iconCount(Icons.star_border), 0);
      expect(tester.iconCount(Icons.star_half), 0);

      // 点击最后图标靠左的位置，会打4.5星
      await tester.tapLeft(last);
      await tester.pumpAndSettle();
      expect(tester.iconCount(Icons.star), 4);
      expect(tester.iconCount(Icons.star_border), 0);
      expect(tester.iconCount(Icons.star_half), 1);
    });
  });
}
