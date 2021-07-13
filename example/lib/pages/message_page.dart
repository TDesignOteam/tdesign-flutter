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
      backgroundColor: Colors.white,
      titleColor: Colors.black,
    );
  }

  Widget _widget() {
    return ListView(children: [
      PageUtil.buildSubTitle('带图标消息通知'),
      PageUtil.outlinedButton('普通', () => TDMessage.show('普通消息', msgType: TDMessageType.info)),
      PageUtil.outlinedButton('成功', () => TDMessage.show('成功消息', msgType: TDMessageType.success)),
      PageUtil.outlinedButton('警示', () => TDMessage.show('警示消息', msgType: TDMessageType.warning)),
      PageUtil.outlinedButton('错误', () => TDMessage.show('错误消息', msgType: TDMessageType.error)),
      PageUtil.outlinedButton(
          '超长警示', () => TDMessage.show('色不异空，空不异色，色即是空，空即是色。色不异空，空不异色，色即是空，空即是色。', msgType: TDMessageType.warning)),
      PageUtil.buildSubTitle('纯文本消息'),
      PageUtil.outlinedButton('普通', () => TDMessage.show('纯文本，不带icon', showIcon: false, msgType: TDMessageType.info)),
      PageUtil.outlinedButton(
          '成功', () => TDMessage.show('纯文本，不带icon', showIcon: false, msgType: TDMessageType.success)),
      PageUtil.outlinedButton(
          '警示', () => TDMessage.show('纯文本，不带icon', showIcon: false, msgType: TDMessageType.warning)),
      PageUtil.outlinedButton('错误', () => TDMessage.show('纯文本，不带icon', showIcon: false, msgType: TDMessageType.error)),
      PageUtil.outlinedButton(
          '超长警示',
          () => TDMessage.show('诸法空相，不生不灭，不垢不净，不增不减。诸法空相，不生不灭，不垢不净，不增不减。',
              showIcon: false, msgType: TDMessageType.warning)),
      PageUtil.buildSubTitle('自定义配置'),
      PageUtil.outlinedButton('自定义显示时间',
          () => TDMessage.show('5000ms后消失', msgType: TDMessageType.info, duration: Duration(milliseconds: 5000))),
      PageUtil.buildSubTitle('对齐方式'),
      PageUtil.outlinedButton(
          '带图标居中', () => TDMessage.show('居中', msgType: TDMessageType.info, msgAlignment: TDMessageAlignment.center)),
      PageUtil.outlinedButton(
          '带图标超长居中',
          () => TDMessage.show('无眼耳鼻舌身，意无色声香味触法。无眼耳鼻舌身意，无色声香味触法。',
              msgType: TDMessageType.warning, msgAlignment: TDMessageAlignment.center)),
      PageUtil.outlinedButton(
          '纯文本居中',
          () => TDMessage.show('居中',
              showIcon: false, msgType: TDMessageType.info, msgAlignment: TDMessageAlignment.center)),
      PageUtil.outlinedButton(
          '纯文本超长居中',
          () => TDMessage.show('乃至无老死，亦无老死尽，无苦集灭道，无智亦无得。',
              showIcon: false, msgType: TDMessageType.warning, msgAlignment: TDMessageAlignment.center)),
    ]);
  }
}
