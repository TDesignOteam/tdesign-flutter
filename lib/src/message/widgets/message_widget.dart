//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';

import '../message.dart';
import 'message_overlayentry.dart';

class FlutterMessage extends StatefulWidget {
  final Widget? child;

  const FlutterMessage({
    Key? key,
    required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  _FlutterMessageState createState() => _FlutterMessageState();
}

class _FlutterMessageState extends State<FlutterMessage> {
  late MessageOverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = MessageOverlayEntry(
      builder: (BuildContext context) => TDMessage.instance.w ?? Container(),
    );
    TDMessage.instance.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          MessageOverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
          _overlayEntry,
        ],
      ),
    );
  }
}
