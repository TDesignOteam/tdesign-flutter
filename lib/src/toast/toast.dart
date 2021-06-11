//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

/// Toast轻提示控件
///
/// 实现参考了 [flutter_easyloading](https://pub.dev/packages/flutter_easyloading)

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tdesign/src/toast/config.dart';

import 'widgets/container.dart';
import 'widgets/indicator.dart';
import 'widgets/overlayentry.dart';
import 'widgets/toastwidget.dart';
import 'theme.dart';

/// toast theme style
// enum ToastThemeStyle {
//   dark,
//   light,
//   custom,
// }

/// toast info style
// enum ToastInfoStyle {
//   loading,
//   success,
//   fail,
// }

/// toast position
enum ToastPosition {
  top,
  middle,
  bottom,
}

// only message: 文本轻提示
// only icon: 图标轻提示
// message+icon: 图标加文本轻提示，包括loading
// class ToastProps {
//   /// 文本内容，支持通过\n 换行
//   String? message;

//   /// 提示类型，可选值 loading、success、fail
//   ToastInfoStyle? type;

//   /// 展示位置，可选值 top、middle、bottom
//   ToastPosition? position;

//   /// 自定义图标URL
//   String? icon;

//   /// 显示背景遮罩，禁止背景点击和滚动
//   bool? showOverlay;

//   /// 展示时长 ms，值为 0 时不消失
//   Duration? duration;
// }

class Toast {
  /// toast theme style.
  // late ToastThemeStyle themeStyle;

  /// toast position.
  late ToastPosition toastPosition;

  /// animation duration of indicator.
  late Duration animationDuration;

  /// display duration of [showSuccess] [showError] [showInfo] [showToast]
  late Duration displayDuration;

  /// background color of toast.
  late Color backgroundColor;

  /// radius of toast.
  late double radius;

  /// show mask background.
  late bool showOverlay;

  /// mask color of toast, pass to container.
  late Color maskColor;

  /// size of indicator.
  late double indicatorSize;

  /// color of toast indicator.
  late Color indicatorColor;

  /// width of indicator.
  late double indicatorLineWidth;

  /// textAlign of message.
  late TextAlign textAlign;

  /// textStyle of message, default null.
  TextStyle? textStyle;

  /// fontSize of toast.
  late double fontSize;

  /// color of toast message.
  late Color textColor;

  /// content padding of toast.
  late EdgeInsets contentPadding;

  /// padding of [message].
  late EdgeInsets textPadding;

  /// should dismiss on user tap.
  bool? dismissOnTap;

  /// indicator widget
  Widget? indicatorWidget;

  /// success widget
  Widget? successWidget;

  /// error widget
  Widget? errorWidget;

  /// info widget
  Widget? infoWidget;

  Widget? _w;
  Widget? get w => _w;

  GlobalKey<ToastContainerState>? _key;
  GlobalKey<ToastContainerState>? get key => _key;

  ToastOverlayEntry? overlayEntry;
  Timer? _timer;

  factory Toast() => _instance;
  static final Toast _instance = Toast._internal();

  Toast._internal() {
    /// set deafult value
    toastPosition = ToastConfig.toastPosition;

    animationDuration = ToastConfig.animationDuration;
    displayDuration = ToastConfig.displayDuration;

    backgroundColor = ToastConfig.backgroundColor;
    radius = ToastConfig.radius;

    showOverlay = ToastConfig.showOverlay;
    maskColor = ToastConfig.maskColor;

    indicatorSize = ToastConfig.indicatorSize;
    indicatorColor = ToastConfig.indicatorColor;
    indicatorLineWidth = ToastConfig.indicatorLineWidth;

    // textStyle =
    fontSize = ToastConfig.fontSize;
    textColor = ToastConfig.textColor;
    textAlign = TextAlign.center;
    textPadding = const EdgeInsets.only(bottom: 10.0);
    contentPadding = const EdgeInsets.symmetric(
      vertical: 15.0,
      horizontal: 20.0,
    );

    dismissOnTap = ToastConfig.dismissOnTap;
  }

  static Toast get instance => _instance;
  static bool get isShow => _instance.w != null;

  /// init FlutterToast which build Material with Overlay(OverlayEntry)
  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, FlutterToast(child: child));
      } else {
        return FlutterToast(child: child);
      }
    };
  }

  /// toast [message] [duration] [toastPosition]
  static Future<void> toast(
    String message, {
    Duration? duration,
    ToastPosition? toastPosition,
    bool? dismissOnTap,
    bool? showOverlay,
  }) {
    _instance.showOverlay = showOverlay ?? false;

    return _instance._show(
      message: message,
      duration: duration ?? ToastTheme.displayDuration,
      toastPosition: toastPosition ?? ToastTheme.toastPosition,
      dismissOnTap: dismissOnTap,
    );
  }

  /// show loading with [message] [indicator]
  static Future<void> loading({
    String? message,
    Duration? duration,
    ToastPosition? toastPosition,
    Widget? indicator,
    bool? dismissOnTap,
    bool? showOverlay,
  }) {
    _instance.showOverlay = showOverlay ?? false;

    Widget w = indicator ?? (_instance.indicatorWidget ?? ToastIndicator());
    return _instance._show(
      message: message,
      duration: duration ?? ToastTheme.displayDuration,
      toastPosition: toastPosition ?? ToastTheme.toastPosition,
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  /// show success with [message] [duration]
  static Future<void> success({
    String? message,
    Duration? duration,
    ToastPosition? toastPosition,
    bool? dismissOnTap,
    bool? showOverlay,
  }) {
    _instance.showOverlay = showOverlay ?? false;

    Widget w = _instance.successWidget ??
        Icon(
          Icons.done,
          color: ToastTheme.indicatorColor,
          size: ToastTheme.indicatorSize,
        );
    return _instance._show(
      message: message,
      duration: duration ?? ToastTheme.displayDuration,
      toastPosition: toastPosition ?? ToastTheme.toastPosition,
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  /// show fail with [message] [duration]
  static Future<void> fail({
    String? message,
    Duration? duration,
    ToastPosition? toastPosition,
    bool? dismissOnTap,
    bool? showOverlay,
  }) {
    _instance.showOverlay = showOverlay ?? false;

    Widget w = _instance.errorWidget ??
        Icon(
          Icons.clear,
          color: ToastTheme.indicatorColor,
          size: ToastTheme.indicatorSize,
        );
    return _instance._show(
      message: message,
      duration: duration ?? ToastTheme.displayDuration,
      toastPosition: toastPosition ?? ToastTheme.toastPosition,
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  /// show custom info with [message] [duration]
  static Future<void> info({
    String? message,
    Duration? duration,
    ToastPosition? toastPosition,
    bool? dismissOnTap,
    bool? showOverlay,
  }) {
    _instance.showOverlay = showOverlay ?? false;

    Widget w = _instance.infoWidget ??
        Icon(
          Icons.info_outline,
          color: ToastTheme.indicatorColor,
          size: ToastTheme.indicatorSize,
        );
    return _instance._show(
      message: message,
      duration: duration ?? ToastTheme.displayDuration,
      toastPosition: toastPosition ?? ToastTheme.toastPosition,
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  /// dismiss toast
  static Future<void> clear({
    bool animation = true,
  }) {
    // cancel timer
    _instance._cancelTimer();
    return _instance._clear(animation);
  }

  /// show [message] [duration] [toastPosition]
  Future<void> _show({
    Widget? w,
    String? message,
    Duration? duration,
    bool? dismissOnTap,
    ToastPosition? toastPosition,
  }) async {
    assert(
      overlayEntry != null,
      'You should call Toast.init() in your MaterialApp',
    );

    toastPosition ??= ToastPosition.middle;
    bool animation = _w == null;
    if (_key != null) await clear(animation: false);

    Completer<void> completer = Completer<void>();
    _key = GlobalKey<ToastContainerState>();
    _w = ToastContainer(
      key: _key,
      message: message,
      indicator: w,
      animation: animation,
      toastPosition: toastPosition,
      dismissOnTap: dismissOnTap,
      completer: completer,
    );
    completer.future.whenComplete(() {
      if (duration != null) {
        _cancelTimer();
        _timer = Timer(duration, () async {
          await clear();
        });
      }
    });
    _markNeedsBuild();
    return completer.future;
  }

  Future<void> _clear(bool animation) async {
    if (key != null && key?.currentState == null) {
      _reset();
      return;
    }

    return key?.currentState?.dismiss(animation).whenComplete(() {
      _reset();
    });
  }

  void _reset() {
    _w = null;
    _key = null;
    _cancelTimer();
    _markNeedsBuild();
  }

  void _markNeedsBuild() {
    overlayEntry?.markNeedsBuild();
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
