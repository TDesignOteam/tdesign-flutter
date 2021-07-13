//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';

import 'toast.dart';
import 'toast_config.dart';
import 'widgets/toast_animation.dart';

// 考虑适配主题：indicatorColor => Toast.instance.themeStyle == ToastThemeStyle.dark ? Colors.white : Colors.black;
class ToastTheme {
  /// color of indicator
  static Color get indicatorColor => TDToast.instance.indicatorColor;

  /// background color of toast
  static Color get backgroundColor {
    if (TDToast.instance.showOverlay == true) {
      return Colors.black.withOpacity(0.6);
    } else {
      return ToastConfig.backgroundColor; // default
    }
  }

  /// font color of message
  static Color get textColor => ToastConfig.textColor;

  /// mask color of message
  static Color get maskColor {
    if (TDToast.instance.showOverlay == true) {
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
  static double get fontSize => TDToast.instance.fontSize;

  /// size of indicator
  static double get indicatorSize => TDToast.instance.indicatorSize;

  /// width of indicator
  static double get indicatorLineWidth => TDToast.instance.indicatorLineWidth;

  /// toast position
  static TDToastPosition get toastPosition => TDToast.instance.toastPosition;

  /// toast position
  static AlignmentGeometry alignment(TDToastPosition? position) => position == TDToastPosition.bottom
      ? AlignmentDirectional.bottomCenter
      : (position == TDToastPosition.top ? AlignmentDirectional.topCenter : AlignmentDirectional.center);

  /// display duration
  static Duration get displayDuration => TDToast.instance.displayDuration;

  /// animation duration
  static Duration get animationDuration => TDToast.instance.animationDuration;

  /// contentPadding of loading
  static EdgeInsets get contentPadding => TDToast.instance.contentPadding;

  /// padding of message
  static EdgeInsets get textPadding => TDToast.instance.textPadding;

  /// textAlign of message
  static TextAlign get textAlign => TDToast.instance.textAlign;

  /// textStyle of message
  static TextStyle? get textStyle => TDToast.instance.textStyle;

  /// radius of loading
  static double get radius => TDToast.instance.radius;

  /// should dismiss on user tap
  static bool? get dismissOnTap => TDToast.instance.dismissOnTap;

  /// 当显示背景遮罩时，禁止背景点击和滚动
  static bool get ignoring => !TDToast.instance.showOverlay;
}
