//  Created by thomasfan, 13Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

/// Tag标签控件 - 面板
///
/// 实现参考了 [flutter_tags](https://github.com/Dn-a/flutter_tags)

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'tag_data.dart';

///ItemBuilder
typedef Widget ItemBuilder(int index);

class TagPanel extends StatefulWidget {
  TagPanel(
      {Key? key,
      this.itemCount = 0,
      required this.itemBuilder,
      this.heightHorizontalScroll = 60,
      this.horSpacing = 6})
      : assert(itemCount >= 0),
        super(key: key);

  ///numer of item List
  final int itemCount;

  /// Generates a list of [TagItem].
  ///
  /// Creates a list with [length] positions and fills it with values created by
  /// calling [generator] for each index in the range `0` .. `length - 1`
  /// in increasing order.
  final ItemBuilder itemBuilder;

  /// horizontal spacing of the [TagItem]
  final double heightHorizontalScroll;

  /// horizontal spacing of the [TagItem]
  final double horSpacing;

  @override
  TagPanelState createState() => TagPanelState();
}

class TagPanelState extends State<TagPanel> {
  // 内部继承扩展 TagItemData，支持 KVO 通知单个标签刷新
  final List<TagItemContext> _cxtList = [];

  // 向外暴露基类状态数据 TagItemData 列表，以便遍历标签状态
  List<TagItemData> get getAllItemData => _cxtList.toList();

  void appendATag(String title) {
    int index = _cxtList.length;
    _cxtList.add(TagItemContext(title: title, index: index));
  }

  void removeATag(int index) {
    _cxtList.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    // essential to avoid infinite loop of addPostFrameCallback

    Widget child = Container(
      height: widget.heightHorizontalScroll,
      color: Colors.transparent,
      child: ListView(
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: _buildTagItems(),
      ),
    );

    // TagPanelState._cxtList 传入 TagPanelInherited
    return TagPanelInherited(
      child: child,
      cxtList: _cxtList,
      itemCount: widget.itemCount,
    );
  }

  List<Widget> _buildTagItems() {
    List<Widget> finalList = [];

    List<Widget> itemList = List.generate(widget.itemCount, (i) {
      final Widget item = widget.itemBuilder(i);

      return Container(
        margin: EdgeInsets.symmetric(horizontal: widget.horSpacing),
        alignment: Alignment.center,
        child: item,
      );
    });

    finalList.addAll(itemList);
    return finalList;
  }
}
