import 'package:flutter/material.dart';

import 'td_theme.dart';

TDTextStyle tdTextStyle = TDTextStyle.instance;

class TDTextStyle {
  factory TDTextStyle() => _instance;
  static TDTextStyle get instance => _instance;
  static TDTextStyle _instance = TDTextStyle._internal();
  TDTextStyle._internal();

  /// primary
  TextStyle get r16Primary =>
      TextStyle(fontSize: 16, color: TDTheme.primaryColor);
  TextStyle get m16Primary => TextStyle(
      fontSize: 16, color: TDTheme.primaryColor, fontWeight: FontWeight.w500);
  TextStyle get r14Primary =>
      TextStyle(fontSize: 16, color: TDTheme.primaryColor);
  TextStyle get r12Primary =>
      TextStyle(fontSize: 16, color: TDTheme.primaryColor);

  /// Error
  TextStyle get r16Error => TextStyle(fontSize: 16, color: TDTheme.errorColor);
  TextStyle get m16Error => TextStyle(
      fontSize: 16, color: TDTheme.errorColor, fontWeight: FontWeight.w500);
  TextStyle get r14Error =>
      TextStyle(fontSize: 16, color: TDTheme.primaryColor);
  TextStyle get r12Error =>
      TextStyle(fontSize: 16, color: TDTheme.primaryColor);
}
