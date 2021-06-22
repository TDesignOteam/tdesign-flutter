import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/src/button/button_base.dart';
import 'package:tdesign/src/button/text_button.dart';
import 'package:tdesign/src/dialog/dialog_util.dart';
import 'package:tdesign/tdesign.dart';

import 'dialog_body.dart';

typedef OnItemClick = void Function(int index);
typedef OnCancelClick = void Function();

class TDListDialog extends StatelessWidget {
  final List<String> list;
  final String? cancel;
  final String? title;
  final String? describe;
  final OnItemClick onItemClick;
  final OnCancelClick? onCancelClick;

  TDListDialog(
      {required this.list,
      this.title,
      this.cancel,
      this.describe,
      required this.onItemClick,
      this.onCancelClick,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var childList = <Widget>[];
    if (title != null) {
      childList.add(TDialogBody(title: title!, describe: describe));
      childList.add(Divider(height: 1, color: TDTheme.divideColor));
    }
    //增加item和取消  带下分割线
    var index = 0;
    list.forEach((element) {
      var currentIndex = index;
      childList.add(Row(
        children: [
          Expanded(
              child: TTextButton(
            size: TButtonSize.large,
            onClick: () {
              onItemClick(currentIndex);
            },
            text: element,
          ))
        ],
      ));
      childList.add(Divider(height: 1, color: TDTheme.divideColor));
      index++;
    });
    //添加取消
    childList.add(Row(
      children: [
        Expanded(
            child: TTextButton(
          size: TButtonSize.large,
          onClick: () {
            if (onCancelClick != null) {
              onCancelClick!();
            } else {
              Navigator.pop(context);
            }
          },
          text: cancel ?? '取消',
          textStyle: tdDialogBase.dialogTitle,
        ))
      ],
    ));
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: childList,
      ),
    );
  }
}
