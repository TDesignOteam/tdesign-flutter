//  Created by jamsun, 22Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign/tdesign.dart';

TDDialogBase tdDialogBase = TDDialogBase.instance;

class TDDialogBase {
  factory TDDialogBase() => _instance;
  static TDDialogBase get instance => _instance;
  static TDDialogBase _instance = TDDialogBase._internal();
  TDDialogBase._internal();

  Future showCenterDialog(
      {required Widget dialog, required BuildContext context}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            clipBehavior: Clip.antiAlias,
            content: dialog,
            contentPadding: EdgeInsets.all(0.0)));
  }

  TextStyle get dialogTitle =>
      TextStyle(color: TDTheme.textColorL1, fontSize: 16);

  TextStyle get dialogDescribe =>
      TextStyle(color: TDTheme.textColorL2, fontSize: 16);

  TextStyle get dialogHint =>
      TextStyle(color: TDTheme.textColorL4, fontSize: 16);
}
