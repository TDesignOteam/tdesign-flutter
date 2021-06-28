//  Created by thomasfan, 14Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

/// Tag标签控件 - 数据

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Inherited Widget: TagPanelState.build中包裹标签面板
class TagPanelInherited extends InheritedWidget {
  TagPanelInherited({
    Key? key,
    required Widget child,
    required this.cxtList,
    this.itemCount = 0,
  }) : super(key: key, child: child);

  // TagPanelState.build 传入 _cxtList，
  // 后代 TagItem 通过静态 of 获取 TagPanelInherited，访存 cxtList。
  final List<TagItemContext> cxtList;
  final int itemCount;

  // 数据变更时，不回调通知所有子组件，避免惊群效应；
  // TagItem 监听 ValueNotifier 来实现单个刷新。
  @override
  bool updateShouldNotify(TagPanelInherited old) {
    // don`t callback TagItemState.didChangeDependencies
    return false;
  }

  // static TagPanelInherited of(BuildContext context) =>
  //     context.inheritFromWidgetOfExactType(TagPanelInherited);
  static TagPanelInherited of(BuildContext context) {
    var _tagPanelIn =
        context.dependOnInheritedWidgetOfExactType<TagPanelInherited>();
    assert(_tagPanelIn != null);
    return _tagPanelIn!;
  }
}

/// TagItem Data: 向外暴露的标签状态数据
class TagItemData {
  TagItemData(
      {required this.index,
      required this.title,
      required this.disabled,
      required this.checked,
      this.customData});
  final int index;
  final String title;
  final dynamic customData;
  final bool disabled;
  final bool checked;

  @override
  String toString() {
    return "id:$index, title: $title, disabled: $disabled, checked: $checked, customData: $customData";
  }
}

/// TagItem Context: 内部扩展 TagItemData，变更时通知标签更新
class TagItemContext extends ValueNotifier implements TagItemData {
  TagItemContext(
      {required this.index,
      required this.title,
      bool disabled = false,
      bool checked = false,
      this.customData})
      : _checked = checked,
        this.disabled = disabled,
        super(checked);

  final int index;
  final String title;
  final dynamic customData;
  bool disabled;

  /// 是否为点击选中状态
  bool _checked;
  get checked => _checked;
  set checked(bool c) {
    _checked = c;
    // rebuild only the specific Item that changes its value
    notifyListeners();
  }
}
