//  Created by lyrisli on 2021/6/20.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:tdesign/src/checkbox.dart';
import 'package:tdesign/tdesign.dart';

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
}

typedef void OnChangeSingle(bool checked, String name);

typedef void OnChangeGroup(List<String> checked);

typedef Widget IconBuilder(TDTheme? theme);

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

  /// 自定义选中时的左侧icon的Builder
  final IconBuilder? selectedIconBuilder;

  /// 自定义未选中时的左侧icon的Builder
  final IconBuilder? unselectedIconBuilder;

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
    this.selectedIconBuilder,
    this.unselectedIconBuilder,
    this.onChange,
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
                widget.selectedIconBuilder,
                widget.unselectedIconBuilder,
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

// 辅助类，包含构建组件组成部分的帮助方法
abstract class _WidgetHelper {
  // 构建选项的文字部分
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
          height: content == null ? 0 : theme?.themeData.spacer ?? 6,
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

  // 构建选项的Icon部分
  static Widget buildIcon(
    Color? checkedColor,
    IconBuilder? selectedIconBuilder,
    IconBuilder? unselectedIconBuilder,
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
            child: Container(
              key: Key('unselected_icon'),
              child: unselectedIconBuilder?.call(theme) ??
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
          ),
          Opacity(
            opacity: selected ? 1 : 0,
            child: Container(
              key: Key('selected_icon'),
              child: selectedIconBuilder?.call(theme) ??
                  Icon(
                    _Default.selectedIconData,
                    color: checkedColor ?? theme?.themeColor.primaryColor ?? TDColors.blue,
                    size: size,
                  ),
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
///   options: [
///     GroupOption(name: '选项一', title: '选项一'),
///     GroupOption(name: '选项二', title: '选项二'),
///     GroupOption(name: '选项三', title: '选项三'),
///   ])
/// ```
class CheckGroup extends StatefulWidget {
  /// 选项信息实例的列表，必须传入
  /// 选项的数量由列表长度决定，长度不可为0。
  final List<GroupOption> options;

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
  final IconBuilder? selectedIconBuilder;

  /// 自定义未选中时的左侧icon
  /// 所有选项统一配置。
  final IconBuilder? unselectedIconBuilder;

  /// 选项选中状态变化的回调
  /// 所有选项统一配置。
  final OnChangeGroup? onChange;

  /// 控制器，用于从使用侧控制全选和全部取消。
  final CheckGroupController? controller;

  /// 可选的选项之间的分割widget。
  final Widget? separatorWidget;

  /// 最多可以选择群组内的几项，为空时无限制。
  /// 使用controller进行的外部控制操作不受约束。
  final int? selectLimit;

  const CheckGroup({
    required this.options,
    this.defaultSelected = const [],
    this.contentDisabled = _Default.contentDisabled,
    this.limitTitleRow = _Default.limitTitleRow,
    this.limitContentRow = _Default.limitContentRow,
    this.checkedColor,
    this.selectedIconBuilder,
    this.unselectedIconBuilder,
    this.onChange,
    this.controller,
    this.separatorWidget,
    this.selectLimit,
  }) : assert(options.length != 0);

  @override
  State<StatefulWidget> createState() {
    return _CheckGroupState();
  }
}

class _CheckGroupState extends State<CheckGroup> {
  int numTotal = 0;
  Set<int> selectedIndices = Set();
  TDTheme? theme;

  @override
  void initState() {
    numTotal = widget.options.length;
    for (int i = 0; i < widget.defaultSelected.length; i++) {
      if (i < numTotal && widget.defaultSelected[i]) {
        selectedIndices.add(i);
      }
    }
    widget.controller?._register(_toggleAll, _checkAll, _uncheckAll, _toggle, _check, _uncheck);
    super.initState();
  }

  _toggleAll() {
    setState(() {
      for (int i = 0; i < numTotal; i++) {
        if (selectedIndices.contains(i)) {
          selectedIndices.remove(i);
        } else {
          selectedIndices.add(i);
        }
      }
    });
    _callbackOnChange();
  }

  _checkAll() {
    setState(() {
      selectedIndices.clear();
      for (int i = 0; i < numTotal; i++) {
        selectedIndices.add(i);
      }
    });
    _callbackOnChange();
  }

  _uncheckAll() {
    setState(() {
      selectedIndices.clear();
    });
    _callbackOnChange();
  }

  _toggle(String name) {
    setState(() {
      int index = _indexOfName(name);
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
      }
    });
    _callbackOnChange();
  }

  _check(String name) {
    setState(() {
      int index = _indexOfName(name);
      if (index >= 0 && index < numTotal) {
        selectedIndices.add(index);
      }
    });
    _callbackOnChange();
  }

  _uncheck(String name) {
    setState(() {
      int index = _indexOfName(name);
      if (index >= 0 && index < numTotal) {
        selectedIndices.remove(index);
      }
    });
    _callbackOnChange();
  }

  int _indexOfName(String name) {
    for (int i = 0; i < widget.options.length; i++) {
      if (name == widget.options[i].name) {
        return i;
      }
    }
    return -1;
  }

  void _callbackOnChange() {
    List<String> checked = [];
    for (int i in selectedIndices) {
      checked.add(widget.options[i].name);
    }
    widget.onChange?.call(checked);
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
      list.add(Opacity(opacity: widget.options[i].disabled ? _Default.disabledOpacity : 1, child: _checkbox(i)));
      if (i != numTotal - 1 && widget.separatorWidget != null) {
        list.add(widget.separatorWidget!);
      }
    }
    return list;
  }

  Widget _checkbox(int index) {
    String? title = widget.options[index].title;
    String? content = widget.options[index].content;
    bool selected = selectedIndices.contains(index);
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
                  widget.selectedIconBuilder,
                  widget.unselectedIconBuilder,
                  theme,
                  selected,
                ),
              ),
              onTap: () => _clicked(index)),
          Flexible(
              child: _WidgetHelper.buildText(
            title,
            content,
            widget.limitTitleRow,
            widget.limitContentRow,
            theme,
          )),
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
      if (widget.options[index].disabled) {
        // 选项disabled，直接返回
        return;
      }
      if (selectedIndices.contains(index)) {
        // 选项已被选，则取消选择
        if (widget.selectLimit != null && widget.selectLimit == 1 && selectedIndices.length == 1) {
          // 若为单选，则不可取消
          return;
        }
        selectedIndices.remove(index);
      } else {
        // 已选选项数已达限制
        if (widget.selectLimit != null && selectedIndices.length >= widget.selectLimit!) {
          if (widget.selectLimit == 1) {
            // 若为单选，进行互斥选择
            selectedIndices
              ..clear()
              ..add(index);
          }
        } else {
          // 选项未被选且可选，则正常选择
          selectedIndices.add(index);
        }
      }
      final List<String> checked = [];
      for (int i in selectedIndices) {
        checked.add(widget.options[i].name);
      }
      widget.onChange?.call(checked);
    });
  }
}
