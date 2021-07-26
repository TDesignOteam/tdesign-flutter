import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class NoticeBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoticeBarPageState();
}

class _NoticeBarPageState extends State<NoticeBarPage> {
  var _visible = [true, true, true];
  final _text = <String, String>{
    '饮酒': '采菊东篱下，悠然见南山。',
    '春夜喜雨': '随风潜入夜，润物细无声。',
    '春晓': '春眠不觉晓，处处闻啼鸟。\n夜来风雨声，花落知多少。',
    '静夜思': '床前明月光，疑是地上霜。\n举头望明月，低头思故乡。',
    '锦瑟': '锦瑟无端五十弦，一弦一柱思华年。  庄生晓梦迷蝴蝶，望帝春心托杜鹃。  '
        '沧海月明珠有泪，蓝田日暖玉生烟。  此情可待成追忆，只是当时已惘然。',
    '酬乐天扬州初逢席上见赠': '巴山楚水凄凉地，二十三年弃置身。  怀旧空吟闻笛赋，到乡翻似烂柯人。  '
        '沉舟侧畔千帆过，病树前头万木春。  今日听君歌一曲，暂凭杯酒长精神。',
  };

  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(), title: 'NoticeBar');
  }

  Widget _widget() {
    return ListView(children: [
      PageUtil.buildSubTitle('静态消息栏', height: 50),
      ..._buildStaticBar(),
      PageUtil.buildSubTitle('带图标静态消息栏', height: 50),
      ..._buildStaticIconBar(),
      PageUtil.buildSubTitle('带操作消息栏', height: 50),
      ..._buildActionBar(),
      PageUtil.buildSubTitle('滚动消息栏', height: 50),
      ..._buildScrollableBar(),
    ]);
  }

  List<Widget> _buildStaticBar() {
    return <Widget>[
      TDNoticeBar(text: _text['饮酒']!, mode: TDNoticeBarMode.text),
      _buildDivider(),
      TDNoticeBar(text: _text['锦瑟']!, mode: TDNoticeBarMode.text),
      _buildDivider(),
      TDNoticeBar(text: _text['饮酒']!, mode: TDNoticeBarMode.text, type: TDNoticeBarType.error),
      _buildDivider(),
      TDNoticeBar(text: _text['锦瑟']!, mode: TDNoticeBarMode.text, type: TDNoticeBarType.error),
    ];
  }

  List<Widget> _buildStaticIconBar() {
    return <Widget>[
      TDNoticeBar(text: _text['春夜喜雨']!),
      _buildDivider(),
      TDNoticeBar(text: _text['酬乐天扬州初逢席上见赠']!),
      _buildDivider(),
      TDNoticeBar(text: _text['春夜喜雨']!, type: TDNoticeBarType.error),
      _buildDivider(),
      TDNoticeBar(text: _text['酬乐天扬州初逢席上见赠']!, type: TDNoticeBarType.error),
    ];
  }

  List<Widget> _buildActionBar() {
    return <Widget>[
      TDNoticeBar(
          text: '《静夜思》的作者是谁？',
          mode: TDNoticeBarMode.link,
          onLink: () {
            TDToast.toast('[唐] 李白');
          }),
      _buildDivider(),
      TDNoticeBar(
          text: '《过零丁洋》的作者是谁？',
          mode: TDNoticeBarMode.link,
          type: TDNoticeBarType.error,
          onLink: () {
            TDToast.toast('[宋] 文天祥');
          }),
      _buildDivider(),
      TDNoticeBar(
        text: '《春晓》',
        detailText: '全文',
        onDetail: () {
          tdDialogBase.showCenterDialog(
            dialog: TDAlertDialog(title: '春晓   孟浩然', describe: _text['春晓']),
            context: context,
          );
        },
      ),
      _buildDivider(visible: _visible[0]),
      TDNoticeBar(
        text: _text['饮酒']!,
        mode: TDNoticeBarMode.closeable,
        type: TDNoticeBarType.error,
        onClose: () => _onClose(0),
      ),
      _buildDivider(visible: _visible[1]),
      TDNoticeBar(
        text: '《静夜思》',
        mode: TDNoticeBarMode.closeable,
        detailText: '全文',
        onClose: () => _onClose(1),
        onDetail: () {
          tdDialogBase.showCenterDialog(
            dialog: TDAlertDialog(title: '静夜思   李白', describe: _text['静夜思']),
            context: context,
          );
        },
      ),
    ];
  }

  List<Widget> _buildScrollableBar() {
    return <Widget>[
      TDNoticeBar(
        text: _text['锦瑟']!,
        mode: TDNoticeBarMode.closeable,
        scrollable: true,
        onClose: () => _onClose(2),
      ),
      _buildDivider(visible: _visible[2]),
      TDNoticeBar(
        text: _text['酬乐天扬州初逢席上见赠']!,
        mode: TDNoticeBarMode.closeable,
        type: TDNoticeBarType.error,
        speed: 80,
        scrollable: true,
        onClose: () => _onClose(2),
      ),
    ];
  }

  Widget _buildDivider({double height = 15, bool visible = true}) {
    return Visibility(
        visible: visible,
        child: Container(
          height: height,
          child: Row(),
        ));
  }

  _onClose(int i) {
    TDToast.toast('你关闭了这个消息栏');
    setState(() => _visible[i] = false);
  }
}
