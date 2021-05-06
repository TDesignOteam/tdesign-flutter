import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class IconsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(), title: 'Icon',);
  }

  Widget _widget() {
    return Icon(TDIcons.add);
  }
}
