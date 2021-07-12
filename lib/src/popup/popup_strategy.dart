//  Created by thomasfan, 11Jul21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'popup_config.dart';
import 'popup_container.dart';

class PopupStrategy {
  PopupStrategy({
    required this.config,
    required this.overlayEntry,
  }) : _widget = Container();

  /// OverlayEntry instance
  final OverlayEntry overlayEntry;

  /// config info
  final PopupConfig config;

  GlobalKey<PopupContainerState>? _key;
  Completer? _completer;
  VoidCallback? _onDismiss;
  Widget _widget;

  Future<void> show({
    required Widget widget,
    AlignmentGeometry? alignment,
    Duration? animationDuration,
    Color? maskColor,
    VoidCallback? onDismiss,
  }) async {
    _onDismiss = onDismiss;
    // 展示弹窗
    var globalKey = GlobalKey<PopupContainerState>();
    _widget = PopupContainer(
      key: globalKey,
      alignment: alignment ?? config.alignment,
      animationDuration: animationDuration ?? config.animationDuration,
      maskColor: maskColor ?? config.maskColor,
      child: widget,
      onBgTap: () => dismiss(),
    );
    overlayEntry.markNeedsBuild();

    _key = globalKey;
    _completer = Completer();
    return _completer!.future;
  }

  Future<void> dismiss() async {
    _widget = Container();
    _onDismiss?.call();

    var state = _key?.currentState;
    if (!(_completer?.isCompleted ?? true)) {
      _completer?.complete();
    }
    await state?.dismiss();

    overlayEntry.markNeedsBuild();
  }

  Widget getWidget() {
    return _widget;
  }
}
