import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

import '../td_icons.dart';

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

  // icon四周的padding宽度
  static const double iconEdge = 7;

  // icon和文字之间的间隔宽度
  static const double contentGap = 5;
}

typedef void OnChangeSingle(bool checked, String name);

typedef void OnChangeGroup(List<String> checked);

/// 基础复选框组件
///
/// 能力及接口参考：[TDesign Mobile CheckBox](http://tdesign.woa.com/vue-mobile/components/checkbox)
///
/// 使用示例：
/// ``` dart
/// CheckBox(
///   name: '1.1',
///   title: '单行标题',
///   onChange: (selected, name) {
///     setState(() {
///       this.selected = selected;
///     });
///   },
/// )
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

  /// 选中图标的颜色，默认为`TDTheme.of(context).themeColor.primaryColor`或`TDColors.blue`。
  /// 仅在使用默认图标时生效。
  final Color? checkedColor;

  /// 默认的选中状态。默认为`false`。
  final bool defaultSelected;

  /// 自定义选中时的左侧icon
  final Widget? selectedIcon;

  /// 自定义未选中时的左侧icon
  final Widget? unselectedIcon;

  /// 左侧Icon大小
  final double? iconSize;

  /// 选项选中状态变化的回调
  final OnChangeSingle? onChange;

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
            child: Container(
              padding: EdgeInsets.all(_Default.iconEdge),
              child: _WidgetHelper.buildIcon(
                widget.checkedColor,
                widget.selectedIcon,
                widget.unselectedIcon,
                theme,
                selected,
              ),
            ),
            onTap: () => _clicked(),
          ),
          Flexible(
            child: _WidgetHelper.buildText(
                widget.title, widget.content, widget.limitTitleRow, widget.limitContentRow, theme),
          ),
        ],
      ),
      onTap: () {
        if (!widget.contentDisabled) {
          _clicked();
        }
      },
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

abstract class _WidgetHelper {
  static Widget buildText(String? title, String? content, int limitTitleRow, int limitContentRow, TDTheme? theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            title ?? '',
            style: TextStyle(
              fontFamily: theme?.themeData.fontFamily,
              fontSize: theme?.themeData.fontSizeL,
            ),
            maxLines: limitTitleRow,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          height: content == null ? 0 : _Default.contentGap,
        ),
        Flexible(
          child: Offstage(
            child: Text(
              content ?? '',
              style: TextStyle(
                  fontFamily: theme?.themeData.fontFamily,
                  fontSize: theme?.themeData.fontSizeBase,
                  color: theme?.themeColor.textColorL3),
              maxLines: limitContentRow,
              overflow: TextOverflow.ellipsis,
            ),
            offstage: content == null,
          ),
        ),
      ],
    );
  }

  static Widget buildIcon(
    Color? checkedColor,
    Widget? selectedIcon,
    Widget? unselectedIcon,
    TDTheme? theme,
    bool selected,
  ) {
    final double size = theme?.themeData.iconX ?? 24;
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: selected ? 0 : 1,
            child: unselectedIcon ??
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
            child: selectedIcon ??
                Icon(
                  _Default.selectedIconData,
                  color: checkedColor ?? theme?.themeColor.primaryColor ?? TDColors.blue,
                  size: size,
                ),
          ),
        ],
      ),
    );
  }
}

typedef void _ToggleListener(String name);

/// 复选框群组控制器
/// 允许在外部控制复选框群组中选项的选择与否。
class CheckGroupController {
  // 反选所有选项的调用
  VoidCallback? _toggleAll;

  // 选择所有选项的调用
  VoidCallback? _checkAll;

  // 取消选择所有选项的调用
  VoidCallback? _uncheckAll;

  // 反选某一选项的调用
  _ToggleListener? _toggle;

  // 选择某一选项的调用
  _ToggleListener? _check;

  // 取消选择某一选项的调用
  _ToggleListener? _uncheck;

  // CheckGroup传入相应能力函数以注入能力
  void _register(
    VoidCallback toggleAll,
    VoidCallback checkAll,
    VoidCallback uncheckAll,
    _ToggleListener toggle,
    _ToggleListener check,
    _ToggleListener uncheck,
  ) {
    _toggleAll = toggleAll;
    _checkAll = checkAll;
    _uncheckAll = uncheckAll;
    _toggle = toggle;
    _check = check;
    _uncheck = uncheck;
  }

  /// 控制所有选项
  /// `check`不传入时，操作为反选
  /// 为`true`时，操作为全选
  /// 为`false`时，操作为全部取消
  void toggleAll({bool? checked}) {
    if (checked == null) {
      _toggleAll?.call();
    } else if (checked) {
      _checkAll?.call();
    } else {
      _uncheckAll?.call();
    }
  }

  /// 反选某一选项，传入的`name`为该选项的`name`
  toggle(String name) => _toggle?.call(name);

  /// 选择某一选项，传入的`name`为该选项的`name`
  check(String name) => _check?.call(name);

  /// 取消选择某一选项，传入的`name`为该选项的`name`
  uncheck(String name) => _uncheck?.call(name);
}

/// 复选框群组组件
///
/// 使用示例：
/// ``` dart
/// CheckGroup(
///   names: ['1', '2', '3', '4'],
///   titles: ['选项一', '选项二', '选项三', '选项四'],
/// )
/// ```
class CheckGroup extends StatefulWidget {
  /// 各选项的值，即ID，必须传入。
  /// group内的选项数目由`names.length`决定。
  final List<String> names;

  /// 各选项的标题，必须传入。
  /// 超出`names`数组长度的部分将不会显示。
  /// 小于`names`数组长度，后续未设置的部分为空。
  final List<String> titles;

  /// 选项的内容，即解释文本。
  /// 超出`names`数组长度的部分将不会显示。
  /// 元素可为`null`。
  final List<String?> contents;

  /// 用一个布尔序列表示哪些选项被禁用。默认为全`false`。
  /// 超出`names`数组长度的部分无效。
  /// 小于`names`数组长度，后续未设置的部分默认为不禁用。
  final List<bool> disabled;

  /// 用一个布尔序列表示各选项默认的选中状态。默认为全`false`。
  /// 超出`names`数组长度的部分无效。
  /// 小于`names`数组长度，后续未设置的部分默认为不选中。
  final List<bool> defaultSelected;

  /// 文本区域能否被点击。默认为`false`。
  /// 所有选项统一配置。
  final bool contentDisabled;

  /// 标题的行数限制，默认为`1`。
  /// 所有选项统一配置。
  final int limitTitleRow;

  /// 内容的行数限制，默认为`1`。
  /// 所有选项统一配置。
  final int limitContentRow;

  /// 选中图标的颜色，默认为`TDTheme.of(context).themeColor.primaryColor`或`TDColors.blue`。
  /// 仅在使用默认图标时生效。
  /// 所有选项统一配置。
  final Color? checkedColor;

  /// 自定义选中时的左侧icon
  /// 所有选项统一配置。
  final Widget? selectedIcon;

  /// 自定义未选中时的左侧icon
  /// 所有选项统一配置。
  final Widget? unselectedIcon;

  /// 左侧Icon大小
  /// 所有选项统一配置。
  final double? iconSize;

  /// 选项选中状态变化的回调
  /// 所有选项统一配置。
  final OnChangeGroup? onChange;

  /// 控制器，用于从使用侧控制全选和全部取消。
  final CheckGroupController? controller;

  /// 可选的选项之间的分割widget。
  final Widget? separatorWidget;

  /// 最多可以选择群组内的几项，为空时无限制。
  /// 全选操作不受约束。
  final int? selectLimit;

  const CheckGroup({
    required this.names,
    this.titles = const [],
    this.contents = const [],
    this.disabled = const [],
    this.defaultSelected = const [],
    this.contentDisabled = _Default.contentDisabled,
    this.limitTitleRow = _Default.limitTitleRow,
    this.limitContentRow = _Default.limitContentRow,
    this.checkedColor,
    this.selectedIcon,
    this.unselectedIcon,
    this.iconSize,
    this.onChange,
    this.controller,
    this.separatorWidget,
    this.selectLimit,
  }) : assert(names.length != 0);

  @override
  State<StatefulWidget> createState() {
    return _CheckGroupState();
  }
}

class _CheckGroupState extends State<CheckGroup> {
  int numTotal = 0;
  Set<int> selectedIndeces = Set();
  TDTheme? theme;

  @override
  void initState() {
    numTotal = widget.names.length;
    for (int i = 0; i < widget.defaultSelected.length; i++) {
      if (i < numTotal && widget.defaultSelected[i]) {
        selectedIndeces.add(i);
      }
    }
    widget.controller?._register(_toggleAll, _checkAll, _uncheckAll, _toggle, _check, _uncheck);
    super.initState();
  }

  _toggleAll() {
    setState(() {
      for (int i = 0; i < numTotal; i++) {
        if (selectedIndeces.contains(i)) {
          selectedIndeces.remove(i);
        } else {
          selectedIndeces.add(i);
        }
      }
    });
  }

  _checkAll() {
    setState(() {
      selectedIndeces.clear();
      for (int i = 0; i < numTotal; i++) {
        selectedIndeces.add(i);
      }
    });
  }

  _uncheckAll() {
    setState(() {
      selectedIndeces.clear();
    });
  }

  _toggle(name) {
    final index = widget.names.indexOf(name);
    if (selectedIndeces.contains(index)) {
      selectedIndeces.remove(index);
    } else {
      selectedIndeces.add(index);
    }
  }

  _check(String name) {
    setState(() {
      selectedIndeces.add(widget.names.indexOf(name));
    });
  }

  _uncheck(String name) {
    setState(() {
      selectedIndeces.remove(widget.names.indexOf(name));
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = TDTheme.of(context);
    if (numTotal == 0) {
      return Container();
    }
    return Column(children: _childrenList());
  }

  List<Widget> _childrenList() {
    List<Widget> list = <Widget>[];
    for (int i = 0; i < numTotal; i++) {
      list.add(_checkbox(i));
      if (i != numTotal - 1 && widget.separatorWidget != null) {
        list.add(widget.separatorWidget!);
      }
    }
    return list;
  }

  Widget _checkbox(int index) {
    String? title = widget.titles.length > index ? widget.titles[index] : null;
    String? content = widget.contents.length > index ? widget.contents[index] : null;
    bool selected = selectedIndeces.contains(index);
    return GestureDetector(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.all(_Default.iconEdge),
                child: _WidgetHelper.buildIcon(
                  widget.checkedColor,
                  widget.selectedIcon,
                  widget.unselectedIcon,
                  theme,
                  selected,
                ),
              ),
              onTap: () => _clicked(index)),
          Flexible(child: _WidgetHelper.buildText(title, content, widget.limitTitleRow, widget.limitContentRow, theme)),
        ],
      ),
      onTap: () {
        if (!widget.contentDisabled) {
          _clicked(index);
        }
      },
    );
  }

  _clicked(int index) {
    setState(() {
      if (widget.disabled.length > index && !widget.disabled[index]) {
        return;
      }
      if (selectedIndeces.contains(index)) {
        selectedIndeces.remove(index);
      } else {
        if (widget.selectLimit != null && selectedIndeces.length >= widget.selectLimit!) {
          return;
        }
        selectedIndeces.add(index);
      }
      final List<String> checked = [];
      for (int i in selectedIndeces) {
        checked.add(widget.names[i]);
      }
      widget.onChange?.call(checked);
    });
  }
}
