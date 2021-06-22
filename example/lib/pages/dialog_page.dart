import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/src/dialog/confirm_dialog.dart';
import 'package:tdesign/src/dialog/dialog_util.dart';
import 'package:tdesign/src/dialog/edit_dialog.dart';
import 'package:tdesign/src/dialog/list_dialog.dart';
import 'package:tdesign/src/dialog/whether_dialog.dart';

import '../main.dart';

class DialogPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  final List<ListItem<dynamic>> list = [
    ListItem('普通确认弹窗', (context) {
      tdDialogBase.showCenterDialog(
          dialog: TDConfirmDialog(
            title: '对话框标题',
            confirmText: '知道了',
          ),
          context: context);
    }),
    ListItem('普通确认弹窗-标题比较长', (context) {
      tdDialogBase.showCenterDialog(
          dialog: TDConfirmDialog(
            title: '对话框标题告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
            confirmText: '知道了',
          ),
          context: context);
    }),
    ListItem('普通确认弹窗-短标题短内容', (context) {
      tdDialogBase.showCenterDialog(
          dialog: TDConfirmDialog(
            title: '对话框标题',
            describe: '告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
            confirmText: '知道了',
          ),
          context: context);
    }),
    ListItem('普通确认弹窗-短标题长内容', (context) {
      tdDialogBase.showCenterDialog(
          dialog: TDConfirmDialog(
            title: '对话框标题',
            describe: '告知当前状态、信息和解决方法。告知当前状态、信息和解决方法。告知当前状态、信息和'
                '解决方法。告知当前状态、信息和解决方法。告知当前状态、信息和解决方法。告知当'
                '前状态、信息和解决方法。告知当前状态、信息和解决方法。告知当前状态、信息和解'
                '决方法。告知当前状态、信息和解决方法。告知当前状态、信息和解决方'
                '解决方法。告知当前状态、信息和解决方法。告知当前状态、信息和解决方法。告知当'
                '前状态、信息和解决方法。告知当前状态、信息和解决方法。告知当前状态、信息和解'
                '决方法。告知当前状态、信息和解决方法。告知当前状态、信息和解决方'
                '解决方法。告知当前状态、信息和解决方法。告知当前状态、信息和解决方法。告知当'
                '前状态、信息和解决方法。告知当前状态、信息和解决方法。告知当前状态、信息和解'
                '决方法。告知当前状态、信息和解决方法。告知当前状态、信息和解决方'
                '法。告知当前状态、信息和解决方法。告知当前状态、信息和解决方法。告知当前状态、信息和解决方法。',
            confirmText: '知道了',
          ),
          context: context);
    }),
    ListItem('普通确认是否弹窗-短标题长内容', (context) {
      tdDialogBase.showCenterDialog(
          dialog: TDWhetherDialog(
            title: '对话框标题',
            describe: '告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
            confirm: '知道了',
            cancel: '我是取消',
          ),
          context: context);
    }),
    ListItem('普通确认是否弹窗-警告的取消按钮', (context) {
      tdDialogBase.showCenterDialog(
          dialog: TDWhetherDialog(
            primary: false,
            title: '对话框标题',
            describe: '告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
            confirm: '辅助色',
            cancel: '我是取消',
          ),
          context: context);
    }),
    ListItem('列表弹窗-警告的取消按钮', (context) {
      tdDialogBase.showCenterDialog(
          dialog: TDListDialog(
            list: ['按钮文案文字内容较长', '单行按钮最多十五个字符文案内容'],
            onItemClick: (index) {
              print('jam~~~$index');
            },
            title: '对话框标题',
            describe: '告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
          ),
          context: context);
    }),
    ListItem('列表弹窗-没有标题和内容', (context) {
      tdDialogBase.showCenterDialog(
          dialog: TDListDialog(
            list: ['按钮文案文字内容较长', '单行按钮最多十五个字符文案内容'],
            onItemClick: (index) {},
          ),
          context: context);
    }),
    ListItem('输入框弹窗', (context) {
      tdDialogBase
          .showCenterDialog(
              dialog: TDEditDialog(
                title: '对话框标题',
                onWhetherClick: (yes, payload) {
                  print('jam bool $yes');
                  print('jam payload $payload');
                  Navigator.pop(context);
                },
              ),
              context: context)
          .then((value) {});
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('短标题无内容弹窗测试'),
      ),
      body: SafeArea(
          child: ListView.builder(
        padding: EdgeInsets.only(top: 5),
        itemCount: list.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          color: list[index].isSelected
              ? Colors.red[100]
              : Theme.of(context).dialogBackgroundColor,
          child: TextButton(
            onPressed: () {
              ListItem item = this.list[index];
              item.action(context);
            },
            child: ListTile(
              title: Text(list[index].data),
            ),
          ),
        ),
      )),
    );
  }
}
// TButton(
//     text: '输入框的弹窗',
//     onClick: () {
//       TDialogUtil.showCenterDialog(
//           dialog: TEditDialog(
//             title: '对话框标题',
//             onWhetherClick: (yes, payload) {
//               print('jam bool $yes');
//               print('jam payload $payload');
//               Navigator.pop(context);
//             },
//           ),
//           context: context)
//           .then((value) {});
//     })
