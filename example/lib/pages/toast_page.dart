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

  Widget _outlinedButton(
    String btnTitle,
    VoidCallback callback,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0),
      child: OutlinedButton(
          child: Text(
            btnTitle,
            style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.5),
          ),
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.resolveWith(
                  (states) => Size.fromHeight(48))),
          onPressed: callback),
    );
  }

  Widget _widget() {
    return ListView(children: [
      PageUtil.buildSubTitle('文本轻提示'),
      _outlinedButton('短文本轻提示', () => Toast.toast('轻提示内容')),
      _outlinedButton('长文本轻提示',
          () => Toast.toast('这是一条长文字提示，超过一定字数就会换行。这是一条长文字提示，超过一定字数就会换行')),
      PageUtil.buildSubTitle('图标轻提示'),
      _outlinedButton('成功', () => Toast.success()),
      _outlinedButton('警告', () => Toast.fail()),
      _outlinedButton('加载', () => Toast.loading()),
      _outlinedButton('自定义图标', () => Toast.info()),
      PageUtil.buildSubTitle('图标加文本轻提示'),
      _outlinedButton('成功', () => Toast.success(message: '成功文案')),
      _outlinedButton('警告', () => Toast.fail(message: '失败文案')),
      _outlinedButton('加载', () => Toast.loading(message: '加载')),
      _outlinedButton('自定义图标', () => Toast.info(message: '自定义图标')),
      PageUtil.buildSubTitle('提示位置'),
      _outlinedButton(
          '顶部Top', () => Toast.success(toastPosition: ToastPosition.top)),
      _outlinedButton(
          '中间Middle', () => Toast.success(toastPosition: ToastPosition.middle)),
      _outlinedButton(
          '底部Bottom', () => Toast.success(toastPosition: ToastPosition.bottom)),
      PageUtil.buildSubTitle('z遮罩'),
      _outlinedButton('带背景遮罩', () => Toast.toast('轻提示内容', showOverlay: true)),
    ]);
  }
}
