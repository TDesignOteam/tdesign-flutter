import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessagePageState();
  }
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    super.initState();
    // Message.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      child: _widget(),
      title: 'Message',
    );
  }

  Widget _widget() {
    return ListView(children: [
      PageUtil.buildSubTitle('带图标消息通知'),
      PageUtil.outlinedButton(
          '普通', () => Message.show('普通消息', msgType: MessageType.info)),
      PageUtil.outlinedButton(
          '成功', () => Message.show('成功消息', msgType: MessageType.success)),
      PageUtil.outlinedButton(
          '警示', () => Message.show('警示消息', msgType: MessageType.warning)),
      PageUtil.outlinedButton(
          '错误', () => Message.show('错误消息', msgType: MessageType.error)),
      PageUtil.outlinedButton(
          '超长警示',
          () => Message.show('色不异空，空不异色，色即是空，空即是色。色不异空，空不异色，色即是空，空即是色。',
              msgType: MessageType.warning)),
      PageUtil.buildSubTitle('纯文本消息'),
      PageUtil.outlinedButton(
          '普通',
          () => Message.show('纯文本，不带icon',
              showIcon: false, msgType: MessageType.info)),
      PageUtil.outlinedButton(
          '成功',
          () => Message.show('纯文本，不带icon',
              showIcon: false, msgType: MessageType.success)),
      PageUtil.outlinedButton(
          '警示',
          () => Message.show('纯文本，不带icon',
              showIcon: false, msgType: MessageType.warning)),
      PageUtil.outlinedButton(
          '错误',
          () => Message.show('纯文本，不带icon',
              showIcon: false, msgType: MessageType.error)),
      PageUtil.outlinedButton(
          '超长警示',
          () => Message.show('诸法空相，不生不灭，不垢不净，不增不减。诸法空相，不生不灭，不垢不净，不增不减。',
              showIcon: false, msgType: MessageType.warning)),
      PageUtil.buildSubTitle('自定义配置'),
      PageUtil.outlinedButton(
          '自定义显示时间',
          () => Message.show('5000ms后消失',
              msgType: MessageType.info,
              duration: Duration(milliseconds: 5000))),
      PageUtil.buildSubTitle('对齐方式'),
      PageUtil.outlinedButton(
          '带图标居中',
          () => Message.show('居中',
              msgType: MessageType.info,
              msgAlignment: MessageAlignment.center)),
      PageUtil.outlinedButton(
          '带图标超长居中',
          () => Message.show('无眼耳鼻舌身，意无色声香味触法。无眼耳鼻舌身意，无色声香味触法。',
              msgType: MessageType.warning,
              msgAlignment: MessageAlignment.center)),
      PageUtil.outlinedButton(
          '纯文本居中',
          () => Message.show('居中',
              showIcon: false,
              msgType: MessageType.info,
              msgAlignment: MessageAlignment.center)),
      PageUtil.outlinedButton(
          '纯文本超长居中',
          () => Message.show('乃至无老死，亦无老死尽，无苦集灭道，无智亦无得。',
              showIcon: false,
              msgType: MessageType.warning,
              msgAlignment: MessageAlignment.center)),
    ]);
  }
}
