import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdesign/tdesign.dart';

import 'responsive_layout/responsive_layout.dart';

/// 示例页的统一框架
class ExamplePage extends StatefulWidget {
  final Widget child;
  final String title;
  final Color backgroundColor;
  final Color titleColor;
  ExamplePage(
      {required this.child,
      required this.title,
      this.backgroundColor = TDColors.blue,
      this.titleColor = TDColors.fontWhite});

  @override
  State<StatefulWidget> createState() {
    return ExamplePageState();
  }
}

class ExamplePageState extends State<ExamplePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<StyleModel>(
      builder: (context, style, _) => Scaffold(
        appBar: AppBar(
          leading: 
            GestureDetector(
            child: style.layout != LayoutStyle.single ? Icon(TDIcons.swap) : Icon(TDIcons.arrowLeft),
            onTap: style.layout != LayoutStyle.single ? () => Provider.of<StyleModel>(ResponsiveConfig.key.currentContext!, listen: false)
                .toggleDetail(ResponsiveConfig.key.currentContext, this) : () => DetailModel.pop(context, this)
          ),
          backgroundColor: widget.backgroundColor,
          iconTheme: IconThemeData(color: widget.titleColor),
          title: Text(
            widget.title,
            style: TextStyle(color: widget.titleColor),
          ),
        ),
        body: widget.child,
      ),
    );
  }
}

class PageUtil {
  static Widget buildSubTitle(String text, {double height = 60}) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Text(text, style: TextStyle(fontSize: 17, color: Colors.grey)),
      ),
    );
  }

  static Widget buildTile(BuildContext context, Widget child,
      {double? height, Alignment alignment = Alignment.centerLeft}) {
    return Container(
      color: Theme.of(context).dialogBackgroundColor,
      height: height,
      alignment: alignment,
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: child),
    );
  }

  static Widget outlinedButton(
    String btnTitle,
    VoidCallback callback,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0),
      child: OutlinedButton(
          child: Text(
            btnTitle,
            style:
                TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
          ),
          style: ButtonStyle(),
          onPressed: callback),
    );
  }
}
