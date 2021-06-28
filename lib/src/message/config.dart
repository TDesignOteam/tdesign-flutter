//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'message.dart';

///控件默认配置
class MessageConfig {
  /// message theme style.
  // static MessageThemeStyle themeStyle = MessageThemeStyle.dark;

  /// message type.
  static MessageType msgType = MessageType.info;

  /// message position.
  static MessagePosition msgPosition = MessagePosition.top;

  /// message alignment.
  static MessageAlignment msgAlignment = MessageAlignment.left;

  /// animation duration of indicator.
  static Duration animationDuration = const Duration(milliseconds: 200);

  /// display duration of message
  static Duration displayDuration = const Duration(milliseconds: 2000);

  /// background color of message.
  static Color backgroundColor = Colors.black.withOpacity(0.6);

  /// radius of message.
  static double radius = 4.0;

  /// mask color of loading.
  static Color maskColor = Colors.transparent;

  /// fontSize of message.
  static double fontSize = 14.0;

  /// color of message message.
  static Color textColor = Colors.white;

  /// should dismiss on user tap.
  static bool dismissOnTap = false;
}
