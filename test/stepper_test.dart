import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign/tdesign.dart';
import 'utils.dart';

void main() {
  testWidgets('测试Stepper文字显示', (WidgetTester tester) async {
    await tester.pumpWidget(boilerplatePlus(TDStepper(value: 10, label: '标题文字')));
    expect(find.text('标题文字'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('测试Stepper基础操作', (WidgetTester tester) async {
    await tester.pumpWidget(boilerplatePlus(TDStepper(
      value: 10,
      min: 0,
      max: 20,
      label: '标题文字',
      onChanged: (value) => print('value: $value'),
    )));

    expect(find.text('标题文字'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    expect(find.text('9'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    expect(find.text('10'), findsOneWidget);

    var textField = find.byType(TextField);
    await tester.enterText(textField, '15');
    expect(find.text('15'), findsOneWidget);
  });

  testWidgets('测试Stepper禁用操作', (WidgetTester tester) async {
    await tester.pumpWidget(boilerplatePlus(TDStepper(value: 10, label: '标题文字', disabled: true)));

    expect(find.text('标题文字'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove), warnIfMissed: false);
    expect(find.text('10'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
    expect(find.text('10'), findsOneWidget);
  });

  testWidgets('Stepper边界测试', (WidgetTester tester) async {
    await tester.pumpWidget(boilerplatePlus(TDStepper(
      value: 10,
      min: 9,
      max: 11,
      label: '标题文字',
      onChanged: (value) => print('value: $value'),
    )));

    expect(find.text('标题文字'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove), warnIfMissed: false);
    await tester.tap(find.byIcon(Icons.remove), warnIfMissed: false);
    expect(find.text('9'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
    await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
    await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
    expect(find.text('11'), findsOneWidget);

    var textField = find.byType(TextField);
    await tester.enterText(textField, '15');
    expect(find.text('11'), findsOneWidget);
    await tester.enterText(textField, '1');
    expect(find.text('9'), findsOneWidget);
  });
}
