//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ToastOverlayEntry extends OverlayEntry {
  final WidgetBuilder builder;

  ToastOverlayEntry({
    required this.builder,
  }) : super(builder: builder);

  @override
  void markNeedsBuild() {
    if (SchedulerBinding.instance?.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        super.markNeedsBuild();
      });
    } else {
      super.markNeedsBuild();
    }
  }
}
