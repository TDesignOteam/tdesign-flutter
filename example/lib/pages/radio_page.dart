import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class RadioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(context), title: 'Radio');
  }

  Widget _widget(BuildContext context) {
    TDTheme? _theme = TDTheme.of(context);
    return ListView(children: [
      PageUtil.buildSubTitle('单选群组-标题'),
      _buildTile(
        RadioGroup(
          options: [
            GroupOption(name: '选项1', title: '单行标题'),
            GroupOption(name: '选项2', title: '单行标题'),
            GroupOption(name: '选项3', title: '多行标题，最大行数可以控制，长文本自动换行，超出内容将被折叠成点点点点点点点点点点点点点点点。'),
          ],
          limitTitleRow: 2,
          defaultSelectedName: '选项1',
          separatorWidget: Divider(height: 10),
        ),
        context,
      ),
      PageUtil.buildSubTitle('单选群组-无分割'),
      _buildTile(
        RadioGroup(
          options: [
            GroupOption(name: '选项1', title: '分割组件可以自定义'),
            GroupOption(name: '选项2', title: '本组未传入'),
            GroupOption(name: '选项3', title: '其他组传入了默认Divider'),
          ],
          limitTitleRow: 2,
          defaultSelectedName: '选项1',
        ),
        context,
      ),
      PageUtil.buildSubTitle('单选群组-标题-不可选'),
      _buildTile(
        RadioGroup(
          options: [
            GroupOption(name: '选项1', title: '单行标题', disabled: true),
            GroupOption(name: '选项2', title: '单行标题', disabled: true),
            GroupOption(name: '选项3', title: '多行标题，最大行数可以控制，长文本自动换行，超出内容将被折叠成点点点点点点点点点点点点点点点。', disabled: true),
          ],
          limitTitleRow: 2,
          defaultSelectedName: '选项1',
          separatorWidget: Divider(height: 10),
        ),
        context,
      ),
      PageUtil.buildSubTitle('单选群组-标题-文本-可选'),
      _buildTile(
        RadioGroup(
          options: [
            GroupOption(
              name: '选项1',
              title: '单行标题',
              content: '我的思想随着这些闪耀的绿叶而闪耀；我的心灵因了这日光的抚触而歌唱；我的生命因为偕了万物一同浮泛在空间的蔚蓝，时间的墨黑而感到欢快。',
            ),
            GroupOption(
              name: '选项2',
              title: '单行标题',
              content: '一段很长很长的内容文字，一段很长很长的内容文字，一段很长很长的内容文字。',
            ),
            GroupOption(
                name: '选项3', title: '多行标题，最大行数可以控制，长文本自动换行，超出内容将被折叠成点点点点点点点点点点点点点点点。', content: '最大行数也可以控制，这里目前是2行。'),
          ],
          limitTitleRow: 2,
          limitContentRow: 2,
          defaultSelectedName: '选项1',
          separatorWidget: Divider(),
        ),
        context,
      ),
      PageUtil.buildSubTitle('单选群组-标题-文本-部分不可选'),
      _buildTile(
        RadioGroup(
          options: [
            GroupOption(name: '选项1', title: '单行标题'),
            GroupOption(name: '选项2', title: '单行标题', disabled: true),
            GroupOption(name: '选项3', title: '多行标题，最大行数可以控制，长文本自动换行，超出内容将被折叠成点点点点点点点点点点点点点点点。'),
          ],
          limitTitleRow: 2,
          defaultSelectedName: '选项1',
          separatorWidget: Divider(height: 10),
        ),
        context,
      ),
      PageUtil.buildSubTitle('单选群组-替换颜色'),
      _buildTile(
        RadioGroup(
          options: [
            GroupOption(name: '1', title: '选中Icon颜色可传入'),
            GroupOption(name: '2', title: 'TDTheme中的主色'),
          ],
          checkedColor: TDColors.orange,
          defaultSelectedName: '1',
          separatorWidget: Divider(height: 10),
        ),
        context,
      ),
      PageUtil.buildSubTitle('单选群组-替换Icon'),
      _buildTile(
        RadioGroup(
          options: [
            GroupOption(name: '1', title: '单行标题'),
            GroupOption(name: '2', title: '单行标题'),
          ],
          defaultSelectedName: '1',
          selectedIconBuilder: (_) => Icon(TDIcons.heartFilled, color: TDColors.green, size: _theme?.themeData.iconX),
          unselectedIconBuilder: (_) => Icon(TDIcons.heart, size: _theme?.themeData.iconX),
          separatorWidget: Divider(height: 10),
        ),
        context,
      ),
      PageUtil.buildSubTitle('单选群组-文本部分不可点击'),
      _buildTile(
        RadioGroup(
          options: [
            GroupOption(name: '1', title: '单行标题', content: '本组文本部分点击无效'),
            GroupOption(name: '2', title: '单行标题', content: '只有点击Icon才有效'),
          ],
          defaultSelectedName: '2',
          contentDisabled: true,
          separatorWidget: Divider(height: 10),
        ),
        context,
      ),
    ]);
  }

  Widget _buildTile(Widget child, BuildContext context) {
    return PageUtil.buildTile(
      context,
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: child,
      ),
      alignment: Alignment.center,
    );
  }
}
