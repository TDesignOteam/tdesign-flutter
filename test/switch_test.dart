import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign/tdesign.dart';
import 'utils.dart';

void main() {
  bool status = false;
  testWidgets('测试switch描述信息的显示及操作 | Normal', (WidgetTester tester) async {
    await tester.pumpWidget(boilerplate(TDSwitch(
      value: status,
      text: 'Normal',
      onChanged: (val) {
        status = val;
      },
    )));
    expect(find.text('Normal'), findsOneWidget);
    await tester.tap(find.byType(CupertinoSwitch));
    expect(status, true);

    await tester.pumpWidget(boilerplate(TDSwitch(
      value: status,
      text: 'Normal',
      onChanged: (val) {
        status = val;
      },
    )));
    expect(find.text('Normal'), findsOneWidget);
    await tester.tap(find.byType(CupertinoSwitch));
    expect(status, false);
  });

  testWidgets('测试switch描述信息的显示及操作 | Disable', (WidgetTester tester) async {
    await tester.pumpWidget(boilerplate(TDSwitch(
      value: status,
      type: TDSwitchType.disable,
      text: 'Disable',
      onChanged: (val) {
        status = val;
      },
    )));
    expect(find.text('Disable'), findsOneWidget);
    await tester.tap(find.byType(CupertinoSwitch), warnIfMissed: false);
    expect(status, false);
  });

  testWidgets('测试switch描述信息的显示及操作 | Loading', (WidgetTester tester) async {
    await tester.pumpWidget(boilerplate(TDSwitch(
      value: status,
      type: TDSwitchType.loading,
      text: 'Loading',
      onChanged: (val) {
        status = val;
      },
    )));
    expect(find.text('Loading'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.byType(CupertinoSwitch), warnIfMissed: false);
    expect(status, false);
  });
}
