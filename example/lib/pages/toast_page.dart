import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class ToastPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ToastPageState();
  }
}

class _ToastPageState extends State<ToastPage> {
  @override
  void initState() {
    super.initState();
    // Toast.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(), title: 'Toast');
  }

  Widget _widget() {
    return ListView(children: [
      PageUtil.buildSubTitle('文本轻提示'),
      PageUtil.outlinedButton('短文本轻提示', () => TDToast.toast('轻提示内容')),
      PageUtil.outlinedButton(
          '长文本轻提示', () => TDToast.toast('色不异空空不异色色即是空空即是色色不异空空不异色色即是空空即是色')),
      PageUtil.outlinedButton('超长文本轻提示',
          () => TDToast.toast('色不异空，空不异色，色即是空，空即是色。色不异空，空不异色，色即是空，空即是色。')),
      PageUtil.buildSubTitle('图标轻提示'),
      PageUtil.outlinedButton('成功', () => TDToast.success()),
      PageUtil.outlinedButton('警告', () => TDToast.fail()),
      PageUtil.outlinedButton('加载', () => TDToast.loading()),
      PageUtil.outlinedButton('自定义图标', () => TDToast.info()),
      PageUtil.buildSubTitle('图标加文本轻提示'),
      PageUtil.outlinedButton('成功', () => TDToast.success(message: '成功文案')),
      PageUtil.outlinedButton('警告', () => TDToast.fail(message: '失败文案')),
      PageUtil.outlinedButton('加载', () => TDToast.loading(message: '加载')),
      PageUtil.outlinedButton('自定义图标', () => TDToast.info(message: '自定义图标')),
      PageUtil.outlinedButton('超长警告', () => TDToast.fail(message: '般若波罗蜜多心经')),
      PageUtil.buildSubTitle('提示位置'),
      PageUtil.outlinedButton(
          '顶部Top', () => TDToast.success(toastPosition: ToastPosition.top)),
      PageUtil.outlinedButton('中间Middle',
          () => TDToast.success(toastPosition: ToastPosition.middle)),
      PageUtil.outlinedButton('底部Bottom',
          () => TDToast.success(toastPosition: ToastPosition.bottom)),
      PageUtil.buildSubTitle('z遮罩'),
      PageUtil.outlinedButton(
          '带背景遮罩', () => TDToast.toast('轻提示内容', showOverlay: true)),
    ]);
  }
}
