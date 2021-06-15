//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';

import 'toast.dart';
import 'config.dart';
import 'widgets/animation.dart';

// 考虑适配主题：indicatorColor => Toast.instance.themeStyle == ToastThemeStyle.dark ? Colors.white : Colors.black;
class ToastTheme {
  /// color of indicator
  static Color get indicatorColor => Toast.instance.indicatorColor;

  /// background color of toast
  static Color get backgroundColor {
    if (Toast.instance.showOverlay == true) {
      return Colors.black.withOpacity(0.6);
    } else {
      return ToastConfig.backgroundColor; // default
    }
  }

  /// font color of message
  static Color get textColor => ToastConfig.textColor;

  /// mask color of message
  static Color get maskColor {
    if (Toast.instance.showOverlay == true) {
      return ToastConfig.backgroundColor;
    } else {
      // false or null
      return ToastConfig.maskColor;
    }
  }

  /// toast animation
  static ToastAnimation get toastAnimation {
    ToastAnimation _animation = OpacityAnimation();
    return _animation;
  }

  /// font size of message
  static double get fontSize => Toast.instance.fontSize;

  /// size of indicator
  static double get indicatorSize => Toast.instance.indicatorSize;

  /// width of indicator
  static double get indicatorLineWidth => Toast.instance.indicatorLineWidth;

  /// toast position
  static ToastPosition get toastPosition => Toast.instance.toastPosition;

  /// toast position
  static AlignmentGeometry alignment(ToastPosition? position) =>
      position == ToastPosition.bottom
          ? AlignmentDirectional.bottomCenter
          : (position == ToastPosition.top
              ? AlignmentDirectional.topCenter
              : AlignmentDirectional.center);

  /// display duration
  static Duration get displayDuration => Toast.instance.displayDuration;

  /// animation duration
  static Duration get animationDuration => Toast.instance.animationDuration;

  /// contentPadding of loading
  static EdgeInsets get contentPadding => Toast.instance.contentPadding;

  /// padding of message
  static EdgeInsets get textPadding => Toast.instance.textPadding;

  /// textAlign of message
  static TextAlign get textAlign => Toast.instance.textAlign;

  /// textStyle of message
  static TextStyle? get textStyle => Toast.instance.textStyle;

  /// radius of loading
  static double get radius => Toast.instance.radius;

  /// should dismiss on user tap
  static bool? get dismissOnTap => Toast.instance.dismissOnTap;

  /// 当显示背景遮罩时，禁止背景点击和滚动
  static bool get ignoring => !Toast.instance.showOverlay;
}
