import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign/tdesign.dart';

void main() {
  testWidgets('测试Bagde正常显示', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Badge(content: 'NEW')));
    expect(find.text('NEW'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: Badge(count: 1)));
    expect(find.text('1'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: Badge(count: 0)));
    expect(find.text('0'), findsNothing);
    await tester.pumpWidget(MaterialApp(home: Badge(count: 0, showZero: true)));
    expect(find.text('0'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: Badge(content: 'NEW', size: BadgeSize.small, shape: BadgeShape.rounded)));
    expect(find.text('NEW'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: Badge(count: 1, size: BadgeSize.small, shape: BadgeShape.rounded)));
    expect(find.text('1'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: Badge(dot: true)));
    expect(find.byType(Badge), findsOneWidget);
    await tester.pumpWidget(
        MaterialApp(home: Badge(shape: BadgeShape.ribbon, child: Container(width: 100, height: 100), content: 'NEW')));
    expect(find.byType(CustomPaint), findsWidgets);
  });

  testWidgets('测试showZero控制count为0时是否显示', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Badge(count: 0)));
    expect(find.text('0'), findsNothing);
    await tester.pumpWidget(MaterialApp(home: Badge(count: 0, showZero: true)));
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('测试maxCount控制显示的最大数字', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Badge(count: 100)));
    expect(find.text('100'), findsNothing);
    expect(find.text('99+'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: Badge(count: 100, maxCount: 9)));
    expect(find.text('100'), findsNothing);
    expect(find.text('9+'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: Badge(count: 9, maxCount: 9)));
    expect(find.text('9'), findsOneWidget);
  });
}
