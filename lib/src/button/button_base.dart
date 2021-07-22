//  Created by jamsun, 22Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

//按钮样式大小，控制间距和文字大小
import 'package:flutter/cupertino.dart';

enum TDButtonSize { large, mid, small, tint }

enum TDButtonStyle { normal, stroke, secondary, warn, warnStroke, text, ghost }

TDButtonBase tdButtonBase = TDButtonBase.instance;

class TDButtonBase {
  factory TDButtonBase() => _instance;
  static TDButtonBase get instance => _instance;
  static TDButtonBase _instance = TDButtonBase._internal();
  TDButtonBase._internal();

  EdgeInsetsGeometry getEdgeBySize(TDButtonSize size) {
    if (size == TDButtonSize.large) {
      return tdButtonLargeEdge;
    } else if (size == TDButtonSize.mid) {
      return tdButtonMidEdge;
    } else if (size == TDButtonSize.small) {
      return tdButtonSmallEdge;
    }
    return tdButtonTintEdge;
  }

  ///
  ///
  /// dialog的尺寸标准和button的不一样
  ///

  EdgeInsetsGeometry getDialogEdgeBySize({TDButtonSize? size = TDButtonSize.large}) {
    if (size == TDButtonSize.large) {
      return buttonLargeEdge;
    } else if (size == TDButtonSize.mid) {
      return buttonMidEdge;
    } else if (size == TDButtonSize.small) {
      return buttonSmallEdge;
    }
    return buttonMidEdge;
  }

  ///弹窗按钮的edge。  和按钮给的图标注不一样
  EdgeInsetsGeometry get buttonSmallEdge => EdgeInsets.all(buttonSmallPadding);
  EdgeInsetsGeometry get buttonMidEdge => EdgeInsets.all(buttonMidPadding);
  EdgeInsetsGeometry get buttonLargeEdge => EdgeInsets.all(buttonLargePadding);

  ///标准按钮间距
  EdgeInsetsGeometry get tdButtonLargeEdge => EdgeInsets.fromLTRB(0.0, 11.0, 0.0, 12.0);
  EdgeInsetsGeometry get tdButtonMidEdge => EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 11.0);
  EdgeInsetsGeometry get tdButtonSmallEdge => EdgeInsets.fromLTRB(20, 8.0, 20.0, 9.0);
  EdgeInsetsGeometry get tdButtonTintEdge => EdgeInsets.fromLTRB(16, 4.0, 16, 5.0);

  ///图标间距
  EdgeInsetsGeometry get buttonIconEdge => EdgeInsets.only(right: buttonIconPadding);

  ///按钮的dimen.
  double get buttonRadius => 4.0;
  double get buttonIconPadding => 8.0;
  double get buttonSmallPadding => 6.0;
  double get buttonMidPadding => 8.0;
  double get buttonLargePadding => 16.0;
  double get buttonStrokeWidth => 1.0;
}
