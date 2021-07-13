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
  List<String> selectedInGroup = [];
  TDCheckGroupController controller = TDCheckGroupController();

  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(), title: 'CheckBox');
  }

  Widget _widget() {
    return ListView(children: [
      _buildTile(
        TDCheckBox(
          name: '1.1',
          title: '单行标题',
          onChange: (selected, name) {
            setState(() {
              this.selected = selected;
            });
          },
        ),
      ),
      _buildTile(Text(
        '单行标题状态：${selected ? '选中' : '未选中'}',
        style: TextStyle(color: Colors.grey),
      )),
      Divider(height: 0),
      _buildTile(
        TDCheckBox(name: '1.2', title: '默认选中', defaultSelected: true),
      ),
      Divider(height: 0),
      _buildTile(
        TDCheckBox(
          name: '1.3',
          title: '多行标题，最大行数可以控制。\n这是一个标题行数限制在3行以内的选项，长文本自动换行，超出内容将被折叠成点点点点点点点点点点点点点点点。',
          defaultSelected: true,
          limitTitleRow: 3,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        TDCheckBox(
          name: '1.4',
          title: '单行标题',
          disabled: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        TDCheckBox(
          name: '1.5',
          title: '默认选中',
          defaultSelected: true,
          disabled: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        TDCheckBox(
          name: '1.6',
          title: '多行标题，最大行数可以控制。\n这是一个标题行数限制在3行以内的选项，长文本自动换行，超出内容将被折叠成点点点点点点点点点点点点点点点。',
          limitTitleRow: 3,
          defaultSelected: true,
          disabled: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        TDCheckBox(name: '1.7', title: '本行文字部分点击无效', contentDisabled: true),
      ),
      PageUtil.buildSubTitle('自定义图标和颜色'),
      _buildTile(
        TDCheckBox(
          name: '2.1',
          checkedColor: TDColors.green,
          title: '自定义颜色',
          defaultSelected: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        TDCheckBox(
          name: '2.2',
          selectedIconBuilder: (_) => Icon(TDIcons.notificationFilled, color: TDColors.blue),
          unselectedIconBuilder: (_) => Icon(TDIcons.notification),
          title: '自定义图标',
        ),
      ),
      PageUtil.buildSubTitle('带辅助信息多选框'),
      _buildTile(
        TDCheckBox(
          name: '3.1',
          title: '单行标题',
          content: '我的思想随着这些闪耀的绿叶而闪耀；我的心灵因了这日光的抚触而歌唱；我的生命因为偕了万物一同浮泛在空间的蔚蓝，时间的墨黑而感到欢快。',
        ),
      ),
      Divider(height: 0),
      _buildTile(
        TDCheckBox(
          name: '3.2',
          title: '单行标题',
          limitContentRow: 5,
          content: '我的思想随着这些闪耀的绿叶而闪耀；我的心灵因了这日光的抚触而歌唱；我的生命因为偕了万物一同浮泛在空间的蔚蓝，时间的墨黑而感到欢快。',
          defaultSelected: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        TDCheckBox(
          name: '3.3',
          title: '单行标题',
          limitContentRow: 5,
          content: '我的思想随着这些闪耀的绿叶而闪耀；我的心灵因了这日光的抚触而歌唱；我的生命因为偕了万物一同浮泛在空间的蔚蓝，时间的墨黑而感到欢快。',
          defaultSelected: true,
          disabled: true,
        ),
      ),
      Divider(height: 0),
      _buildTile(
        TDCheckBox(
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
        TDCheckBox(
          name: '2.4',
          title: '标题和内容都可以很长，会自动换行，可以给定最大行数限制，默认的行数都是1。超出行数的部分会被折叠。',
          content: '我们的生命就似渡过一个大海，我们都相聚在这个狭小的舟中。死时，我们便到了岸，各往各的世界去了。',
          defaultSelected: true,
        ),
      ),
      PageUtil.buildSubTitle('选项框群组 - 最多选两项'),
      _buildTile(TDCheckGroup(
          options: [
            TDGroupOption(name: '选项一', title: '选项一'),
            TDGroupOption(name: '选项二', title: '选项二'),
            TDGroupOption(name: '选项三', title: '选项三'),
          ],
          selectLimit: 2,
          onChange: (selected) {
            setState(() {
              selectedInGroup = selected;
            });
          })),
      _buildTile(Text(
        '已选选项：$selectedInGroup',
        style: TextStyle(color: Colors.grey),
      )),
      PageUtil.buildSubTitle('选项框群组 - 控制'),
      _buildTile(TDCheckGroup(
        options: [
          TDGroupOption(name: '1', title: '选项一', content: '使用controller从外部控制选项。'),
          TDGroupOption(name: '2', title: '选项二', content: '控制包括：选择、取消、反选单个选项，选择、取消、反选全部选项'),
          TDGroupOption(name: '3', title: '选项三', content: '还可以传入自定义分割Widget。'),
          TDGroupOption(name: '4', title: '选项四'),
        ],
        limitContentRow: 3,
        defaultSelected: [true, false, true, false],
        controller: controller,
        separatorWidget: Divider(height: 10),
      )),
      Row(
        children: [
          PageUtil.outlinedButton('全选', () => controller.toggleAll(checked: true)),
          PageUtil.outlinedButton('取消', () => controller.toggleAll(checked: false)),
          PageUtil.outlinedButton('反选', () => controller.toggleAll()),
        ],
      ),
      Row(
        children: [
          PageUtil.outlinedButton('选择选项三', () => controller.check('3')),
          PageUtil.outlinedButton('取消选项三', () => controller.uncheck('3')),
        ],
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
