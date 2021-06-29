import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign/tdesign.dart';

import 'td_icons.dart';

// 默认配置项
abstract class _Default {
  // 默认是否禁用选项
  static const disabled = false;

  // 默认文本区域是否可点击
  static const contentDisabled = false;

  // 默认的标题最大行数
  static const limitTitleRow = 1;

  // 默认的内容最大行数
  static const limitContentRow = 1;

  // 默认的选中状态
  static const defaultSelected = false;

  // 默认的选中图标
  static const IconData selectedIconData = TDIcons.checkCircleFilled;

  // 当选项被禁用时，选项的透明度
  static const double disabledOpacity = 0.4;

  static const double iconEdge = 7;

  static const double contentGap = 5;
}

typedef void OnChangeCallback(bool checked, String name);

/// 基础复选框组件
///
/// 能力及接口参考：[TDesign Mobile CheckBox](http://tdesign.woa.com/vue-mobile/components/checkbox)
///
/// 使用示例：
/// ``` dart
/// todo
/// ```
class CheckBox extends StatefulWidget {
  /// 选项的值，即ID，必须传入。
  final String name;

  /// 选项的标题，必须传入。
  final String title;

  /// 选项的内容，即解释文本。
  final String? content;

  /// 选项是否被禁用，即是否只读(readonly)，默认为`false`。
  final bool disabled;

  /// 文本区域能否被点击。默认为`false`。
  final bool contentDisabled;

  /// 标题的行数限制，默认为`1`。
  final int limitTitleRow;

  /// 内容的行数限制，默认为`1`。
  final int limitContentRow;

  /// 选中图标的颜色，默认为`TDColors.blue`，即`0xFF0052D9`。
  ///
  /// 仅在使用默认图标时生效。
  final Color? checkedColor;

  /// 默认的选中状态。默认为`false`。
  final bool defaultSelected;

  /// 自定义选中时的左侧icon
  final Widget? selectedIcon;

  /// 自定义未选中时的左侧icon
  final Widget? unselectedIcon;

  final double? iconSize;

  final double? fontSize;

  final OnChangeCallback? onChange;

  const CheckBox({
    required this.name,
    required this.title,
    this.content,
    this.disabled = _Default.disabled,
    this.contentDisabled = _Default.contentDisabled,
    this.limitTitleRow = _Default.limitTitleRow,
    this.limitContentRow = _Default.limitContentRow,
    this.checkedColor,
    this.defaultSelected = _Default.defaultSelected,
    this.selectedIcon,
    this.unselectedIcon,
    this.onChange,
    this.iconSize,
    this.fontSize,
  });

  @override
  State<StatefulWidget> createState() {
    return _CheckBoxState();
  }
}

class _CheckBoxState extends State<CheckBox> {
  bool selected = false;
  TDTheme? theme;

  @override
  void initState() {
    selected = widget.defaultSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = TDTheme.of(context);
    return Container(child: Opacity(opacity: widget.disabled ? _Default.disabledOpacity : 1, child: _body()));
  }

  Widget _body() {
    return GestureDetector(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(padding: EdgeInsets.all(_Default.iconEdge), child: _getIcon()),
              onTap: () => _clicked()),
          Flexible(child: _getText()),
        ],
      ),
      onTap: () {
        if (!widget.contentDisabled) {
          _clicked();
        }
      },
    );
  }

  Widget _getText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            widget.title,
            style: TextStyle(
              fontFamily: theme?.themeData.fontFamily,
              fontSize: widget.fontSize ?? theme?.themeData.fontSizeL,
            ),
            maxLines: widget.limitTitleRow,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          height: _Default.contentGap,
        ),
        Flexible(
          child: Offstage(
            child: Text(
              widget.content ?? '',
              style: TextStyle(
                  fontFamily: theme?.themeData.fontFamily,
                  fontSize: widget.fontSize ?? theme?.themeData.fontSizeBase,
                  color: theme?.themeColor.textColorL3),
              maxLines: widget.limitContentRow,
              overflow: TextOverflow.ellipsis,
            ),
            offstage: widget.content == null,
          ),
        ),
      ],
    );
  }

  Widget _getIcon() {
    final double size = theme?.themeData.iconX ?? 24;
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: selected ? 0 : 1,
            child: widget.unselectedIcon ??
                Container(
                  width: size * 5 / 6,
                  height: size * 5 / 6,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme?.themeColor.bgIconFade ?? Colors.grey,
                      width: size / 24,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
          ),
          Opacity(
            opacity: selected ? 1 : 0,
            child: widget.selectedIcon ??
                Icon(
                  _Default.selectedIconData,
                  color: widget.checkedColor ?? theme?.themeColor.primaryColor,
                  size: size,
                ),
          ),
        ],
      ),
    );
  }

  _clicked() {
    setState(() {
      if (widget.disabled) {
        return;
      }
      selected = !selected;
      widget.onChange?.call(selected, widget.name);
    });
  }
}
