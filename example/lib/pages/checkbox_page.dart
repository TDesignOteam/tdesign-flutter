import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class CheckBoxPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CheckBoxPageState();
  }
}

class _CheckBoxPageState extends State<CheckBoxPage> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(), title: 'CheckBox');
  }

  Widget _widget() {
    return ListView(children: [
      _buildTile(
        CheckBox(
          name: '1.1',
          title: '单行标题',
          onChange: (selected, name) {
            setState(() {
              this.selected = selected;
            });
          },
        ),
      ),
      PageUtil.buildSubTitle('单行标题状态回调：${selected ? '选中' : '未选中'}'),
      Divider(height: 0),
      _buildTile(
        CheckBox(name: '1.2', title: '默认选中', defaultSelected: true),
      ),
      Divider(height: 0),
      _buildTile(
        CheckBox(
          name: '1.3',
          title: '多行标题，最大行数可以控制。\n这是一个标题行数限制在3行以内的选项，长文本自动换行，超出内容将被折叠成点点点点点点点点点点点点点点点。',
          defaultSelected: true,
          limitTitleRow: 3,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        CheckBox(
          name: '1.4',
          title: '单行标题',
          disabled: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        CheckBox(
          name: '1.5',
          title: '默认选中',
          defaultSelected: true,
          disabled: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        CheckBox(
          name: '1.6',
          title: '多行标题，最大行数可以控制。\n这是一个标题行数限制在3行以内的选项，长文本自动换行，超出内容将被折叠成点点点点点点点点点点点点点点点。',
          limitTitleRow: 3,
          defaultSelected: true,
          disabled: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        CheckBox(name: '1.7', title: '本行文字部分点击无效', contentDisabled: true),
      ),
      PageUtil.buildSubTitle('带辅助信息多选框'),
      _buildTile(
        CheckBox(
          name: '2.1',
          title: '单行标题',
          content: '我的思想随着这些闪耀的绿叶而闪耀；我的心灵因了这日光的抚触而歌唱；我的生命因为偕了万物一同浮泛在空间的蔚蓝，时间的墨黑而感到欢快。',
        ),
      ),
      Divider(height: 0),
      _buildTile(
        CheckBox(
          name: '2.2',
          title: '单行标题',
          limitContentRow: 5,
          content: '我的思想随着这些闪耀的绿叶而闪耀；我的心灵因了这日光的抚触而歌唱；我的生命因为偕了万物一同浮泛在空间的蔚蓝，时间的墨黑而感到欢快。',
          defaultSelected: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        CheckBox(
          name: '2.3',
          title: '单行标题',
          limitContentRow: 5,
          content: '我的思想随着这些闪耀的绿叶而闪耀；我的心灵因了这日光的抚触而歌唱；我的生命因为偕了万物一同浮泛在空间的蔚蓝，时间的墨黑而感到欢快。',
          defaultSelected: true,
          disabled: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        CheckBox(
          name: '2.4',
          title: '标题和内容都可以很长，会自动换行，可以给定最大行数限制，默认的行数都是1。超出行数的部分会被折叠。',
          limitTitleRow: 5,
          limitContentRow: 5,
          content: '我们的生命就似渡过一个大海，我们都相聚在这个狭小的舟中。死时，我们便到了岸，各往各的世界去了。',
          defaultSelected: true,
          disabled: true,
        ),
      ),
      _buildTile(
        CheckBox(
          name: '2.4',
          title: '标题和内容都可以很长，会自动换行，可以给定最大行数限制，默认的行数都是1。超出行数的部分会被折叠。',
          content: '我们的生命就似渡过一个大海，我们都相聚在这个狭小的舟中。死时，我们便到了岸，各往各的世界去了。',
          defaultSelected: true,
        ),
      ),
      Divider(height: 0),
      PageUtil.buildSubTitle('自定义图标和颜色'),
      _buildTile(
        CheckBox(
          name: '3.1',
          checkedColor: TDColors.green,
          title: '自定义颜色',
          defaultSelected: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        CheckBox(
          name: '3.1',
          selectedIcon: Icon(TDIcons.notificationFilled, color: TDColors.blue),
          unselectedIcon: Icon(TDIcons.notification),
          title: '自定义图标',
        ),
      ),
    ]);
  }

  Widget _buildTile(Widget child) {
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
