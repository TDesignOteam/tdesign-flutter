import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

/// 示例页的统一框架
class ExamplePage extends StatelessWidget {
  final Widget child;
  final String title;
  ExamplePage({required this.child, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: TDColors.blue, title: Text(title)),
        body: SafeArea(bottom: false, child: child));
  }
}
