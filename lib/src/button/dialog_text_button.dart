//  Created by jamsun, 22Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/theme/td_text_style.dart';

import '../../tdesign.dart';
import 'button_base.dart';

class TDDialogTextButton extends StatelessWidget {
  ///点击效果
  final VoidCallback onClick;

  ///是否有左侧icon
  final Widget? icon;

  ///按钮文字
  final String? text;

  ///文字样式
  final TextStyle? textStyle;

  ///文字大小
  final TDButtonSize size;

  //外部传入的padding需要定制化
  final EdgeInsetsGeometry? padding;

  TDDialogTextButton(
      {required this.onClick,
      Key? key,
      this.text,
      this.icon,
      this.textStyle,
      this.size = TDButtonSize.mid,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle getTextStyle(TDButtonSize size) {
      if (size == TDButtonSize.large) {
        return tdTextStyle.r16Primary(context);
      } else if (size == TDButtonSize.mid) {
        return tdTextStyle.r16Primary(context);
      } else if (size == TDButtonSize.small) {
        return tdTextStyle.r14Primary(context);
      }
      return tdTextStyle.r16Primary(context);
    }

    TDTheme? theme = TDTheme.of(context);
    Color? tapColor = theme?.themeColor.tapColor;
    var contentWidget = <Widget>[];
    if (icon != null) {
      //默认是最小2dp的间距，需要增加则自行在传入Widget处增加。
      contentWidget.add(Padding(
        padding: tdButtonBase.buttonIconEdge,
        child: icon!,
      ));
    }
    contentWidget.add(Text(
      text ?? '确认',
      style: textStyle ?? getTextStyle(size),
    ));
    return Ink(
      //正常背景
      child: InkResponse(
        onTap: onClick,
        //radius 0 关闭水波纹
        radius: 0.0,
        //加按压颜色
        highlightColor: tapColor,
        highlightShape: BoxShape.rectangle,
        child: Padding(
          padding: padding ?? tdButtonBase.getEdgeBySize(size),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: contentWidget,
            ),
          ),
        ),
      ),
    );
  }
}
