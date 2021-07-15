//  Created by jamsun, 22Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:tdesign/src/button/button_base.dart';
import 'package:tdesign/src/button/text_button.dart';
import 'package:tdesign/src/dialog/dialog_util.dart';
import 'package:tdesign/theme/td_text_style.dart';

import '../../tdesign.dart';
import 'dialog_body.dart';

typedef OnWhetherClick = void Function(bool yes, String? payload);

class TDConfirmDialog extends StatelessWidget {
  final String? confirm;
  final String? cancel;
  final String title;
  final String? describe;
  final bool? primary;
  final OnWhetherClick? onWhetherClick;

  TDConfirmDialog(
      {this.confirm, required this.title, this.cancel, this.primary, this.describe, this.onWhetherClick, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TDDialogBody(title: title, describe: describe),
          Row(
            children: [
              //取消按钮
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: tdDialogBase.divideColor(context), width: 1, style: BorderStyle.solid))),
                  child: TDTextButton(
                    size: TButtonSize.large,
                    onClick: () {
                      if (onWhetherClick != null) {
                        onWhetherClick!(false, null);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    text: cancel ?? '取消',
                    textStyle: tdDialogBase.dialogTitle(context),
                  ),
                ),
              ),
              Expanded(
                child: TDTextButton(
                    size: TButtonSize.large,
                    onClick: () {
                      if (onWhetherClick != null) {
                        onWhetherClick!(true, null);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    text: confirm ?? '确认',
                    textStyle: primary ?? true ? tdTextStyle.m16Primary(context) : tdTextStyle.m16Error(context)),
              ),
              //确认
            ],
          )
        ],
      ),
    );
  }
}
