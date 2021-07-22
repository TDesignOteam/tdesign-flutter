import 'package:flutter/material.dart';

import 'td_theme.dart';

TDTextStyle tdTextStyle = TDTextStyle.instance;

class TDTextStyle {
  factory TDTextStyle() => _instance;
  static TDTextStyle get instance => _instance;
  static TDTextStyle _instance = TDTextStyle._internal();
  TDTextStyle._internal();

  /// primary
  TextStyle r16Primary(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor.primaryColor;
    return TextStyle(fontSize: 16, color: primaryColor);
  }

  TextStyle r16PrimaryButtonDisable(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor.buttonDisablePrimary;
    return TextStyle(fontSize: 16, color: primaryColor);
  }

  TextStyle m16Primary(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor.primaryColor;
    return TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.w500);
  }

  TextStyle r14Primary(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor.primaryColor;
    return TextStyle(fontSize: 14, color: primaryColor);
  }

  TextStyle r14PrimaryButtonDisable(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor.buttonDisablePrimary;
    return TextStyle(fontSize: 14, color: primaryColor);
  }

  TextStyle r12Primary(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor.primaryColor;
    return TextStyle(fontSize: 16, color: primaryColor);
  }

  /// text
  TextStyle r16Text(BuildContext context, {int textLevel = 1}) {
    return TextStyle(fontSize: 16, color: _textColor(context, textLevel));
  }

  TextStyle m16Text(BuildContext context, {int textLevel = 1}) {
    return TextStyle(fontSize: 16, color: _textColor(context, textLevel), fontWeight: FontWeight.w500);
  }

  TextStyle r14Text(BuildContext context, {int textLevel = 1}) {
    return TextStyle(fontSize: 14, color: _textColor(context, textLevel));
  }

  TextStyle m14Text(BuildContext context, {int textLevel = 1}) {
    return TextStyle(fontSize: 14, color: _textColor(context, textLevel), fontWeight: FontWeight.w500);
  }

  Color? _textColor(BuildContext context, int textLevel) {
    Color? color;
    TDThemeColor? themeColor = TDTheme.of(context)?.themeColor;
    switch (textLevel) {
      case 2:
        color = themeColor?.textColorL2;
        break;
      case 3:
        color = themeColor?.textColorL3;
        break;
      case 4:
        color = themeColor?.textColorL4;
        break;
      default:
        break;
    }
    return color ?? themeColor?.textColorL1;
  }

  TextStyle r16AntiText(BuildContext context, {int textLevel = 1}) {
    return TextStyle(fontSize: 16, color: _textAntiColor(context, textLevel));
  }

  TextStyle r14AntiText(BuildContext context, {int textLevel = 1}) {
    return TextStyle(fontSize: 14, color: _textAntiColor(context, textLevel));
  }

  Color? _textAntiColor(BuildContext context, int textLevel) {
    Color? color;
    TDThemeColor? themeColor = TDTheme.of(context)?.themeColor;
    return color ?? themeColor?.textAntiPrimaryColor;
  }

  /// Error
  TextStyle r16Error(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? errorColor = theme?.themeColor.errorColor;
    return TextStyle(fontSize: 16, color: errorColor);
  }

  TextStyle m16Error(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? errorColor = theme?.themeColor.errorColor;
    return TextStyle(fontSize: 16, color: errorColor, fontWeight: FontWeight.w500);
  }

  TextStyle r14Error(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? errorColor = theme?.themeColor.errorColor;
    return TextStyle(fontSize: 14, color: errorColor);
  }

  TextStyle r14ErrorDisable(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? errorColor = theme?.themeColor.errorColorDisabled;
    return TextStyle(fontSize: 14, color: errorColor);
  }

  TextStyle r12Error(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor.primaryColor;
    return TextStyle(fontSize: 16, color: primaryColor);
  }
}
