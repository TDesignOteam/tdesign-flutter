//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

/// Toast轻提示控件
///
/// 实现参考了 [flutter_easyloading](https://pub.dev/packages/flutter_easyloading)

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tdesign/src/toast/toast_config.dart';

import 'widgets/toast_container.dart';
import 'widgets/toast_indicator.dart';
import 'widgets/toast_overlayentry.dart';
import 'widgets/toast_widget.dart';
import 'toast_theme.dart';

/// toast theme style
// enum ToastThemeStyle {
//   dark,
//   light,
//   custom,
// }

/// toast position
enum TDToastPosition {
  top,
  middle,
  bottom,
}

class TDToast {
  /// toast theme style.
  // late ToastThemeStyle themeStyle;

  /// toast position.
  late TDToastPosition toastPosition;

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

  factory TDToast() => _instance;
  static final TDToast _instance = TDToast._internal();

  TDToast._internal() {
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

  static TDToast get instance => _instance;
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
    TDToastPosition? toastPosition,
    bool? dismissOnTap,
    bool? showOverlay,
  }) {
    _instance.showOverlay = showOverlay ?? false;

    return _instance._show(
      message: message,
      duration: duration ?? ToastConfig.displayDuration,
      toastPosition: toastPosition ?? ToastConfig.toastPosition,
      dismissOnTap: dismissOnTap,
    );
  }

  /// show loading with [message] [indicator]
  static Future<void> loading({
    String? message,
    Duration? duration,
    TDToastPosition? toastPosition,
    Widget? indicator,
    bool? dismissOnTap,
    bool? showOverlay,
  }) {
    _instance.showOverlay = showOverlay ?? false;

    Widget w = indicator ?? (_instance.indicatorWidget ?? ToastIndicator());
    return _instance._show(
      message: message,
      duration: duration ?? ToastConfig.displayDuration,
      toastPosition: toastPosition ?? ToastConfig.toastPosition,
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  /// show success with [message] [duration]
  static Future<void> success({
    String? message,
    Duration? duration,
    TDToastPosition? toastPosition,
    bool? dismissOnTap,
    bool? showOverlay,
  }) {
    _instance.showOverlay = showOverlay ?? false;

    Widget w = _instance.successWidget ??
        Icon(
          Icons.done, // Icons.check,
          color: ToastTheme.indicatorColor,
          size: ToastTheme.indicatorSize,
        );
    return _instance._show(
      message: message,
      duration: duration ?? ToastConfig.displayDuration,
      toastPosition: toastPosition ?? ToastConfig.toastPosition,
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  /// show fail with [message] [duration]
  static Future<void> fail({
    String? message,
    Duration? duration,
    TDToastPosition? toastPosition,
    bool? dismissOnTap,
    bool? showOverlay,
  }) {
    _instance.showOverlay = showOverlay ?? false;

    Widget w = _instance.errorWidget ??
        Icon(
          Icons.priority_high,
          color: ToastTheme.indicatorColor,
          size: ToastTheme.indicatorSize,
        );
    return _instance._show(
      message: message,
      duration: duration ?? ToastConfig.displayDuration,
      toastPosition: toastPosition ?? ToastConfig.toastPosition,
      dismissOnTap: dismissOnTap,
      w: w,
    );
  }

  /// show custom info with [message] [duration]
  static Future<void> info({
    String? message,
    Duration? duration,
    TDToastPosition? toastPosition,
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
      duration: duration ?? ToastConfig.displayDuration,
      toastPosition: toastPosition ?? ToastConfig.toastPosition,
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
    TDToastPosition? toastPosition,
  }) async {
    assert(
      overlayEntry != null,
      'You should call Toast.init() in your MaterialApp',
    );

    toastPosition ??= TDToastPosition.middle;
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
