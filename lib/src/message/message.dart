//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

/// Message轻提示控件
///
/// 实现参考了 [ai_awesome_message](https://pub.dev/packages/ai_awesome_message)

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tdesign/src/message/message_config.dart';

import 'widgets/message_container.dart';
import 'widgets/message_overlayentry.dart';
import 'widgets/message_widget.dart';

/// message theme style
// enum MessageThemeStyle {
//   dark,
//   light,
//   custom,
// }

/// message position
enum TDMessageType {
  info,
  success,
  warning,
  error,
  // question,
  // loading,
}

/// message position
enum TDMessagePosition {
  top,
  bottom,
}

/// message position
enum TDMessageAlignment {
  left,
  center,
  right,
}

class TDMessage {
  /// message theme style.
  // late MessageThemeStyle themeStyle;

  /// show icon.
  late bool showIcon;

  /// message type.
  late TDMessageType msgType;

  /// message position.
  late TDMessagePosition msgPosition;

  /// message alignment.
  late TDMessageAlignment msgAlignment;

  /// animation duration of indicator.
  late Duration animationDuration;

  /// display duration of [showSuccess] [showError] [showInfo] [showMessage]
  late Duration displayDuration;

  /// background color of message.
  late Color backgroundColor;

  /// radius of message.
  late double radius;

  /// mask color of message, pass to container.
  late Color maskColor;

  /// textAlign of message.
  late TextAlign textAlign;

  /// textStyle of message, default null.
  TextStyle? textStyle;

  /// fontSize of message.
  late double fontSize;

  /// color of message message.
  late Color textColor;

  /// content padding of message.
  late EdgeInsets contentPadding;

  /// padding of [message].
  late EdgeInsets textPadding;

  /// should dismiss on user tap.
  bool? dismissOnTap;

  Widget? _w;
  Widget? get w => _w;

  GlobalKey<MessageContainerState>? _key;
  GlobalKey<MessageContainerState>? get key => _key;

  MessageOverlayEntry? overlayEntry;
  Timer? _timer;

  factory TDMessage() => _instance;
  static final TDMessage _instance = TDMessage._internal();

  TDMessage._internal() {
    /// set deafult value
    msgType = MessageConfig.msgType;
    msgPosition = MessageConfig.msgPosition;
    msgAlignment = MessageConfig.msgAlignment;

    animationDuration = MessageConfig.animationDuration;
    displayDuration = MessageConfig.displayDuration;

    backgroundColor = MessageConfig.backgroundColor;
    radius = MessageConfig.radius;

    maskColor = MessageConfig.maskColor;

    // textStyle =
    fontSize = MessageConfig.fontSize;
    textColor = MessageConfig.textColor;
    textAlign = TextAlign.center;
    textPadding = const EdgeInsets.only(bottom: 10.0);
    contentPadding = const EdgeInsets.symmetric(
      horizontal: 16.0,
    );

    dismissOnTap = MessageConfig.dismissOnTap;
  }

  static TDMessage get instance => _instance;
  static bool get isShow => _instance.w != null;

  /// init FlutterMessage which build Material with Overlay(OverlayEntry)
  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, FlutterMessage(child: child));
      } else {
        return FlutterMessage(child: child);
      }
    };
  }

  /// message [message] [duration] [msgPosition]
  static Future<void> show(
    String message, {
    bool showIcon = true,
    TDMessageType? msgType,
    TDMessagePosition? msgPosition,
    TDMessageAlignment? msgAlignment,
    Duration? duration,
    bool? dismissOnTap,
  }) {
    return _instance._show(
      showIcon: showIcon,
      message: message,
      msgType: msgType ?? MessageConfig.msgType,
      msgPosition: msgPosition ?? MessageConfig.msgPosition,
      msgAlignment: msgAlignment ?? MessageConfig.msgAlignment,
      duration: duration ?? MessageConfig.displayDuration,
      dismissOnTap: dismissOnTap,
    );
  }

  /// dismiss message
  static Future<void> clear({
    bool animation = true,
  }) {
    // cancel timer
    _instance._cancelTimer();
    return _instance._clear(animation);
  }

  /// show [message] [duration] [msgPosition]
  Future<void> _show({
    required String message,
    required bool showIcon,
    required TDMessageType msgType,
    required TDMessagePosition msgPosition,
    required TDMessageAlignment msgAlignment,
    Duration? duration,
    bool? dismissOnTap,
  }) async {
    assert(
      overlayEntry != null,
      'You should call Message.init() in your MaterialApp',
    );

    _instance.showIcon = showIcon;
    _instance.msgType = msgType;
    _instance.msgPosition = msgPosition;
    _instance.msgAlignment = msgAlignment;

    bool animation = _w == null;
    if (_key != null) await clear(animation: false);

    Completer<void> completer = Completer<void>();
    _key = GlobalKey<MessageContainerState>();
    _w = MessageContainer(
      key: _key,
      showIcon: showIcon,
      message: message,
      msgType: msgType,
      msgPosition: msgPosition,
      msgAlignment: msgAlignment,
      dismissOnTap: dismissOnTap,
      completer: completer,
      animation: animation,
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
