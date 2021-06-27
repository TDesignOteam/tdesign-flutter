//  Created by jamsun, 22Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

//按钮样式大小，控制间距和文字大小
import 'package:flutter/cupertino.dart';

enum TButtonSize { large, mid, small }

TDButtonBase tdButtonBase = TDButtonBase.instance;

class TDButtonBase {
  factory TDButtonBase() => _instance;
  static TDButtonBase get instance => _instance;
  static TDButtonBase _instance = TDButtonBase._internal();
  TDButtonBase._internal();

  EdgeInsetsGeometry getEdgeBySize(TButtonSize size) {
    if (size == TButtonSize.large) {
      return buttonLargeEdge;
    } else if (size == TButtonSize.mid) {
      return buttonMidEdge;
    } else if (size == TButtonSize.small) {
      return buttonSmallEdge;
    }
    return buttonMidEdge;
  }

  ///按钮的edge。
  EdgeInsetsGeometry get buttonSmallEdge => EdgeInsets.all(buttonSmallPadding);
  EdgeInsetsGeometry get buttonMidEdge => EdgeInsets.all(buttonMidPadding);
  EdgeInsetsGeometry get buttonLargeEdge => EdgeInsets.all(buttonLargePadding);
  EdgeInsetsGeometry get buttonIconEdge =>
      EdgeInsets.only(right: buttonIconPadding);

  ///按钮的dimen.
  double get buttonRadius => 4.0;
  double get buttonIconPadding => 4.0;
  double get buttonSmallPadding => 6.0;
  double get buttonMidPadding => 8.0;
  double get buttonLargePadding => 16.0;
}
