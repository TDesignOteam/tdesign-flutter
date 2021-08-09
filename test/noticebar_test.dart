import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign/tdesign.dart';
import 'utils.dart';

void main() {
  testWidgets('测试NoticeBar文字显示', (WidgetTester tester) async {
    await tester.pumpWidget(boilerplate(TDNoticeBar(text: '描述详情')));
    expect(find.text('描述详情'), findsOneWidget);

    await tester.pumpWidget(boilerplate(TDNoticeBar(
        text: '锦瑟无端五十弦，一弦一柱思华年。  庄生晓梦迷蝴蝶，望帝春心托杜鹃。  '
            '沧海月明珠有泪，蓝田日暖玉生烟。  此情可待成追忆，只是当时已惘然。')));
    expect(
        find.text('锦瑟无端五十弦，一弦一柱思华年。  庄生晓梦迷蝴蝶，望帝春心托杜鹃。  '
            '沧海月明珠有泪，蓝田日暖玉生烟。  此情可待成追忆，只是当时已惘然。'),
        findsOneWidget);

    await tester.pumpWidget(boilerplate(TDNoticeBar(
      text: '描述详情',
      detailText: 'detail',
    )));
    expect(find.byWidgetPredicate((Widget widget) => widget is RichText && widget.text.toPlainText() == '描述详情  detail'),
        findsOneWidget);

    await tester.pumpWidget(boilerplate(TDNoticeBar(
      text: '锦瑟无端五十弦，一弦一柱思华年。  庄生晓梦迷蝴蝶，望帝春心托杜鹃。  '
          '沧海月明珠有泪，蓝田日暖玉生烟。  此情可待成追忆，只是当时已惘然。',
      scrollable: true,
      detailText: 'detail',
    )));
    expect(find.text('detail'), findsNothing);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(
        find.widgetWithText(
            SingleChildScrollView,
            '锦瑟无端五十弦，一弦一柱思华年。  庄生晓梦迷蝴蝶，望帝春心托杜鹃。  '
            '沧海月明珠有泪，蓝田日暖玉生烟。  此情可待成追忆，只是当时已惘然。'),
        findsWidgets);
  });

  testWidgets('测试NoticeBar的Icon显示', (WidgetTester tester) async {
    await tester.pumpWidget(boilerplate(TDNoticeBar(
      text: '描述详情',
      mode: TDNoticeBarMode.text,
    )));
    expect(find.byType(Icon), findsNothing);

    await tester.pumpWidget(boilerplate(TDNoticeBar(text: '描述详情')));
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byIcon(Icons.info), findsOneWidget);

    await tester.pumpWidget(boilerplate(TDNoticeBar(
      text: '描述详情',
      mode: TDNoticeBarMode.closeable,
    )));
    expect(find.byType(Icon), findsNWidgets(2));
    expect(find.byIcon(Icons.volume_up), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);

    await tester.pumpWidget(boilerplate(TDNoticeBar(
      text: '描述详情',
      mode: TDNoticeBarMode.link,
    )));
    expect(find.byType(Icon), findsNWidgets(2));
    expect(find.byIcon(Icons.info), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_right), findsOneWidget);
  });

  testWidgets('测试NoticeBar操作执行', (WidgetTester tester) async {
    await tester.pumpWidget(boilerplate(TDNoticeBar(
      text: '描述详情',
      mode: TDNoticeBarMode.link,
      onLink: () => print('成功点击了 linkIcon'),
    )));
    await tester.tap(find.byIcon(Icons.keyboard_arrow_right));
    await tester.pump();

    await tester.pumpWidget(boilerplate(TDNoticeBar(
      text: '描述',
      detailText: '详情',
      onDetail: () => print('成功点击了 detailText'),
    )));
    await tester.tap(find.byWidgetPredicate((widget) => widget is RichText && widget.text.toPlainText() == '描述  详情'));

    await tester.pumpWidget(boilerplate(TDNoticeBar(
      text: '描述',
      mode: TDNoticeBarMode.closeable,
      onClose: () => print('成功点击了 closeIcon'),
    )));
    await tester.tap(find.byIcon(Icons.close));
  });
}
