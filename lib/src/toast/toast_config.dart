//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'toast.dart';

///控件默认配置
class ToastConfig {
  /// toast theme style.
  // static ToastThemeStyle themeStyle = ToastThemeStyle.dark;

  /// toast position.
  static ToastPosition toastPosition = ToastPosition.middle;

  /// animation duration of indicator.
  static Duration animationDuration = const Duration(milliseconds: 200);

  /// display duration of [success] [fail] [info] [toast]
  static Duration displayDuration = const Duration(milliseconds: 2000);

  /// background color of toast.
  static Color backgroundColor = Colors.black.withOpacity(0.6);

  /// radius of toast.
  static double radius = 4.0;

  /// show mask background.
  static bool showOverlay = false;

  /// mask color of loading.
  static Color maskColor = Colors.transparent;

  /// size of indicator
  static double indicatorSize = 48.0;

  /// color of toast indicator.
  static Color indicatorColor = Colors.white;

  /// width of indicator.
  static double indicatorLineWidth = 3.0;

  /// fontSize of toast.
  static double fontSize = 14.0;

  /// color of toast message.
  static Color textColor = Colors.white;

  /// should dismiss on user tap.
  static bool dismissOnTap = false;
}
