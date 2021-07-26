//  Created by jamsun, 22Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/theme/td_text_style.dart';

import '../../tdesign.dart';
import 'button_base.dart';

class TDButton extends StatelessWidget {
  /// 基本属性

  ///点击
  ///如果没有点击时间则是禁用状态
  ///
  /// 暂时没处理 又没有点击事件  又是正常样式的场景。
  ///
  final VoidCallback? onClick;

  ///是否有左侧icon
  ///
  /// 内部有最小间距 如果需要更大的艰巨则自己在传入的Widget进行设置。
  ///
  final Widget? icon;

  ///按钮文字
  final String text;

  ///文字样式
  final TextStyle? textStyle;

  ///按钮尺寸
  final TDButtonSize size;

  ///是否有圆角
  final BorderRadiusGeometry radius;

  ///文字样式
  final TDButtonStyle style;

  TDButton(
      {this.onClick,
      Key? key,
      required this.text,
      this.style = TDButtonStyle.normal,
      this.icon,
      this.textStyle,
      this.size = TDButtonSize.mid,
      this.radius = const BorderRadius.all(
        Radius.circular(4),
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = textStyle ?? _getTextStyle(context);
    TDTheme? theme = TDTheme.of(context);
    Color? tapColor = theme?.themeColor.tapColor;
    var contentWidget = <Widget>[];
    if (icon != null) {
      //默认是最小8dp的间距，需要增加则自行在传入Widget处增加。
      contentWidget.add(Padding(
        padding: tdButtonBase.buttonIconEdge,
        child: icon!,
      ));
    }
    contentWidget.add(Text(text, style: style));
    //如果是mid或者large的按钮 则直接充满全部，然后内容居中
    var midOrLarge = (size == TDButtonSize.large || size == TDButtonSize.mid);
    return Material(
      borderRadius: _getRadius(context),
      color: _getColor(context),
      shape: _getShapeBorder(context),
      child: InkResponse(
        onTap: onClick,
        //radius 0 关闭水波纹
        radius: 0.0,
        //加按压颜色
        highlightColor: tapColor,
        highlightShape: BoxShape.rectangle,
        child: Padding(
          padding: tdButtonBase.getEdgeBySize(size),
          child: Row(
            mainAxisSize: midOrLarge ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: midOrLarge ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: contentWidget,
          ),
        ),
      ),
    );
  }

  //文字颜色
  TextStyle _getTextStyle(BuildContext context) {
    if (style == TDButtonStyle.normal || style == TDButtonStyle.warn) {
      if (size == TDButtonSize.large) {
        return tdTextStyle.r16AntiText(context);
      }
      return tdTextStyle.r14AntiText(context);
    } else if (style == TDButtonStyle.stroke || style == TDButtonStyle.ghost || style == TDButtonStyle.text) {
      if (size == TDButtonSize.large) {
        if (onClick != null) {
          return tdTextStyle.r16Primary(context);
        } else {
          return tdTextStyle.r16PrimaryButtonDisable(context);
        }
      }
      if (onClick != null) {
        return tdTextStyle.r14Primary(context);
      } else {
        return tdTextStyle.r14PrimaryButtonDisable(context);
      }
    } else if (style == TDButtonStyle.secondary) {
      if (onClick != null) {
        return tdTextStyle.r14Text(context);
      } else {
        return tdTextStyle.r14Text(context, textLevel: 4);
      }
    } else if (style == TDButtonStyle.warnStroke) {
      if (onClick != null) {
        return tdTextStyle.r14Error(context);
      } else {
        return tdTextStyle.r14ErrorDisable(context);
      }
    }
    return tdTextStyle.r14AntiText(context);
  }

  //颜色
  Color? _getColor(BuildContext context) {
    if (style == TDButtonStyle.normal) {
      if (onClick != null) {
        return TDTheme.of(context)?.themeColor.primaryColor ?? TDColors.blue;
      } else {
        return TDTheme.of(context)?.themeColor.buttonDisablePrimary ?? TDColors.blue.shade3;
      }
    } else if (style == TDButtonStyle.warn) {
      if (onClick != null) {
        return TDTheme.of(context)?.themeColor.errorColor ?? TDColors.red;
      } else {
        return TDTheme.of(context)?.themeColor.errorColorDisabled ?? TDColors.red.shade3;
      }
    } else if (style == TDButtonStyle.warn) {
      if (onClick != null) {
        return TDTheme.of(context)?.themeColor.errorColor ?? TDColors.red;
      } else {
        return TDTheme.of(context)?.themeColor.errorColorDisabled ?? TDColors.red.shade3;
      }
    } else if (style == TDButtonStyle.ghost) {
      return Colors.transparent;
    }
    return Colors.white;
  }

  //圆角
  BorderRadiusGeometry? _getRadius(BuildContext context) {
    if (style == TDButtonStyle.normal || style == TDButtonStyle.warn) {
      return radius;
    }
    return null;
  }

  //如果不是实体按钮时候的描边框背景
  ShapeBorder? _getShapeBorder(BuildContext context) {
    if (style == TDButtonStyle.secondary) {
      Color shapeColor = TDTheme.of(context)?.themeColor.secondaryButtonStroke ?? TDColors.fontBlack;
      return RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: shapeColor, style: BorderStyle.solid, width: tdButtonBase.buttonStrokeWidth));
    } else if (style == TDButtonStyle.stroke || style == TDButtonStyle.ghost) {
      Color disableColor = TDTheme.of(context)?.themeColor.buttonDisablePrimary ?? TDColors.blue.shade3;
      Color primaryColor = TDTheme.of(context)?.themeColor.primaryColor ?? TDColors.blue;
      return RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
              color: (onClick == null) ? disableColor : primaryColor,
              style: BorderStyle.solid,
              width: tdButtonBase.buttonStrokeWidth));
    } else if (style == TDButtonStyle.warnStroke) {
      Color disableColor = TDTheme.of(context)?.themeColor.errorColorDisabled ?? TDColors.red.shade3;
      Color primaryColor = TDTheme.of(context)?.themeColor.errorColor ?? TDColors.red;
      return RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
              color: (onClick == null) ? disableColor : primaryColor,
              style: BorderStyle.solid,
              width: tdButtonBase.buttonStrokeWidth));
    }
    return null;
  }

  /// todo 是否考虑用这样的构造去写好一点。
  // /// 描边按钮的工厂方法.
  // factory TDButton.stroke(
  // }

  // const TDButton.raw({
  //   required this.style,
  //   required this.onClick,
  //   required this.icon,
  //   required this.text,
  //   required this.textStyle,
  //   required this.size,
  //   required this.radius,
  // });
}
