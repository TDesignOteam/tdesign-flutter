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

  /// 普通show一个底部可滑动的布局
  Future showBottomSheet(
      {required BuildContext context,
      required Widget sheet,
      double? heightPercent,
      double? offset}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (BuildContext context) {
          return _buildWrapSheet(context, sheet, heightPercent, offset);
        });
  }

  Widget _buildWrapSheet(BuildContext context, Widget sheetContent,
      double? heightPercent, double? offset) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 100, //设置最小高度（必要）
        maxHeight:
            (MediaQuery.of(context).size.height * (heightPercent ?? 0.66)) -
                (offset ?? 0), //设置最大高度（必要）
      ),
      color: Colors.white,
      child: SafeArea(child: sheetContent),
    );
  }

  TextStyle dialogTitle(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? textColorL1 = theme?.themeColor.textColorL1;
    return TextStyle(color: textColorL1, fontSize: 16);
  }

  TextStyle dialogDescribe(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? textColorL2 = theme?.themeColor.textColorL2;
    return TextStyle(color: textColorL2, fontSize: 16);
  }

  TextStyle dialogHint(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? textColorL4 = theme?.themeColor.textColorL4;
    return TextStyle(color: textColorL4, fontSize: 16);
  }

  Color divideColor(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? divideColor = theme?.themeColor.divideColor;
    return divideColor!;
  }

  Color editBackground(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? editBackground = theme?.themeColor.editBackground;
    return editBackground!;
  }
}
