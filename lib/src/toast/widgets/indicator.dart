//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';

import '../theme.dart';

class ToastIndicator extends StatefulWidget {
  const ToastIndicator({
    Key? key,
  }) : super(key: key);

  @override
  _ToastIndicatorState createState() => _ToastIndicatorState();
}

class _ToastIndicatorState extends State<ToastIndicator> {
  final double _size = ToastTheme.indicatorSize;

  /// indicator color of loading
  final Color _indicatorColor = ToastTheme.indicatorColor;
  late Widget _indicator;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = _size;
    // 也可基于flutter_spinkit实现
    // _indicator = SpinKitRing(
    //   color: _indicatorColor,
    //   size: _size,
    //   lineWidth: ToastTheme.indicatorLineWidth,
    // );

    //加载动画
    _indicator = CircularProgressIndicator(
      strokeWidth: ToastTheme.indicatorLineWidth,
      valueColor: AlwaysStoppedAnimation(_indicatorColor),
    );

    return Container(
      constraints: BoxConstraints(
        maxWidth: _width,
      ),
      child: _indicator,
    );
  }
}
