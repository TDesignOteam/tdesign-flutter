//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';

import '../toast.dart';
import 'toast_overlayentry.dart';

class FlutterToast extends StatefulWidget {
  final Widget? child;

  const FlutterToast({
    Key? key,
    required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  _FlutterToastState createState() => _FlutterToastState();
}

class _FlutterToastState extends State<FlutterToast> {
  late ToastOverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = ToastOverlayEntry(
      builder: (BuildContext context) => TDToast.instance.w ?? Container(),
    );
    TDToast.instance.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          ToastOverlayEntry(
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
