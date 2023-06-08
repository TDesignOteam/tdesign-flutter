/*
 * Created by dorayhong@tencent.com on 6/4/23.
 */
import 'package:flutter/material.dart';

class TDCollapsePanel extends ExpansionPanel {
  TDCollapsePanel({
    required ExpansionPanelHeaderBuilder headerBuilder,
    required Widget body,
    isExpanded = false,
    canTapOnHeader = true,
    backgroundColor,
  }) : super(
          headerBuilder: headerBuilder,
          body: body,
          isExpanded: isExpanded,
          canTapOnHeader: canTapOnHeader,
          backgroundColor: backgroundColor,
        );
}
