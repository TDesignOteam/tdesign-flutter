//  Created by jackiexing on 2021/7/9.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

/// 开关控件
///
/// 实现基于 [CupertinoSwitch](https://api.flutter.dev/flutter/cupertino/CupertinoSwitch-class.html)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

/// Switch支持的类型枚举
enum TDSwitchType { normal, loading, disable }

// 会基于Switch类型变化的特定配置
class _SwitchTypeSpecConfig {
  // switch是否禁用
  final bool disable;

  // switch是否处于加载状态
  final bool loading;

  const _SwitchTypeSpecConfig._switchTypeSpecConfig({required this.disable, required this.loading});
}

// 配置默认项
abstract class _Default {
  static const Map<TDSwitchType, _SwitchTypeSpecConfig> typeSpecConfig = {
    TDSwitchType.normal: _SwitchTypeSpecConfig._switchTypeSpecConfig(disable: false, loading: false),
    TDSwitchType.disable: _SwitchTypeSpecConfig._switchTypeSpecConfig(disable: true, loading: false),
    TDSwitchType.loading: _SwitchTypeSpecConfig._switchTypeSpecConfig(disable: true, loading: true),
  };

  // switch当前的类型
  static const TDSwitchType type = TDSwitchType.normal;

  // switch与描述之间的间距
  static const descPadding = 10.0;

  // 描述文字的默认字体大小
  static const textSize = 16.0;

  // loading小圆圈的直径
  static const loadingIndicatorSize = 17.0;

  // loading小圆圈距离switch边界的距离
  static const loadingIndicatorPadding = 11.0;
}

/// 开关组件
///
/// 能力及接口参考：[TDesign Mobile Switch](http://tdesign.woa.com/vue-mobile/components/switch)
///
/// 使用示例：
/// ``` dart
/// TDSwitch(
///   value: _status,
///   onChanged: (val) {
///     setState(() {
///        _status = val;
///     });
/// )
/// ```
class TDSwitch extends StatelessWidget {
  const TDSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.type = _Default.type,
    this.activeColor,
    this.inactiveColor,
    this.text,
    this.textColor,
    this.descPadding = _Default.descPadding,
    this.textSize = _Default.textSize,
  })  : assert(descPadding > 0, 'the padding between switch and description text must be greater than 0 !'),
        assert(textSize > 0, 'textSize must be greater than 0 !'),
        super(key: key);

  /// 决定switch处于开启还是关闭状态。
  final bool value;

  /// 此方法将会在用户点击switch的时候被调用。
  ///
  /// [onChanged] 应该更新父亲组件的state [StatefulWidget]
  /// 通过调用 [setState] 方法, 让父亲组件重新build; 示例:
  ///
  /// ```dart
  /// TDSwitch(
  ///   value: _status,
  ///   onChanged: (val) {
  ///     setState(() {
  ///        _status = val;
  ///     });
  ///   },
  /// ),
  /// ```
  final ValueChanged<bool> onChanged;

  /// 决定switch的类型，会影响switch [disable] 和 [loading] 的值。
  ///
  /// 默认值为`SwitchType.normal`
  final TDSwitchType type;

  /// switch开启时的底色。
  ///
  /// 默认值为`Theme.themeColor.primaryColor`
  final Color? activeColor;

  /// switch关闭时的底色。
  ///
  /// 默认值为`Theme.themeColor.bgIconFade`
  final Color? inactiveColor;

  /// switch的描述文字。
  ///
  /// 当text为null时，不显示文字。
  /// 可以通过[textColor]和[textSize]来指定描述文字的颜色和字体大小。
  /// 可以通过[descPadding]指定描述文字和switch之间的距离。
  final String? text;

  /// switch和描述文字之间的距离。
  ///
  /// 默认值为`10`，仅当[text]不为null时有效。
  final double descPadding;

  /// 描述文字的颜色。
  ///
  /// 默认值为`Theme.themeColor.textColorL2`，仅当[text]不为null时有效。
  final Color? textColor;

  /// 描述文字的字体大小。
  ///
  /// 默认值为`16`，仅当[text]不为null时有效。
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _Default.typeSpecConfig[type]!.disable ? 0.5 : 1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildWidgets(context),
      ),
    );
  }

  List<Widget> _buildWidgets(BuildContext context) {
    var widgets = <Widget>[];
    // 添加text
    if (text != null) {
      widgets.add(_buildText(context));
      widgets.add(SizedBox(width: descPadding));
    }
    // 添加switch
    widgets.add(_buildSwitch(context));
    return widgets;
  }

  Widget _buildText(BuildContext context) {
    var theme = TDTheme.of(context);
    return FittedBox(
      fit: BoxFit.contain,
      child: Text(
        text ?? "描述文字",
        style: TextStyle(
          color: textColor ?? theme?.themeColor.textColorL2 ?? TDColors.fontWhite[4],
          fontSize: textSize,
        ),
      ),
    );
  }

  Widget _buildSwitch(BuildContext context) {
    return Listener(
        child: IgnorePointer(
      ignoring: _Default.typeSpecConfig[type]!.disable,
      child: Stack(
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        children: _buildSwitchWidgets(context),
      ),
    ));
  }

  List<Widget> _buildSwitchWidgets(BuildContext context) {
    var theme = TDTheme.of(context);
    var switchWidgets = <Widget>[];
    // 添加switch主体部分
    switchWidgets.add(CupertinoSwitch(
      value: value,
      activeColor: activeColor ?? theme?.themeColor.primaryColor ?? TDColors.blue,
      trackColor: inactiveColor ?? theme?.themeColor.bgIconFade ?? TDColors.fontWhite[4],
      onChanged: onChanged,
    ));
    // 添加switch的loading小圆圈
    if (_Default.typeSpecConfig[type]!.loading) {
      switchWidgets.add(Padding(
        padding: value
            ? EdgeInsets.only(right: _Default.loadingIndicatorPadding)
            : EdgeInsets.only(left: _Default.loadingIndicatorPadding),
        child: SizedBox(
          width: _Default.loadingIndicatorSize,
          height: _Default.loadingIndicatorSize,
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation(activeColor ?? theme?.themeColor.primaryColor ?? TDColors.blue),
          ),
        ),
      ));
    }
    return switchWidgets;
  }
}
