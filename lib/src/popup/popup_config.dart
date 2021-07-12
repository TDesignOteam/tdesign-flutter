//  Created by thomasfan, 11Jul21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';

/// 控件配置
class PopupConfig {
  /// 控制自定义控件位于屏幕的位置
  ///
  /// Alignment.topCenter、Alignment.topLeft、Alignment.topRight：
  /// 自定义控件位于屏幕顶部，动画默认为位移动画，自上而下
  ///
  /// Alignment.bottomCenter、Alignment.bottomLeft、Alignment.bottomRight：
  /// 自定义控件位于屏幕底部，动画默认为位移动画，自下而上
  ///
  /// Alignment.center:
  /// 自定义控件位于屏幕中间，且是动画默认为缩放，也可修改为渐隐
  ///
  /// Alignment.centerLeft：
  /// 自定义控件位于屏幕左边，动画默认为位移动画，自左而右
  ///
  /// Alignment.centerRight：
  /// 自定义控件位于屏幕左边，动画默认为位移动画，自右而左
  AlignmentGeometry alignment = Alignment.center;

  /// 背景遮罩颜色
  Color maskColor = Colors.black.withOpacity(0.6);

  /// 设置动画时间
  Duration animationDuration = Duration(milliseconds: 200);
}
