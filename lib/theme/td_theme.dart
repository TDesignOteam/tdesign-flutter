//  Created by lyrisli on 2021/4/30.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

// ignore: must_be_immutable
class TDTheme extends InheritedWidget {
  final TDThemeColor _themeColorBright;

  final TDThemeColor _themeColorDark;

  final TDThemeData themeData;

  bool _isDarkMode;

  TDTheme({
    required child,
    themeColorBright,
    themeColorDark,
    themeData,
  })  : this._themeColorBright = themeColorBright ?? TDThemeColor(),
        this._themeColorDark = themeColorDark ?? TDThemeColor.dark(),
        this.themeData = themeData ?? TDThemeData(),
        this._isDarkMode = false,
        super(child: child);

  static TDTheme? of(BuildContext context) {
    final TDTheme? instance = context.dependOnInheritedWidgetOfExactType<TDTheme>();
    instance?._isDarkMode = isDarkMode(context);
    return instance;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget != this;
  }

  TDThemeColor get themeColor => _isDarkMode ? _themeColorDark : _themeColorBright;

  /// 返回当前所处应用主题环境是否是黑暗模式
  static bool isDarkMode(BuildContext? context) {
    return context == null
        ? false
        : MediaQuery.platformBrightnessOf(context) == Brightness.dark;
  }
}

class TDThemeData {
  /// Spacer间距
  final double spacer;

  /// 间距 - 小
  final double spacer1;

  /// 间距 - 小 - x
  final double spacer2;

  /// 间距 - 中
  final double spacer3;

  /// 间距 - 大
  final double spacer4;

  /// 间距 - 大 - x
  final double spacer5;

  /// 间距 - 大 - xx
  final double spacer6;

  /// Font字号
  final double fontSize;

  /// 字号 - xs
  final double fontSizeXS;

  /// 字号 - s
  final double fontSizeS;

  /// 字号 - base
  final double fontSizeBase;

  /// 字号 - l
  final double fontSizeL;

  /// 字号 - xl
  final double fontSizeXL;

  // 字体文件和依赖待添加
  /// 字体 - 普通
  final String fontFamily;

  /// 字体 - 加粗
  final String fontFamilyMedium;

  ///  圆角
  final double borderRadius;

  /// 表单高度
  final double formHeight;

  /// 表单文字颜色
  final Color formTextColor;

  /// 表单背景颜色
  final Color formBgColor;

  /// 表单边框
  final Color formBorderColor;

  /// 图标尺寸 - 小
  final double iconX;

  /// 图标尺寸 - 默认
  final double iconDefault;

  factory TDThemeData({
    double? spacer,
    double? spacer1,
    double? spacer2,
    double? spacer3,
    double? spacer4,
    double? spacer5,
    double? spacer6,
    double? fontSize,
    double? fontSizeXS,
    double? fontSizeS,
    double? fontSizeBase,
    double? fontSizeL,
    double? fontSizeXL,
    String? fontFamily,
    String? fontFamilyMedium,
    double? borderRadius,
    double? formHeight,
    Color? formTextColor,
    Color? formBgColor,
    Color? formBorderColor,
    double? iconX,
    double? iconDefault,
  }) {
    return TDThemeData.raw(
      spacer: spacer ?? 6.0,
      spacer1: spacer1 ?? 6.0,
      spacer2: spacer2 ?? 12.0,
      spacer3: spacer3 ?? 18.0,
      spacer4: spacer4 ?? 24.0,
      spacer5: spacer5 ?? 36.0,
      spacer6: spacer6 ?? 60.0,
      fontSize: fontSize ?? 10,
      fontSizeXS: fontSizeXS ?? 10,
      fontSizeS: fontSizeS ?? 12,
      fontSizeBase: fontSizeBase ?? 14,
      fontSizeL: fontSizeL ?? 16,
      fontSizeXL: fontSizeXL ?? 18,
      fontFamily: fontFamily ?? 'PingFangSC-Regular',
      fontFamilyMedium: fontFamilyMedium ?? 'PingFangSC-Medium',
      borderRadius: borderRadius ?? 6,
      formHeight: formHeight ?? 60,
      formTextColor: formTextColor ?? TDColors.fontBlack,
      formBgColor: formBgColor ?? Color(0xFFFFFFFF),
      formBorderColor: formBorderColor ?? Color(0xFFDDDDDD),
      iconX: iconX ?? 24,
      iconDefault: iconDefault ?? 32,
    );
  }

  const TDThemeData.raw({
    required this.spacer,
    required this.spacer1,
    required this.spacer2,
    required this.spacer3,
    required this.spacer4,
    required this.spacer5,
    required this.spacer6,
    required this.fontSize,
    required this.fontSizeXS,
    required this.fontSizeS,
    required this.fontSizeBase,
    required this.fontSizeL,
    required this.fontSizeXL,
    required this.fontFamily,
    required this.fontFamilyMedium,
    required this.borderRadius,
    required this.formHeight,
    required this.formTextColor,
    required this.formBgColor,
    required this.formBorderColor,
    required this.iconX,
    required this.iconDefault,
  });
}

class TDThemeColor {
  /// 基础颜色 - 主题色
  final Color primaryColor;

  /// 基础颜色 - 失败/错误色
  final Color errorColor;

  /// 基础颜色 - 警告色
  final Color warningColor;

  /// 基础颜色 - 成功色
  final Color successColor;

  /// 主题色扩展 - active
  final Color primaryColorActive;

  /// 主题色扩展 - disabled
  final Color primaryColorDisabled;

  /// 失败/错误色扩展 - active
  final Color errorColorActive;

  /// 失败/错误色扩展 - disabled
  final Color errorColorDisabled;

  /// 警告色扩展 - active
  final Color warningColorActive;

  /// 警告色扩展 - disabled
  final Color warningColorDisabled;

  /// 遮罩 - 弹出
  final Color maskActive;

  /// 遮罩 - 禁用
  final Color maskDisabled;

  /// 背景
  final Color bgColor;

  /// 中层背景
  final Color bgColorFade;

  /// hover / click 背景 / 搜索输入框
  final Color bgColorHover;

  /// hover / click 背景 / 搜索输入框
  final Color bgColorActive;

  /// disabled
  final Color bgColorDisabled;

  /// 模块
  final Color bgColorBlock;

  /// icon灰显颜色
  final Color bgIconFade;

  /// icon深色
  final Color bgIconDark;

  /// 文字 - 一级
  final Color textColorL1;

  /// 文字 - 二级
  final Color textColorL2;

  /// 文字 - 三级
  final Color textColorL3;

  /// 文字 - 四级
  final Color textColorL4;

  /// 文字禁用色
  final Color textColorDisabled;

  /// 文字主色反色
  final Color textAntiPrimaryColor;

  /// 占位文字颜色
  final Color placeHolderColor;

  /// 边框色1
  final Color borderColorL1;

  /// 边框色2
  final Color borderColorL2;

  // 分割线颜色
  final Color divideColor;

  //输入框背景色
  final Color editBackground;

  factory TDThemeColor({
    Color? primaryColor,
    Color? errorColor,
    Color? warningColor,
    Color? successColor,
    Color? primaryColorActive,
    Color? primaryColorDisabled,
    Color? errorColorActive,
    Color? errorColorDisabled,
    Color? warningColorActive,
    Color? warningColorDisabled,
    Color? maskActive,
    Color? maskDisabled,
    Color? bgColor,
    Color? bgColorFade,
    Color? bgColorHover,
    Color? bgColorActive,
    Color? bgColorDisabled,
    Color? bgColorBlock,
    Color? bgIconFade,
    Color? bgIconDark,
    Color? textColorL1,
    Color? textColorL2,
    Color? textColorL3,
    Color? textColorL4,
    Color? textColorDisabled,
    Color? textAntiPrimaryColor,
    Color? placeHolderColor,
    Color? borderColorL1,
    Color? borderColorL2,
    Color? divideColor,
    Color? editBackground,
  }) {
    return TDThemeColor.raw(
      primaryColor: primaryColor ?? TDColors.blue,
      errorColor: errorColor ?? TDColors.red,
      warningColor: warningColor ?? TDColors.orange,
      successColor: successColor ?? TDColors.green,
      primaryColorActive: primaryColorActive ?? TDColors.blue.shade9,
      primaryColorDisabled: primaryColorDisabled ?? TDColors.blue.shade2,
      errorColorActive: errorColorActive ?? TDColors.red.shade7,
      errorColorDisabled: errorColorDisabled ?? TDColors.red.shade2,
      warningColorActive: warningColorActive ?? TDColors.red.shade7,
      warningColorDisabled: warningColorDisabled ?? TDColors.red.shade2,
      maskActive: maskActive ?? Color.fromARGB((255 * 0.6).round(), 0, 0, 0),
      maskDisabled:
          maskDisabled ?? Color.fromARGB((255 * 0.6).round(), 255, 255, 255),
      bgColor: bgColor ?? Color(0xFFFBFBFB),
      bgColorFade: bgColorFade ?? Color(0xFFFBFBFB),
      bgColorHover: bgColorHover ?? Color(0xFFF5F5F5),
      bgColorActive: bgColorActive ?? Color(0xFFF5F5F5),
      bgColorDisabled: bgColorDisabled ?? Color(0xFFFFFFFF),
      bgColorBlock: bgColorBlock ?? Color(0xFFFFFFFF),
      bgIconFade: bgIconFade ?? Color(0xFFCCCCCC),
      bgIconDark: bgIconDark ?? Color(0xFF444444),
      textColorL1: textColorL1 ?? TDColors.fontBlack,
      textColorL2: textColorL2 ?? TDColors.fontBlack[2]!,
      textColorL3: textColorL3 ?? TDColors.fontBlack[3]!,
      textColorL4: textColorL4 ?? TDColors.fontBlack[4]!,
      textColorDisabled: textColorDisabled ?? TDColors.fontBlack[4]!,
      textAntiPrimaryColor: textAntiPrimaryColor ?? TDColors.fontWhite,
      placeHolderColor: placeHolderColor ?? TDColors.fontBlack[3]!,
      borderColorL1: borderColorL1 ?? Color(0xFFE6E6E6),
      borderColorL2: borderColorL2 ?? Color(0xFFDDDDDD),
      divideColor: divideColor ?? Color(0xFFE7E7E7),
      editBackground: editBackground ?? Color(0xFFF5F5F5),
    );
  }

  factory TDThemeColor.dark({
    Color? primaryColor,
    Color? errorColor,
    Color? warningColor,
    Color? successColor,
    Color? primaryColorActive,
    Color? primaryColorDisabled,
    Color? errorColorActive,
    Color? errorColorDisabled,
    Color? warningColorActive,
    Color? warningColorDisabled,
    Color? maskActive,
    Color? maskDisabled,
    Color? bgColor,
    Color? bgColorFade,
    Color? bgColorHover,
    Color? bgColorActive,
    Color? bgColorDisabled,
    Color? bgColorBlock,
    Color? bgIconFade,
    Color? bgIconDark,
    Color? textColorL1,
    Color? textColorL2,
    Color? textColorL3,
    Color? textColorL4,
    Color? textColorDisabled,
    Color? textAntiPrimaryColor,
    Color? placeHolderColor,
    Color? borderColorL1,
    Color? borderColorL2,
    Color? divideColor,
    Color? editBackground,
  }) {
    return TDThemeColor.raw(
      primaryColor: primaryColor ?? TDColors.blue,
      errorColor: errorColor ?? TDColors.red,
      warningColor: warningColor ?? TDColors.orange,
      successColor: successColor ?? TDColors.green,
      primaryColorActive: primaryColorActive ?? TDColors.blue.shade9,
      primaryColorDisabled: primaryColorDisabled ?? TDColors.blue.shade2,
      errorColorActive: errorColorActive ?? TDColors.red.shade7,
      errorColorDisabled: errorColorDisabled ?? TDColors.red.shade2,
      warningColorActive: warningColorActive ?? TDColors.red.shade7,
      warningColorDisabled: warningColorDisabled ?? TDColors.red.shade2,
      maskActive: maskActive ?? Color.fromARGB((255 * 0.6).round(), 0, 0, 0),
      maskDisabled:
          maskDisabled ?? Color.fromARGB((255 * 0.6).round(), 255, 255, 255),
      bgColor: bgColor ?? Color(0xFFFBFBFB),
      bgColorFade: bgColorFade ?? Color(0xFFFBFBFB),
      bgColorHover: bgColorHover ?? Color(0xFFF5F5F5),
      bgColorActive: bgColorActive ?? Color(0xFFF5F5F5),
      bgColorDisabled: bgColorDisabled ?? Color(0xFFFFFFFF),
      bgColorBlock: bgColorBlock ?? Color(0xFFFFFFFF),
      bgIconFade: bgIconFade ?? Color(0xFFCCCCCC),
      bgIconDark: bgIconDark ?? Color(0xFF444444),
      textColorL1: textColorL1 ?? TDColors.fontBlack,
      textColorL2: textColorL2 ?? TDColors.fontBlack[2]!,
      textColorL3: textColorL3 ?? TDColors.fontBlack[3]!,
      textColorL4: textColorL4 ?? TDColors.fontBlack[4]!,
      textColorDisabled: textColorDisabled ?? TDColors.fontBlack[4]!,
      textAntiPrimaryColor: textAntiPrimaryColor ?? TDColors.fontWhite,
      placeHolderColor: placeHolderColor ?? TDColors.fontBlack[3]!,
      borderColorL1: borderColorL1 ?? Color(0xFFE6E6E6),
      borderColorL2: borderColorL2 ?? Color(0xFFDDDDDD),
      divideColor: divideColor ?? Color(0xFFE7E7E7),
      editBackground: editBackground ?? Color(0xFFF5F5F5),
    );
  }

  const TDThemeColor.raw({
    required this.primaryColor,
    required this.errorColor,
    required this.warningColor,
    required this.successColor,
    required this.primaryColorActive,
    required this.primaryColorDisabled,
    required this.errorColorActive,
    required this.errorColorDisabled,
    required this.warningColorActive,
    required this.warningColorDisabled,
    required this.maskActive,
    required this.maskDisabled,
    required this.bgColor,
    required this.bgColorFade,
    required this.bgColorHover,
    required this.bgColorActive,
    required this.bgColorDisabled,
    required this.bgColorBlock,
    required this.bgIconFade,
    required this.bgIconDark,
    required this.textColorL1,
    required this.textColorL2,
    required this.textColorL3,
    required this.textColorL4,
    required this.textColorDisabled,
    required this.textAntiPrimaryColor,
    required this.placeHolderColor,
    required this.borderColorL1,
    required this.borderColorL2,
    required this.divideColor,
    required this.editBackground,
  });
}
