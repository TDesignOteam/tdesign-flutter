import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class ButtonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ButtonPageState();
  }
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      child: _widget(context),
      title: 'Button',
    );
  }

  Widget _widget(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            PageUtil.buildTitle('01 类型'),
            PageUtil.buildSubTitle('02 基础按钮'),
            _buildContent(TDButton(
              onClick: () {},
              text: '强按钮',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.stroke,
              onClick: () {},
              text: '弱按钮',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.secondary,
              onClick: () {},
              text: '次按钮',
            )),
            _buildContent(TDButton(
              icon: Icon(Icons.android, color: TDColors.blue),
              style: TDButtonStyle.stroke,
              onClick: () {},
              text: '带图标按钮',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.warn,
              onClick: () {},
              text: '强告警按钮',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.warnStroke,
              onClick: () {},
              text: '弱告警按钮',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.ghost,
              onClick: () {},
              text: '幽灵按钮',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.text,
              onClick: () {},
              text: '文字按钮',
            )),
            _buildContent(TDButton(
              onClick: () {},
              text: '通栏按钮',
              radius: BorderRadius.zero,
            )),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TDButton(
                    style: TDButtonStyle.text,
                    onClick: () {},
                    text: '次按钮',
                    radius: BorderRadius.zero,
                  ),
                ),
                Expanded(
                  child: TDButton(
                    onClick: () {},
                    text: '主按钮',
                    radius: BorderRadius.zero,
                  ),
                ),
              ],
            )
          ]),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            PageUtil.buildSubTitle('02 状态'),
            _buildContent(TDButton(
              text: '强按钮-禁用',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.stroke,
              text: '弱按钮-禁用',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.secondary,
              text: '次按钮',
            )),
            _buildContent(TDButton(
              icon: Icon(Icons.android, color: TDColors.blue.shade3),
              style: TDButtonStyle.stroke,
              text: '带图标按钮',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.warn,
              text: '强告警按钮',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.warnStroke,
              text: '弱告警按钮',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.ghost,
              text: '幽灵按钮',
            )),
            _buildContent(TDButton(
              style: TDButtonStyle.text,
              text: '文字按钮',
            )),
            _buildContent(TDButton(
              text: '通栏按钮',
              radius: BorderRadius.zero,
            )),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TDButton(
                    style: TDButtonStyle.text,
                    text: '次按钮',
                    radius: BorderRadius.zero,
                  ),
                ),
                Expanded(
                  child: TDButton(
                    text: '主按钮',
                    radius: BorderRadius.zero,
                  ),
                ),
              ],
            ),
            PageUtil.buildSubTitle('03 规格'),
            PageUtil.buildSubTitle('文字按钮尺寸'),
            _buildContent(TDButton(
              size: TDButtonSize.large,
              onClick: () {},
              text: '按钮 44',
            )),
            _buildContent(TDButton(
              size: TDButtonSize.mid,
              onClick: () {},
              text: '按钮 40',
            )),
            _buildContent(TDButton(
              size: TDButtonSize.small,
              onClick: () {},
              text: '按钮 46',
            )),
            _buildContent(TDButton(
              size: TDButtonSize.tint,
              onClick: () {},
              text: '按钮 28',
            ))
          ],
        )
      ],
    ));
  }

  Widget _buildContent(Widget child) {
    return Padding(padding: EdgeInsets.all(10), child: child);
  }
}
