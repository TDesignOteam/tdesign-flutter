import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign/tdesign.dart';

import '../page_util.dart';

class StepperPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(), title: 'Stepper');
  }

  Widget _widget() {
    return ListView(children: [
      PageUtil.buildSubTitle('步进器'),
      Divider(height: 0),
      TDStepper(
        value: 0,
        min: -100,
        max: 1000,
        label: '标题文字',
        onChanged: (value) => _onChanged(value),
      ),
      Divider(height: 0),
      TDStepper(
        value: 0,
        step: 3,
        min: -100,
        max: 1000,
        label: '自定义步长',
        onChanged: (value) => _onChanged(value),
      ),
      Divider(height: 0),
      TDStepper(
        value: 0,
        min: -100,
        max: 1000,
        disabled: true,
        label: '禁用',
        onChanged: (value) => _onChanged(value),
      ),
      Divider(height: 0),
      TDStepper(
        value: 1,
        min: 0,
        max: 100,
        label: '禁用输入框',
        disableInput: true,
        onChanged: (value) => _onChanged(value),
      ),
      Divider(height: 0),
      TDStepper(
        value: 0,
        min: 0,
        max: 10,
        label: '自定义范围（0-10）',
        disableInput: true,
        onChanged: (value) => _onChanged(value),
      ),
      Divider(height: 0),
      TDStepper(
        value: 10,
        min: 0,
        max: 100,
        inputWidth: 100,
        label: '自定义大小',
        onChanged: (value) => _onChanged(value),
      ),
      Divider(height: 0),
    ]);
  }

  _onChanged(String value) {
    TDToast.toast(
      'value：$value',
      duration: Duration(milliseconds: 200),
      toastPosition: TDToastPosition.bottom,
    );
  }
}
