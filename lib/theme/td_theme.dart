//  Created by lyrisli on 2021/4/30.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

abstract class TDTheme {
  /// 基础颜色 - 主题色
  static Color primaryColor = TDColors.blue;

  /// 基础颜色 - 失败/错误色
  static Color errorColor = TDColors.red;

  /// 基础颜色 - 警告色
  static Color warningColor = TDColors.orange;

  /// 基础颜色 - 成功色
  static Color successColor = TDColors.green;

  /// 主题色扩展 - active
  static Color primaryColorActive = TDColors.blue.shade9;

  /// 主题色扩展 - disabled
  static Color primaryColorDisabled = TDColors.blue.shade2;

  /// 失败/错误色扩展 - active
  static Color errorColorActive = TDColors.red.shade7;

  /// 失败/错误色扩展 - disabled
  static Color errorColorDisabled = TDColors.red.shade2;

  /// 警告色扩展 - active
  static Color warningColorActive = TDColors.red.shade7;

  /// 警告色扩展 - disabled
  static Color warningColorDisabled = TDColors.red.shade2;

  /// 遮罩 - 弹出
  static Color maskActive = Color.fromARGB((255 * 0.6).round(), 0, 0, 0);

  /// 遮罩 - 禁用
  static Color maskDisabled =
      Color.fromARGB((255 * 0.6).round(), 255, 255, 255);

  /// 背景
  static Color bgColor = Color(0xFFFBFBFB);

  /// 中层背景
  static Color bgColorFade = Color(0xFFFBFBFB);

  /// hover / click 背景 / 搜索输入框
  static Color bgColorHover = Color(0xFFF5F5F5);

  /// hover / click 背景 / 搜索输入框
  static Color bgColorActive = Color(0xFFF5F5F5);

  /// disabled
  static Color bgColorDisabled = Color(0xFFFFFFFF);

  /// 模块
  static Color bgColorBlock = Color(0xFFFFFFFF);

  /// icon灰显颜色
  static Color bgIconFade = Color(0xFFCCCCCC);

  /// icon深色
  static Color bgIconDark = Color(0xFF444444);

  /// 文字 - 一级
  static Color textColorL1 = TDColors.fontBlack;

  /// 文字 - 二级
  static Color textColorL2 = TDColors.fontBlack[2]!;

  /// 文字 - 三级
  static Color textColorL3 = TDColors.fontBlack[3]!;

  /// 文字 - 四级
  static Color textColorL4 = TDColors.fontBlack[4]!;

  /// 文字禁用色
  static Color textColorDisabled = textColorL4;

  /// 文字主色反色
  static Color textAntiPrimaryColor = TDColors.fontWhite;

  /// 占位文字颜色
  static Color placeHolderColor = textColorL3;

  /// 边框色1
  static Color borderColorL1 = Color(0xFFE6E6E6);

  /// 边框色2
  static Color borderColorL2 = Color(0xFFDDDDDD);

  /// Spacer间距
  static double spacer = 6.0;

  /// 间距 - 小
  static double spacer1 = spacer;

  /// 间距 - 小 - x
  static double spacer2 = spacer * 2;

  /// 间距 - 中
  static double spacer3 = spacer * 3;

  /// 间距 - 大
  static double spacer4 = spacer * 4;

  /// 间距 - 大 - x
  static double spacer5 = spacer * 6;

  /// 间距 - 大 - xx
  static double spacer6 = spacer * 10;

  /// Font字号
  static double fontSize = 10;

  /// 字号 - xs
  static double fontSizeXS = fontSize;

  /// 字号 - s
  static double fontSizeS = fontSize * 1.2;

  /// 字号 - base
  static double fontSizeBase = fontSize * 1.4;

  /// 字号 - l
  static double fontSizeL = fontSize * 1.6;

  /// 字号 - xl
  static double fontSizeXL = fontSize * 1.8;

  // 字体文件和依赖待添加
  /// 字体 - 普通
  static String fontFamily1 = 'PingFangSC-Regular';

  /// 字体 - 加粗
  static String fontFamilyMedium1 = 'PingFangSC-Medium';

  ///  圆角
  static double borderRadius = 6;

  /// 表单高度
  static double formHeight = 60;

  /// 表单文字颜色
  static Color formTextColor = textColorL1;

  /// 表单背景颜色
  static Color formBgColor = bgColorBlock;

  /// 表单边框
  static Color formBorderColor = borderColorL2;

  // 阴影
  // 需要时添加
  // static BoxShadow shadow = BoxShadow();

  /// 图标尺寸 - 小
  static double iconX = 24;

  /// 图标尺寸 - 默认
  static double iconDefault = 32;

  /// 暗色模式
  static Color darkBgColor = Color(0xFF272B30); // 色彩-深色背景

  /// 返回当前所处应用主题环境是否是黑暗模式
  static bool isDarkMode(BuildContext? context) {
    return context == null
        ? false
        : MediaQuery.platformBrightnessOf(context) == Brightness.dark;
  }

  static Color divideColor = Color(0xFFE7E7E7); // 分割线颜色
  static Color editBackground = Color(0xFFF5F5F5); //输入框背景色

}
