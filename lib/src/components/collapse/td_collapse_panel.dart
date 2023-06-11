/*
 * Created by dorayhong@tencent.com on 6/4/23.
 */
import 'package:flutter/material.dart';

/// 折叠面板，需配合 [TDCollapse] 使用
class TDCollapsePanel extends ExpansionPanel {
  TDCollapsePanel({
    /// 折叠面板的头部组件构造函数
    required ExpansionPanelHeaderBuilder headerBuilder,

    /// 折叠面板的内容组件
    required Widget body,

    /// 折叠面板的展开状态
    isExpanded = false,

    /// 折叠面板的头部组件是否可点击
    canTapOnHeader = true,

    /// 折叠面板的背景色
    backgroundColor,
  }) : super(
          headerBuilder: headerBuilder,
          body: body,
          isExpanded: isExpanded,
          canTapOnHeader: canTapOnHeader,
          backgroundColor: backgroundColor,
        );
}
