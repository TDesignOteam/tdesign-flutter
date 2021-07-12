//  Created by thomasfan, 11Jul21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'popup_strategy.dart';
import 'popup_config.dart';
import 'popup_widget.dart';

class Popup {
  /// Popup相关配置，使用Config管理
  late PopupConfig config;

  late OverlayEntry overlayEntry;

  static late PopupStrategy _strategy;

  static Popup? _instance;

  factory Popup() => instance;

  static Popup get instance => _instance ??= Popup._internal();

  Popup._internal() {
    /// 初始化一些参数
    config = PopupConfig();
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return _strategy.getWidget();
      },
    );
    _strategy = PopupStrategy(config: config, overlayEntry: overlayEntry);
  }

  /// init FlutterPopup which build Material with Overlay(OverlayEntry)
  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, FlutterPopup(child: child));
      } else {
        return FlutterPopup(child: child);
      }
    };
  }

  /// 显示主体OverlayEntry
  ///
  /// 使用Temp为后缀的属性，在此处设置，并不会影响全局的属性，
  /// 未设置Temp为后缀的属性，则默认使用Config设置的全局属性。
  static Future<void> show({
    required Widget widget,
    AlignmentGeometry? alignmentTemp,
    Duration? animationDurationTemp,
    Color? maskColorTemp,
    VoidCallback? onDismiss,
  }) {
    return _strategy.show(
      widget: widget,
      alignment: alignmentTemp ?? instance.config.alignment,
      animationDuration: animationDurationTemp ?? instance.config.animationDuration,
      maskColor: maskColorTemp ?? instance.config.maskColor,
      onDismiss: onDismiss,
    );
  }

  /// 关闭主体OverlayEntry
  static Future<void> dismiss() async {
    _strategy.dismiss();
  }
}
