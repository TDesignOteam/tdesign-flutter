import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign/tdesign.dart';

void main() {
  bool selected = false;
  List<String> selectedList = [];
  testWidgets('测试CheckBox正常显示和操作', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TDCheckBox(
        name: '1.1',
        title: '单行标题',
        onChange: (checked, _) {
          selected = checked;
        },
      ),
    ));
    expect(find.text('单行标题'), findsOneWidget);
    await tester.tap(find.text('单行标题'));
    expect(selected, true);
    expect(find.text('单行标题'), findsOneWidget);
    await tester.tap(find.text('单行标题'));
    expect(selected, false);
  });

  testWidgets('测试CheckBox disable', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TDCheckBox(
        name: '1.1',
        title: '单行标题',
        disabled: true,
        onChange: (checked, _) {
          selected = checked;
        },
      ),
    ));
    selected = false;
    await tester.tap(find.text('单行标题'));
    expect(selected, false);
  });

  testWidgets('测试CheckBox文字不可点选', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TDCheckBox(
        name: '1.1',
        title: '单行标题',
        contentDisabled: true,
        onChange: (checked, _) {
          selected = checked;
        },
      ),
    ));
    selected = false;
    await tester.tap(find.text('单行标题'));
    expect(selected, false);
    await tester.tap(find.byKey(Key('unselected_icon')));
    expect(selected, true);
  });

  testWidgets('测试CheckBox自定义图标', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TDCheckBox(
        name: '1.1',
        title: '单行标题',
        selectedIconBuilder: (_) => Icon(TDIcons.add, key: Key('custom_selected_icon')),
        unselectedIconBuilder: (_) => Icon(TDIcons.app, key: Key('custom_unselected_icon')),
      ),
    ));
    expect(find.byKey(Key('custom_selected_icon')), findsOneWidget);
    expect(find.byKey(Key('custom_unselected_icon')), findsOneWidget);
  });

  testWidgets('测试CheckGroup正常显示和操作', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TDCheckGroup(
        options: [
          GroupOption(name: '选项1', title: '选项一'),
          GroupOption(name: '选项2', title: '选项二'),
          GroupOption(name: '选项3', title: '选项三'),
        ],
        onChange: (checked) => selectedList = checked,
      ),
    ));
    expect(find.text('选项一'), findsOneWidget);
    expect(find.text('选项二'), findsOneWidget);
    expect(find.text('选项三'), findsOneWidget);
    await tester.tap(find.text('选项一'));
    expect(selectedList, ['选项1']);
    await tester.tap(find.text('选项二'));
    expect(selectedList, ['选项1', '选项2']);
    await tester.tap(find.text('选项三'));
    expect(selectedList, ['选项1', '选项2', '选项3']);
    await tester.tap(find.text('选项二'));
    expect(selectedList, ['选项1', '选项3']);
  });

  testWidgets('测试CheckGroup最多可选', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TDCheckGroup(
        options: [
          GroupOption(name: '选项1', title: '选项一'),
          GroupOption(name: '选项2', title: '选项二'),
          GroupOption(name: '选项3', title: '选项三'),
        ],
        onChange: (checked) => selectedList = checked,
        selectLimit: 2,
      ),
    ));
    expect(find.text('选项一'), findsOneWidget);
    expect(find.text('选项二'), findsOneWidget);
    expect(find.text('选项三'), findsOneWidget);
    await tester.tap(find.text('选项一'));
    expect(selectedList, ['选项1']);
    await tester.tap(find.text('选项二'));
    expect(selectedList, ['选项1', '选项2']);
    await tester.tap(find.text('选项三'));
    expect(selectedList, ['选项1', '选项2']);
    await tester.tap(find.text('选项二'));
    await tester.tap(find.text('选项三'));
    expect(selectedList, ['选项1', '选项3']);
  });

  testWidgets('测试CheckGroup Controller控制', (WidgetTester tester) async {
    TDCheckGroupController controller = new TDCheckGroupController();
    await tester.pumpWidget(MaterialApp(
      home: TDCheckGroup(
        options: [
          GroupOption(name: '选项1', title: '选项一'),
          GroupOption(name: '选项2', title: '选项二'),
          GroupOption(name: '选项3', title: '选项三'),
        ],
        onChange: (checked) => selectedList = checked,
        controller: controller,
      ),
    ));
    selectedList = [];
    controller.toggleAll(checked: true);
    expect(selectedList, ['选项1', '选项2', '选项3']);
    controller.toggleAll(checked: false);
    expect(selectedList, []);
    controller.check('选项2');
    expect(selectedList, ['选项2']);
    controller.toggleAll();
    expect(selectedList, ['选项1', '选项3']);
    controller.uncheck('选项1');
    expect(selectedList, ['选项3']);
    controller.toggle('选项2');
    controller.toggle('选项3');
    expect(selectedList, ['选项2']);
  });
}
