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

  TextStyle dialogTitle(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? textColorL1 = theme?.themeColor(context).textColorL1;
    return TextStyle(color: textColorL1, fontSize: 16);
  }

  TextStyle dialogDescribe(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? textColorL2 = theme?.themeColor(context).textColorL2;
    return TextStyle(color: textColorL2, fontSize: 16);
  }

  TextStyle dialogHint(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? textColorL4 = theme?.themeColor(context).textColorL4;
    return TextStyle(color: textColorL4, fontSize: 16);
  }

  Color divideColor(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? divideColor = theme?.themeColor(context).divideColor;
    return divideColor!;
  }

  Color editBackground(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? editBackground = theme?.themeColor(context).editBackground;
    return editBackground!;
  }
}
