//  Created by jamsun, 22Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/src/button/button_base.dart';
import 'package:tdesign/src/button/dialog_text_button.dart';

import 'dialog_body.dart';

class TDAlertDialog extends StatelessWidget with WidgetsBindingObserver {
  final String? confirmText;
  final String title;
  final String? describe;
  final VoidCallback? onConfirm;

  TDAlertDialog({this.confirmText, required this.title, this.describe, this.onConfirm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TDDialogBody(title: title, describe: describe),
          TDDialogTextButton(
              padding: tdButtonBase.getDialogEdgeBySize(),
              size: TDButtonSize.large,
              onClick: () {
                if (onConfirm != null) {
                  onConfirm!();
                } else {
                  Navigator.pop(context);
                }
              },
              text: '知道了'),
        ],
      ),
    );
  }
}
