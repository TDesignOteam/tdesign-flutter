import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class DialogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DialogPageState();
  }
}

class _DialogPageState extends State<DialogPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      child: _widget(context),
      title: 'Dialog',
    );
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

  Widget _widget(BuildContext context) {
    return ListView(children: [
      PageUtil.buildSubTitle('反馈类对话框'),
      _outlinedButton('单行标题', () {
        tdDialogBase.showCenterDialog(
            dialog: TDAlertDialog(
              title: '对话框标题',
              confirmText: '知道了',
            ),
            context: context);
      }),
      _outlinedButton('多行标题最大高度', () {
        tdDialogBase.showCenterDialog(
            dialog: TDAlertDialog(
              title: '对话框标题告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
              confirmText: '知道了',
            ),
            context: context);
      }),
      _outlinedButton('带说明文本', () {
        tdDialogBase.showCenterDialog(
            dialog: TDAlertDialog(
              title: '对话框标题',
              describe: '告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
              confirmText: '知道了',
            ),
            context: context);
      }),
      _outlinedButton('带说明文本最大高度', () {
        tdDialogBase.showCenterDialog(
            dialog: TDAlertDialog(
              title: '对话框带文本最大高度',
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
      PageUtil.buildSubTitle('确认类对话框'),
      _outlinedButton('双按钮', () {
        tdDialogBase.showCenterDialog(
            dialog: TDConfirmDialog(
              title: '对话框标题',
              describe: '告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
              confirm: '按钮最多字数',
              cancel: '取消',
            ),
            context: context);
      }),
      _outlinedButton('带警示按钮', () {
        tdDialogBase.showCenterDialog(
            dialog: TDConfirmDialog(
              primary: false,
              title: '对话框标题',
              // describe: '告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
              confirm: '警示操作',
              cancel: '取消',
            ),
            context: context);
      }),
      _outlinedButton('双按钮文字过长', () {
        tdDialogBase.showCenterDialog(
            dialog: TDActionDialog(
              list: ['按钮文案文字内容较长'],
              onItemClick: (index) {
                print('jam~~~$index');
              },
              title: '对话框标题',
              describe: '告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
            ),
            context: context);
      }),
      _outlinedButton('多按钮', () {
        tdDialogBase.showCenterDialog(
            dialog: TDActionDialog(
              list: ['按钮文案文字内容较长', '单行按钮最多十五个字符文案内容'],
              onItemClick: (index) {
                print('jam~~~$index');
              },
              title: '对话框标题',
              describe: '告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
            ),
            context: context);
      }),
      PageUtil.buildSubTitle('输入类对话框'),
      _outlinedButton('单行标题', () {
        tdDialogBase
            .showCenterDialog(
                dialog: TDInputDialog(
                  title: '带输入框对话框',
                  onWhetherClick: (yes, payload) {
                    print('jam bool $yes');
                    print('jam payload $payload');
                    Navigator.pop(context);
                  },
                ),
                context: context)
            .then((value) {});
      }),
      _outlinedButton('带说明文本', () {
        tdDialogBase
            .showCenterDialog(
                dialog: TDInputDialog(
                  title: '带输入框对话框',
                  describe: '告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
                  onWhetherClick: (yes, payload) {
                    print('jam bool $yes');
                    print('jam payload $payload');
                    Navigator.pop(context);
                  },
                ),
                context: context)
            .then((value) {});
      }),
    ]);
  }
}
