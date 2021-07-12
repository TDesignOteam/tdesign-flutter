//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';

import 'message.dart';
import 'message_config.dart';
import 'widgets/message_animation.dart';
import 'package:tdesign/tdesign.dart'; // TDColors

// 考虑适配主题
class MessageTheme {
  /// background color of message
  static Color get backgroundColor {
    Color backColor = MessageConfig.backgroundColor; // default
    switch (TDMessage.instance.msgType) {
      case TDMessageType.info:
        backColor = TDColors.blue;
        break;
      case TDMessageType.success:
        backColor = TDColors.green;
        break;
      case TDMessageType.warning:
        backColor = TDColors.orange;
        break;
      case TDMessageType.error:
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
  static double get fontSize => TDMessage.instance.fontSize;

  /// message alignment
  static TDMessageAlignment get msgAlignment => TDMessage.instance.msgAlignment;

  /// message position
  static AlignmentGeometry alignment(TDMessagePosition? position) => position == TDMessagePosition.bottom
      ? AlignmentDirectional.bottomCenter
      : (position == TDMessagePosition.top ? AlignmentDirectional.topCenter : AlignmentDirectional.center);

  /// display duration
  static Duration get displayDuration => TDMessage.instance.displayDuration;

  /// animation duration
  static Duration get animationDuration => TDMessage.instance.animationDuration;

  /// contentPadding of loading
  static EdgeInsets get contentPadding => TDMessage.instance.contentPadding;

  /// padding of message
  static EdgeInsets get textPadding => TDMessage.instance.textPadding;

  /// textAlign of message
  static TextAlign get textAlign => TDMessage.instance.textAlign;

  /// textStyle of message
  static TextStyle? get textStyle => TDMessage.instance.textStyle;

  /// radius of loading
  static double get radius => TDMessage.instance.radius;

  /// should dismiss on user tap
  static bool? get dismissOnTap => TDMessage.instance.dismissOnTap;

  /// 当显示背景遮罩时，禁止背景点击和滚动
  static bool get ignoring => true;
}
