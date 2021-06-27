//  Created by jamsun, 22Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/theme/td_text_style.dart';

import '../../tdesign.dart';
import 'button_base.dart';

class TTextButton extends StatelessWidget {
  ///点击效果
  final VoidCallback onClick;

  ///是否有左侧icon
  final Widget? icon;

  ///按钮文字
  final String? text;

  ///文字样式
  final TextStyle? textStyle;

  ///文字大小
  final TButtonSize size;

  TTextButton(
      {required this.onClick,
      Key? key,
      this.text,
      this.icon,
      this.textStyle,
      this.size = TButtonSize.mid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        highlightColor: textStyle?.color?.withAlpha(40) ??
            TDTheme.primaryColor.withAlpha(40),
        highlightShape: BoxShape.rectangle,
        child: Padding(
          padding: tdButtonBase.getEdgeBySize(size),
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

  TextStyle getTextStyle(TButtonSize size) {
    if (size == TButtonSize.large) {
      return tdTextStyle.r16Primary;
    } else if (size == TButtonSize.mid) {
      return tdTextStyle.r16Primary;
    } else if (size == TButtonSize.small) {
      return tdTextStyle.r14Primary;
    }
    return tdTextStyle.r16Primary;
  }
}
