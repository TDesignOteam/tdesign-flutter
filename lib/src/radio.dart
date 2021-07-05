//  Created by lyrisli on 2021/7/5.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

abstract class _Default {
  // 默认文本区域是否可点击
  static const contentDisabled = false;

  // 默认的标题最大行数
  static const limitTitleRow = 1;

  // 默认的内容最大行数
  static const limitContentRow = 1;
}


/// 基础单选组合组件
/// 
/// 基于CheckBox组件实现。
/// 能力参考：[TDesign Mobile Radio](http://tdesign.woa.com/vue-mobile/components/radio)
/// 
/// ```dart
/// RadioGroup(
///   names: ['选项1', '选项2', '选项3'],
///   titles: [
///     '单行标题',
///     '单行标题',
///     '多行标题',
///   ],
/// ),
/// ```
class RadioGroup extends CheckGroup {
  RadioGroup({
    required List<String> names,
    required List<String> titles,
    List<String> contents = const [],
    List<bool> disabled = const [],
    bool contentDisabled = _Default.contentDisabled,
    int limitTitleRow = _Default.limitTitleRow,
    int limitContentRow = _Default.limitContentRow,
    Color? checkedColor,
    String? defaultSelectedName,
    IconBuilder? selectedIconBuilder,
    IconBuilder? unselectedIconBuilder,
    OnChangeGroup? onChange,
    double? iconSize,
    Widget? separatorWidget,
  }) : super(
          names: names,
          titles: titles,
          contents: contents,
          disabled: disabled,
          contentDisabled: contentDisabled,
          limitTitleRow: limitTitleRow,
          limitContentRow: limitContentRow,
          checkedColor: checkedColor,
          defaultSelected: names.map((element) => element == defaultSelectedName).toList(),
          selectedIconBuilder: selectedIconBuilder ?? (theme) => _IconHelper.buildIcon(checkedColor, theme, true),
          unselectedIconBuilder: unselectedIconBuilder ?? (theme) => _IconHelper.buildIcon(checkedColor, theme, false),
          onChange: onChange,
          separatorWidget: separatorWidget,
          selectLimit: 1,
        );
}

// 辅助类，包含构建选项Icon组成部分的帮助方法
abstract class _IconHelper {
  static Widget buildIcon(Color? checkColor, TDTheme? theme, bool selected) {
    final double size = (theme?.themeData.iconX ?? 24) * 5 / 6;
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _outlineCircle(size, theme),
          Opacity(
            opacity: selected ? 1 : 0,
            child: _filledCircle(size, theme, checkColor),
          ),
        ],
      ),
    );
  }

  static Widget _outlineCircle(double size, TDTheme? theme) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme?.themeColor.bgIconFade ?? Colors.grey,
          width: size / 24,
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  static Widget _filledCircle(double size, TDTheme? theme, Color? color) {
    return Container(
      width: size * 0.65,
      height: size * 0.65,
      decoration: BoxDecoration(
        color: color ?? theme?.themeColor.primaryColor ?? TDColors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}
