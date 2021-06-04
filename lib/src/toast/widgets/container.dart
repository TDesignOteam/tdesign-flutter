//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../theme.dart';
import '../toast.dart';

class ToastContainer extends StatefulWidget {
  final Widget? indicator;
  final String? message;
  final bool? dismissOnTap;
  final ToastPosition? toastPosition;
  final Completer<void>? completer;
  final bool animation;

  const ToastContainer({
    Key? key,
    this.indicator,
    this.message,
    this.dismissOnTap,
    this.toastPosition,
    this.completer,
    this.animation = true,
  }) : super(key: key);

  @override
  ToastContainerState createState() => ToastContainerState();
}

class ToastContainerState extends State<ToastContainer>
    with SingleTickerProviderStateMixin {
  String? _message;
  Color? _maskColor;
  late AnimationController _animationController;
  late AlignmentGeometry _alignment;
  late bool _dismissOnTap, _ignoring;

  bool get isPersistentCallbacks =>
      SchedulerBinding.instance?.schedulerPhase ==
      SchedulerPhase.persistentCallbacks;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _message = widget.message;
    _alignment = ToastTheme.alignment(widget.toastPosition);
    _dismissOnTap = widget.dismissOnTap ?? (ToastTheme.dismissOnTap ?? false);
    _ignoring = _dismissOnTap ? false : ToastTheme.ignoring;
    _maskColor = ToastTheme.maskColor;
    _animationController = AnimationController(
      vsync: this,
      duration: ToastTheme.animationDuration,
    )..addStatusListener((status) {
        bool isCompleted = widget.completer?.isCompleted ?? false;
        if (status == AnimationStatus.completed && !isCompleted) {
          widget.completer?.complete();
        }
      });
    show(widget.animation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> show(bool animation) {
    if (isPersistentCallbacks) {
      Completer<void> completer = Completer<void>();
      SchedulerBinding.instance?.addPostFrameCallback((_) => completer
          .complete(_animationController.forward(from: animation ? 0 : 1)));
      return completer.future;
    } else {
      return _animationController.forward(from: animation ? 0 : 1);
    }
  }

  Future<void> dismiss(bool animation) {
    if (isPersistentCallbacks) {
      Completer<void> completer = Completer<void>();
      SchedulerBinding.instance?.addPostFrameCallback((_) => completer
          .complete(_animationController.reverse(from: animation ? 1 : 0)));
      return completer.future;
    } else {
      return _animationController.reverse(from: animation ? 1 : 0);
    }
  }

  void _onTap() async {
    if (_dismissOnTap) {
      await Toast.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: _alignment,
      children: <Widget>[
        AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: _animationController.value,
              child: IgnorePointer(
                ignoring: _ignoring,
                child: _dismissOnTap
                    ? GestureDetector(
                        onTap: _onTap,
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: _maskColor,
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: _maskColor,
                      ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return ToastTheme.toastAnimation.buildWidget(
              _Indicator(
                message: _message,
                indicator: widget.indicator,
              ),
              _animationController,
              _alignment,
            );
          },
        ),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  final Widget? indicator;
  final String? message;

  const _Indicator({
    required this.indicator,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    if (indicator == null) {
      // 文本轻提示: message?.isNotEmpty == true
      return Container(
        margin: const EdgeInsets.all(50.0),
        decoration: BoxDecoration(
          color: ToastTheme.backgroundColor,
          borderRadius: BorderRadius.circular(
            ToastTheme.radius,
          ),
        ),
        padding: ToastTheme.contentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (message?.isNotEmpty == true)
              Text(
                message!,
                style: ToastTheme.textStyle ??
                    TextStyle(
                      color: ToastTheme.textColor,
                      fontSize: ToastTheme.fontSize,
                    ),
                textAlign: ToastTheme.textAlign,
              ),
          ],
        ),
      );
    } else {
      var sideLength = 0.0;
      if (message?.isNotEmpty == true) {
        // 文本加图标轻提示
        sideLength = 104.0;
      } else {
        // 图标轻提示
        sideLength = 88.0;
      }
      return Container(
        margin: const EdgeInsets.all(50.0),
        width: sideLength,
        height: sideLength,
        decoration: BoxDecoration(
          color: ToastTheme.backgroundColor,
          borderRadius: BorderRadius.circular(
            ToastTheme.radius,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (indicator != null)
              Container(
                margin: message?.isNotEmpty == true
                    ? ToastTheme.textPadding
                    : EdgeInsets.zero,
                child: indicator,
              ),
            if (message?.isNotEmpty == true)
              Text(
                message!,
                style: ToastTheme.textStyle ??
                    TextStyle(
                      color: ToastTheme.textColor,
                      fontSize: ToastTheme.fontSize,
                    ),
                textAlign: ToastTheme.textAlign,
              ),
          ],
        ),
      );
    }
  }
}
