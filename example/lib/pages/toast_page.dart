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
    Toast.init();
    return ExamplePage(child: _widget(), title: 'Toast');
  }

  Widget _widget() {
    return ListView(children: [
      PageUtil.buildSubTitle('文本轻提示'),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            child: Text('短文本轻提示'), onPressed: () => Toast.toast('轻提示内容')),
      ),
      Divider(height: 0),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            child: Text('长文本轻提示'),
            onPressed: () =>
                Toast.toast('这是一条长文字提示，超过一定字数就会换行。这是一条长文字提示，超过一定字数就会换行')),
      ),
      PageUtil.buildSubTitle('图标轻提示'),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            ElevatedButton(child: Text('成功'), onPressed: () => Toast.success()),
      ),
      Divider(height: 0),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(child: Text('警告'), onPressed: () => Toast.fail()),
      ),
      Divider(height: 0),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            ElevatedButton(child: Text('加载'), onPressed: () => Toast.loading()),
      ),
      Divider(height: 0),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            ElevatedButton(child: Text('自定义图标'), onPressed: () => Toast.info()),
      ),
      PageUtil.buildSubTitle('图标加文本轻提示'),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            child: Text('成功'), onPressed: () => Toast.success(message: '成功文案')),
      ),
      Divider(height: 0),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            child: Text('警告'), onPressed: () => Toast.fail(message: '失败文案')),
      ),
      Divider(height: 0),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            child: Text('加载'), onPressed: () => Toast.loading(message: '加载')),
      ),
      Divider(height: 0),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            child: Text('自定义图标'),
            onPressed: () => Toast.info(message: '自定义图标')),
      ),
      PageUtil.buildSubTitle('提示位置'),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            child: Text('顶部Top'),
            onPressed: () => Toast.success(toastPosition: ToastPosition.top)),
      ),
      Divider(height: 0),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            child: Text('中间Middle'),
            onPressed: () =>
                Toast.success(toastPosition: ToastPosition.middle)),
      ),
      Divider(height: 0),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            child: Text('底部Bottom'),
            onPressed: () =>
                Toast.success(toastPosition: ToastPosition.bottom)),
      ),
      PageUtil.buildSubTitle('z遮罩'),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            child: Text('带背景遮罩'),
            onPressed: () => Toast.toast('轻提示内容', showOverlay: true)),
      ),
    ]);
  }
}
