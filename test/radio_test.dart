import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign/tdesign.dart';

void main() {
  List<String> selected = [];
  testWidgets('测试RadioGroup正常显示和操作', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TDRadioGroup(
        options: [
          TDGroupOption(name: 'option1', title: '选项1'),
          TDGroupOption(name: 'option2', title: '选项2'),
          TDGroupOption(name: 'option3', title: '选项3'),
        ],
        onChange: (checked) => selected = checked,
      ),
    ));
    expect(find.text('选项1'), findsOneWidget);
    expect(find.text('选项2'), findsOneWidget);
    expect(find.text('选项3'), findsOneWidget);
    await tester.tap(find.text('选项1'));
    expect(selected, ['option1']);
    await tester.tap(find.text('选项2'));
    expect(selected, ['option2']);
    await tester.tap(find.text('选项3'));
    expect(selected, ['option3']);
  });

  testWidgets('测试RadioGroup disable', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TDRadioGroup(
        options: [
          TDGroupOption(name: 'option1', title: '选项1', disabled: true),
          TDGroupOption(name: 'option2', title: '选项2'),
          TDGroupOption(name: 'option3', title: '选项3'),
        ],
        onChange: (checked) => selected = checked,
      ),
    ));
    selected = [];
    await tester.tap(find.text('选项1'));
    expect(selected, []);
    await tester.tap(find.text('选项2'));
    expect(selected, ['option2']);
  });

  testWidgets('测试RadioGroup文字不可点选', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TDRadioGroup(
        options: [
          TDGroupOption(name: 'option1', title: '选项1'),
          TDGroupOption(name: 'option2', title: '选项2'),
          TDGroupOption(name: 'option3', title: '选项3'),
        ],
        contentDisabled: true,
        onChange: (checked) => selected = checked,
      ),
    ));
    selected = [];
    await tester.tap(find.text('选项1'));
    expect(selected, []);
    await tester.tap(find.byKey(Key('radio_unselected_icon')).at(0));
    expect(selected, ['option1']);
  });
}
