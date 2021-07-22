//  Created by jamsun, 22Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/theme/td_text_style.dart';

import '../../tdesign.dart';
import 'button_base.dart';

class TDStrokeButton extends StatelessWidget {
  /// 基本属性

  ///点击   如果没有点击时间则是禁用状态
  final VoidCallback? onClick;

  ///是否有左侧icon   传入最不带间距的Widget使用。间距统一内部处理。
  final Widget? icon;

  ///按钮文字
  final String text;

  ///文字样式
  final TextStyle? textStyle;

  ///文字大小
  final TDButtonSize size;

  ///是否有圆角
  final BorderRadiusGeometry? radius;

  TDStrokeButton(
      {this.onClick,
      Key? key,
      required this.text,
      this.icon,
      this.textStyle,
      this.size = TDButtonSize.mid,
      this.radius = const BorderRadius.all(
        Radius.circular(4),
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = textStyle ?? getTextStyle(size, context);
    TDTheme? theme = TDTheme.of(context);
    Color? tapColor = theme?.themeColor.tapColor;
    Color? primaryColor = theme?.themeColor.primaryColor;
    Color? disableColor = theme?.themeColor.buttonDisablePrimary;
    var contentWidget = <Widget>[];
    if (icon != null) {
      //默认是最小2dp的间距，需要增加则自行在传入Widget处增加。
      contentWidget.add(Padding(
        padding: tdButtonBase.buttonIconEdge,
        child: icon!,
      ));
    }
    contentWidget.add(Text(text, style: style));
    var midOrLarge = (size == TDButtonSize.large || size == TDButtonSize.mid);
    return Ink(
      decoration: BoxDecoration(color: (onClick == null) ? disableColor : primaryColor, borderRadius: radius),
      //正常背景
      child: InkResponse(
        onTap: onClick,
        //radius 0 关闭水波纹
        radius: 0.0,
        //加按压颜色
        highlightColor: tapColor,
        highlightShape: BoxShape.rectangle,
        child: Padding(
          padding: tdButtonBase.getEdgeBySize(size),
          child: midOrLarge
              ? Center(
                  child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: contentWidget,
                ))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: contentWidget,
                ),
        ),
      ),
    );
  }

  TextStyle getTextStyle(TDButtonSize size, BuildContext context) {
    if (size == TDButtonSize.large) {
      return tdTextStyle.r16AntiText(context);
    }
    return tdTextStyle.r14AntiText(context);
  }

  TextStyle getDecoration(TDButtonSize size, BuildContext context) {
    if (size == TDButtonSize.large) {
      return tdTextStyle.r16AntiText(context);
    }
    return tdTextStyle.r14AntiText(context);
  }
}
