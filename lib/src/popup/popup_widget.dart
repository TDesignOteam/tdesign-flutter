//  Created by thomasfan, 11Jul21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';

import 'popup.dart';

class FlutterPopup extends StatelessWidget {
  FlutterPopup({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Overlay(initialEntries: [
        // 主体布局
        OverlayEntry(builder: (BuildContext context) => child ?? Container()),
        // 添加的控件，覆盖在主体布局之上
        Popup.instance.overlayEntry,
      ]),
    );
  }
}
