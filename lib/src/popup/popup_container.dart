//  Created by thomasfan, 11Jul21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';

typedef PopupVoidCallBack = void Function();

class PopupContainer extends StatefulWidget {
  PopupContainer({
    Key? key,
    required this.child,
    required this.onBgTap,
    required this.alignment,
    required this.animationDuration,
    required this.maskColor,
  }) : super(key: key);

  /// 内容widget
  final Widget child;

  /// 点击背景
  final PopupVoidCallBack onBgTap;

  /// 内容控件方向
  final AlignmentGeometry alignment;

  /// 动画时间
  final Duration animationDuration;

  /// 遮罩颜色
  final Color maskColor;

  @override
  PopupContainerState createState() => PopupContainerState();
}

class PopupContainerState extends State<PopupContainer> with SingleTickerProviderStateMixin {
  late double _opacity;

  late AnimationController _controller;

  Offset? _offset;

  @override
  void initState() {
    // 处理背景动画和内容widget动画设置
    _opacity = 0.0;
    _controller = AnimationController(vsync: this, duration: widget.animationDuration);
    _controller.forward();
    _dealContentAnimate();

    // 开启背景动画的效果
    Future.delayed(Duration(milliseconds: 10), () {
      _opacity = 1.0;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBg(children: [
      // 灰色背景widget动画
      _buildBgAnimation(),

      // 构建内容Widget动画
      Align(
        alignment: widget.alignment,
        child: _buildBodyAnimation(),
      ),
    ]);
  }

  AnimatedOpacity _buildBgAnimation() {
    return AnimatedOpacity(
      duration: widget.animationDuration,
      curve: Curves.linear,
      opacity: _opacity,
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerUp: (event) async {
          widget.onBgTap();
        },
        child: Container(
          // 若指定color为空则背景遮罩变成透明，相当于设置穿透遮罩背景，点击能穿透背景（penetrate）。
          color: widget.maskColor,
        ),
      ),
    );
  }

  Widget _buildBodyAnimation() {
    return widget.alignment == Alignment.center
        // 中间弹窗采用缩放动画
        ? ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Curves.linear,
            ),
            child: widget.child,
          )
        // 其它位置弹窗使用位移动画
        : SlideTransition(
            position: Tween<Offset>(
              begin: _offset,
              end: Offset.zero,
            ).animate(_controller),
            child: widget.child,
          );
  }

  Widget _buildBg({required List<Widget> children}) {
    return Container(
      child: Stack(
        children: children,
      ),
    );
  }

  ///处理下内容widget动画方向
  void _dealContentAnimate() {
    AlignmentGeometry? alignment = widget.alignment;
    _offset = Offset(0, 0);

    if (alignment == Alignment.bottomCenter ||
        alignment == Alignment.bottomLeft ||
        alignment == Alignment.bottomRight) {
      //靠下
      _offset = Offset(0, 1);
    } else if (alignment == Alignment.topCenter || alignment == Alignment.topLeft || alignment == Alignment.topRight) {
      //靠上
      _offset = Offset(0, -1);
    } else if (alignment == Alignment.centerLeft) {
      //靠左
      _offset = Offset(-1, 0);
    } else if (alignment == Alignment.centerRight) {
      //靠右
      _offset = Offset(1, 0);
    } else {
      //居中使用缩放动画,空结构体,不需要操作
    }
  }

  ///等待动画结束,关闭动画资源
  Future<void> dismiss() async {
    //背景结束动画
    setState(() {
      _opacity = 0.0;
    });

    //内容widget结束动画
    _controller.reverse();

    await Future.delayed(widget.animationDuration);
  }

  @override
  void dispose() {
    //关闭资源
    _controller.dispose();
    super.dispose();
  }
}
