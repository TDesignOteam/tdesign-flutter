//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../theme.dart';
import '../message.dart';

class MessageContainer extends StatefulWidget {
  final bool showIcon;
  final String message;
  final MessageType msgType;
  final MessagePosition msgPosition;
  final MessageAlignment msgAlignment;
  final bool? dismissOnTap;
  final Completer<void>? completer;
  final bool animation;

  const MessageContainer({
    Key? key,
    required this.showIcon,
    required this.message,
    required this.msgType,
    required this.msgPosition,
    required this.msgAlignment,
    this.dismissOnTap,
    this.completer,
    this.animation = true,
  }) : super(key: key);

  @override
  MessageContainerState createState() => MessageContainerState();
}

class MessageContainerState extends State<MessageContainer>
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
    _alignment = MessageTheme.alignment(widget.msgPosition);
    _dismissOnTap = widget.dismissOnTap ?? (MessageTheme.dismissOnTap ?? false);
    _ignoring = _dismissOnTap ? false : MessageTheme.ignoring;
    _maskColor = MessageTheme.maskColor;
    _animationController = AnimationController(
      vsync: this,
      duration: MessageTheme.animationDuration,
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
      await Message.clear();
    }
  }

  Widget _buildComponents() {
    MainAxisAlignment alignment = MainAxisAlignment.start;
    switch (widget.msgAlignment) {
      case MessageAlignment.left:
        alignment = MainAxisAlignment.start;
        break;
      case MessageAlignment.center:
        alignment = MainAxisAlignment.center;
        break;
      case MessageAlignment.right:
        alignment = MainAxisAlignment.end;
        break;
    }

    if (widget.showIcon) {
      return Row(
          mainAxisAlignment: alignment,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              widget.msgType == MessageType.success
                  ? Icons.check_circle
                  : Icons.info,
              size: 20,
              color: Colors.white,
            ),
            Flexible(
              child: new Container(
                padding: new EdgeInsets.only(left: 12.0),
                child: Text(
                  _message!,
                  style: MessageTheme.textStyle ??
                      TextStyle(
                        color: MessageTheme.textColor,
                        fontSize: MessageTheme.fontSize,
                      ),
                  textAlign: MessageTheme.textAlign,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ]);
    } else {
      return Row(
          mainAxisAlignment: alignment,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Text(
                _message!,
                style: MessageTheme.textStyle ??
                    TextStyle(
                      color: MessageTheme.textColor,
                      fontSize: MessageTheme.fontSize,
                    ),
                textAlign: MessageTheme.textAlign,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]);
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
            return MessageTheme.messageAnimation.buildWidget(
              Padding(
                padding: const EdgeInsets.only(
                    top: 44.0, left: 16.0, right: 16.0), // 容器两侧边距
                child: Container(
                  // width: MediaQuery.of(context).size.width - 2 * 16,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: MessageTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(
                      MessageTheme.radius,
                    ),
                  ),
                  padding: MessageTheme.contentPadding, // 内容两侧边距
                  child: _buildComponents(),
                ),
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
