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
    Color? primaryColor = theme?.themeColor(context).primaryColor;
    return TextStyle(fontSize: 16, color: primaryColor);
  }

  TextStyle m16Primary(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor(context).primaryColor;
    return TextStyle(
        fontSize: 16, color: primaryColor, fontWeight: FontWeight.w500);
  }

  TextStyle r14Primary(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor(context).primaryColor;
    return TextStyle(fontSize: 16, color: primaryColor);
  }

  TextStyle r12Primary(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor(context).primaryColor;
    return TextStyle(fontSize: 16, color: primaryColor);
  }

  /// Error
  TextStyle r16Error(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? errorColor = theme?.themeColor(context).errorColor;
    return TextStyle(fontSize: 16, color: errorColor);
  }

  TextStyle m16Error(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? errorColor = theme?.themeColor(context).errorColor;
    return TextStyle(
        fontSize: 16, color: errorColor, fontWeight: FontWeight.w500);
  }

  TextStyle r14Error(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor(context).primaryColor;
    return TextStyle(fontSize: 16, color: primaryColor);
  }

  TextStyle r12Error(BuildContext context) {
    TDTheme? theme = TDTheme.of(context);
    Color? primaryColor = theme?.themeColor(context).primaryColor;
    return TextStyle(fontSize: 16, color: primaryColor);
  }
}
