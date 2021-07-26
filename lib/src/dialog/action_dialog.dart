//  Created by jamsun, 22Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/src/button/button_base.dart';
import 'package:tdesign/src/button/dialog_text_button.dart';
import 'package:tdesign/src/dialog/dialog_util.dart';
import 'package:tdesign/tdesign.dart';

import 'dialog_body.dart';

typedef OnItemClick = void Function(int index);
typedef OnCancelClick = void Function();

class TDActionDialog extends StatelessWidget {
  final List<String> list;
  final String? cancel;
  final String? title;
  final String? describe;
  final OnItemClick onItemClick;
  final OnCancelClick? onCancelClick;

  TDActionDialog(
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
      childList.add(TDDialogBody(title: title!, describe: describe));
      childList.add(Divider(height: 1, color: tdDialogBase.divideColor(context)));
    }
    //增加item和取消  带下分割线
    var index = 0;
    list.forEach((element) {
      var currentIndex = index;
      childList.add(Row(
        children: [
          Expanded(
              child: TDDialogTextButton(
            size: TDButtonSize.large,
            onClick: () {
              onItemClick(currentIndex);
            },
            text: element,
            padding: tdButtonBase.getDialogEdgeBySize(),
          ))
        ],
      ));
      childList.add(Divider(height: 1, color: tdDialogBase.divideColor(context)));
      index++;
    });
    //添加取消
    childList.add(Row(
      children: [
        Expanded(
            child: TDDialogTextButton(
          size: TDButtonSize.large,
          onClick: () {
            if (onCancelClick != null) {
              onCancelClick!();
            } else {
              Navigator.pop(context);
            }
          },
          text: cancel ?? '取消',
          textStyle: tdDialogBase.dialogTitle(context),
          padding: tdButtonBase.getDialogEdgeBySize(),
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
