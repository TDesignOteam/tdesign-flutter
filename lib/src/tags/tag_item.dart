//  Created by thomasfan, 13Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

/// Tag标签控件 - 标签

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'tag_data.dart';

/// Used by [TagItem.onClick].
typedef OnClickCallback = void Function(TagItemData i);

/// Used by [TagItem.OnLongPressed].
typedef OnLongPressCallback = void Function(TagItemData i);

/// Used by [TagItem.onRemove].
typedef OnRemoveCallback = void Function();

/// 主题效果：TagItemTheme.natural #F9F9F9, #DFEFFF, #FFFFFF with mark shape
enum TagItemTheme { dark, light, plain }

/// 标签风格，对应不同的背景颜色
enum TagItemStyle {
  natural, // aka default, #F9F9F9 for dark, color, textColor = black
  primary, // #0052D9 for dark, activeColor, activeTextColor = white
  info, // #CCCCCC for dark
  warning, // #ED7B2F for dark
  danger, // #E34D59 for dark
  success // #00A870 for dark
}

/// 标签尺寸
enum TagItemSize {
  large, // 60x30, fontSize=14
  medium, // default, 48x24, fontSize=12
  small // 36x22, fontSize=10
}

/// 边角类型
enum TagItemShape {
  square, // radius = 2
  round, // radius = 14.5, 12, 11 for TagItemSize
  mark // border: 1px, solid, #0052D9
}

class TagItem extends StatefulWidget {
  TagItem(
      {Key? key,
      required this.index,
      required this.title,
      this.customData,
      this.theme = TagItemTheme.dark,
      this.style = TagItemStyle.natural,
      this.size = TagItemSize.medium,
      this.shape = TagItemShape.square,
      this.elevation = 5,
      this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      this.highlightColor, // for InkWell
      this.splashColor, // for InkWell
      this.singleSelection = false,
      this.disabled = false,
      this.checked = false,
      this.clickable = false,
      this.onClick,
      this.removable = false,
      this.onRemove,
      this.textScaleFactor = 1.0,
      this.onLongPress})
      : super(key: key);

  /// Id of [TagItem] - required
  final int index;

  /// Title of [TagItem] - required
  final String title;

  /// Possibility to add any custom value in customData field, you can retrieve this later. A good example: store an id from Firestore document.
  final dynamic customData;

  /// theme of [TagItem]
  final TagItemTheme theme;

  /// style of [TagItem]
  final TagItemStyle style;

  /// size of [TagItem]
  final TagItemSize size;

  /// shape of [TagItem]
  final TagItemShape shape;

  /// BoxShadow of the [TagItem]
  final double elevation;

  /// padding of the [TagItem]
  final EdgeInsets padding;

  /// highlight Color [TagItem]
  final Color? highlightColor;

  /// Splash color [TagItem]
  final Color? splashColor;

  /// when you want only one tag selected. same as radio-button
  final bool singleSelection;

  /// Disable State [TagItem], only for TagItemStyle.natural
  /// if disabled, neither removable nor clickable
  final bool disabled;

  /// Check State of [TagItem], only for TagItemStyle.natural
  final bool checked;

  /// Removable of [TagItem], aka closable, prior to clickable
  /// enableUserInteraction = removable || clickable
  final bool removable;

  /// Remove Callback of [TagItem], aka close
  final OnRemoveCallback? onRemove;

  /// Clickable of [TagItem], lower priority than removable
  /// enableUserInteraction = removable || clickable
  final bool clickable;

  /// callback
  final OnClickCallback? onClick;

  /// Scale Factor of [TagItem] - double
  final double textScaleFactor;

  /// callback
  final OnLongPressCallback? onLongPress;

  @override
  _TagItemState createState() => _TagItemState();
}

class _TagItemState extends State<TagItem> {
  late TagPanelInherited _tagPanelIn;
  TagItemContext? _tagItemCxt;

  @override
  void initState() {
    super.initState();

    /// 只有默认theme才支持点击选中
    if (widget.clickable) {
      assert(widget.style == TagItemStyle.natural);
    }

    /// 只有默认theme才支持点击选中，被禁用不能触发事件
    if (widget.disabled) {
      assert(widget.style == TagItemStyle.natural);
      assert(!widget.removable && !widget.clickable);
    }
  }

  void _setItemContext() {
    // Get TagPanelInherited of current context
    // 当前标签向上寻找最近的 InheritedWidget 基类
    _tagPanelIn = TagPanelInherited.of(context);
    // add/update listener when build/rebuild
    bool build = (_tagItemCxt == null);
    _tagItemCxt?.removeListener(_didValueChange);
    _tagItemCxt = _tagPanelIn.cxtList.elementAt(widget.index);
    if (build) {
      _tagItemCxt?.disabled = widget.disabled;
      _tagItemCxt?.checked = widget.checked;
    }
    _tagItemCxt?.addListener(_didValueChange);
  }

  _didValueChange() => setState(() {});

  @override
  void dispose() {
    _tagItemCxt?.removeListener(_didValueChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 依赖了 TagPanelInherited 的数据成员 cxtList
    _setItemContext();

    final Size _tagSize = _size;
    final double _maxWidth = 130;

    return Material(
      color: _backgroundColor,
      borderRadius: BorderRadius.circular(_borderRadius),
      elevation: widget.elevation,
      //shadowColor: _tagItemCxt.highlights? Colors.red : Colors.blue,
      child: InkWell(
        borderRadius: BorderRadius.circular(_borderRadius),
        highlightColor:
            widget.clickable ? widget.highlightColor : Colors.transparent,
        splashColor: widget.clickable ? widget.splashColor : Colors.transparent,
        child: Container(
            constraints: BoxConstraints(
              minWidth: _tagSize.width,
              maxWidth: _maxWidth,
            ),
            decoration: BoxDecoration(
                border: _border,
                borderRadius: BorderRadius.circular(_borderRadius)),
            padding: widget.padding,
            height: _tagSize.height,
            child: _buildTagItem()),
        onTap: widget.clickable
            ? () {
                if (widget.singleSelection) {
                  _deactivateOtherItems(_tagPanelIn, _tagItemCxt!);
                }
                _tagItemCxt!.checked = !_tagItemCxt!.checked;

                if (widget.onClick != null)
                  widget.onClick!(TagItemData(
                      index: widget.index,
                      title: _tagItemCxt!.title,
                      disabled: _tagItemCxt!.disabled,
                      checked: _tagItemCxt!.checked,
                      customData: widget.customData));
              }
            : null,
        onLongPress: widget.onLongPress != null
            ? () => widget.onLongPress!(TagItemData(
                index: widget.index,
                title: _tagItemCxt!.title,
                disabled: _tagItemCxt!.disabled,
                checked: _tagItemCxt!.checked,
                customData: widget.customData))
            : null,
      ),
    );
  }

  Widget _buildTagItem() {
    final Widget text = Text(
      widget.title,
      style: _textStyle,
      textAlign: TextAlign.center,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: widget.textScaleFactor,
    );

    final List list = [];
    list.add(text); // onlyText

    final Widget row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(list.length, (i) {
          if (i == 0 && list.length > 1)
            return Flexible(
              flex: 1,
              child: list[i],
            );
          return Flexible(
            flex: list.length == 1 ? 1 : 0,
            child: list[i],
          );
        }));

    if (widget.removable)
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(fit: FlexFit.loose, flex: 2, child: row),
            Flexible(
                flex: 0,
                child: FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.fill,
                    child: GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(left: _removeLeftMargin),
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      onTap: () {
                        if (widget.onRemove != null) {
                          widget.onRemove!();
                        }
                      },
                    )))
          ]);

    return row;
  }

  /// TextStyle, determined by effect, theme
  Color get _backgroundColor {
    Color _backgroundColor = Color(0xFFF9F9F9);
    Color _activeBackgroundColor = Color(0xFF0052D9);

    /// 根据主题和样式综合设置字体颜色
    if (widget.theme == TagItemTheme.dark) {
      switch (widget.style) {
        case TagItemStyle.natural:
          _backgroundColor = Color(0xFFF9F9F9);
          _activeBackgroundColor = Color(0xFF0052D9);
          break;
        case TagItemStyle.primary:
          _backgroundColor = Color(0xFF0052D9);
          break;
        case TagItemStyle.info:
          _backgroundColor = Color(0xFFCCCCCC);
          break;
        case TagItemStyle.warning:
          _backgroundColor = Color(0xFFED7B2F);
          break;
        case TagItemStyle.danger:
          _backgroundColor = Color(0xFFE34D59);
          break;
        case TagItemStyle.success:
          _backgroundColor = Color(0xFF00A870);
          break;
      }
    } else if (widget.theme == TagItemTheme.light) {
      _backgroundColor = Color(0xFFDFEFFF);
      // ignore widget.theme
    } else if (widget.theme == TagItemTheme.plain) {
      _backgroundColor = Colors.white;
      // ignore widget.theme
    }

    return widget.clickable
        ? (_tagItemCxt!.checked ? _activeBackgroundColor : _backgroundColor)
        : _backgroundColor;
  }

  /// TextStyle, determined by effect, theme
  TextStyle get _textStyle {
    double _fontSize = 14.0;
    Color _textColor = Colors.black;
    Color _textActiveColor = Colors.white;

    /// 根据标签尺寸类型，设置字体大小
    switch (widget.size) {
      case TagItemSize.large: // 60x30
        _fontSize = 14.0;
        break;
      case TagItemSize.medium: // default, 48x24
        _fontSize = 12.0;
        break;
      case TagItemSize.small: // 36x22,
        _fontSize = 10.0;
        break;
    }

    /// 根据主题和样式综合设置字体颜色
    if (widget.theme == TagItemTheme.dark) {
      if (widget.style == TagItemStyle.natural) {
        _textColor = widget.disabled
            ? Colors.black.withOpacity(0.16)
            : Colors.black.withOpacity(0.6);
        _textActiveColor = Colors.white;
      } else {
        // no _textActiveColor
        _textColor = Colors.white;
      }
    } else if (widget.theme == TagItemTheme.light) {
      _textColor = Color(0xFF0052D9);
    } else if (widget.theme == TagItemTheme.plain) {
      _textColor = Color(0xFF0052D9);
    }

    return TextStyle(
      fontSize: _fontSize,
      color: widget.clickable
          ? (_tagItemCxt!.checked ? _textActiveColor : _textColor)
          : _textColor,
    );
  }

  BoxBorder? get _border {
    if (widget.shape == TagItemShape.mark) {
      return Border.all(color: Color(0xFF0052D9));
    }
    return null;
  }

  double get _borderRadius {
    double _borderRadius = 2.0;
    switch (widget.shape) {
      case TagItemShape.square:
        _borderRadius = 2;
        break;
      case TagItemShape.round:
        switch (widget.size) {
          case TagItemSize.large: // 60x30
            _borderRadius = 14.5;
            break;
          case TagItemSize.medium: // default, 48x24
            _borderRadius = 12;
            break;
          case TagItemSize.small: // 36x22,
            _borderRadius = 11;
            break;
        }
        break;
      case TagItemShape.mark:
        _borderRadius = 1;
        break;
    }

    return _borderRadius;
  }

  Size get _size {
    Size _size = Size(48, 24);

    /// 根据标签尺寸类型，设置字体大小
    switch (widget.size) {
      case TagItemSize.large:
        _size = Size(60, 30);
        break;
      case TagItemSize.medium:
        _size = Size(48, 24);
        break;
      case TagItemSize.small:
        _size = Size(36, 22);
        break;
    }

    return _size;
  }

  /// only if removable
  double get _removeLeftMargin {
    double _leftMargin = 0.0;

    /// 根据标签尺寸类型，设置字体大小
    switch (widget.size) {
      case TagItemSize.large: // 60x30
        _leftMargin = 8.0;
        break;
      case TagItemSize.medium: // default, 48x24
        _leftMargin = 4.0;
        break;
      case TagItemSize.small: // 36x22,
        _leftMargin = 2.0;
        break;
    }

    return _leftMargin;
  }

  /// Deactivate other active TagItems
  void _deactivateOtherItems(
      TagPanelInherited panelIn, TagItemContext itemCxt) {
    panelIn.cxtList.where((tg) {
      return tg.checked == true && tg != itemCxt;
    }).forEach((tg) => tg.checked = false);
  }
}
