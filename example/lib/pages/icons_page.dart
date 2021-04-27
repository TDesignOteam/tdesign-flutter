import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class IconsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Icons')), body: SafeArea(bottom: false, child: _widget()));
  }

  Widget _widget() {
    return Icon(TDIcons.add);
  }
}
