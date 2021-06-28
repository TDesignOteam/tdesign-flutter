//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';

import 'message.dart';
import 'config.dart';
import 'widgets/animation.dart';
import 'package:tdesign/tdesign.dart'; // TDColors

// 考虑适配主题
class MessageTheme {
  /// background color of message
  static Color get backgroundColor {
    Color backColor = MessageConfig.backgroundColor; // default
    switch (Message.instance.msgType) {
      case MessageType.info:
        backColor = TDColors.blue;
        break;
      case MessageType.success:
        backColor = TDColors.green;
        break;
      case MessageType.warning:
        backColor = TDColors.orange;
        break;
      case MessageType.error:
        backColor = TDColors.red;
        break;
    }

    return backColor;
  }

  /// font color of message
  static Color get textColor => MessageConfig.textColor;

  /// mask color of message
  static Color get maskColor {
    // false or null
    return MessageConfig.maskColor;
  }

  /// message animation
  static MessageAnimation get messageAnimation {
    MessageAnimation _animation = SlideMessageAnimation();
    return _animation;
  }

  /// font size of message
  static double get fontSize => Message.instance.fontSize;

  /// message alignment
  static MessageAlignment get msgAlignment => Message.instance.msgAlignment;

  /// message position
  static AlignmentGeometry alignment(MessagePosition? position) =>
      position == MessagePosition.bottom
          ? AlignmentDirectional.bottomCenter
          : (position == MessagePosition.top
              ? AlignmentDirectional.topCenter
              : AlignmentDirectional.center);

  /// display duration
  static Duration get displayDuration => Message.instance.displayDuration;

  /// animation duration
  static Duration get animationDuration => Message.instance.animationDuration;

  /// contentPadding of loading
  static EdgeInsets get contentPadding => Message.instance.contentPadding;

  /// padding of message
  static EdgeInsets get textPadding => Message.instance.textPadding;

  /// textAlign of message
  static TextAlign get textAlign => Message.instance.textAlign;

  /// textStyle of message
  static TextStyle? get textStyle => Message.instance.textStyle;

  /// radius of loading
  static double get radius => Message.instance.radius;

  /// should dismiss on user tap
  static bool? get dismissOnTap => Message.instance.dismissOnTap;

  /// 当显示背景遮罩时，禁止背景点击和滚动
  static bool get ignoring => true;
}
