/*
 * Created by dorayhong@tencent.com on 6/8/23.
 */
import 'package:flutter/material.dart';

import 'td_collapse_salted_key.dart';

typedef PressCallback = void Function(int panelIndex, bool isExpanded);

class TDCollapseHeader extends StatelessWidget {
  const TDCollapseHeader({
    required this.index,
    required this.animationDuration,
    required this.borderRadius,
    required this.onPress,
    required this.isExpanded,
    required this.canTapOnHeader,
    required this.headerBuilder,
    Key? key,
  }) : super(key: key);

  final int index;
  final Duration animationDuration;
  final BorderRadius borderRadius;
  final PressCallback onPress;
  final bool isExpanded;
  final bool canTapOnHeader;
  final ExpansionPanelHeaderBuilder headerBuilder;

  @override
  Widget build(BuildContext context) {
    final titleWidget = _buildTitleWidget(context);
    final expandIconWidget = _buildExpandIconWidget(context);

    Widget headerWidget = Row(children: [
      Expanded(
        child: AnimatedContainer(
          key: TDCollapseSaltedKey<BuildContext, int>(context, index * 2),
          duration: animationDuration,
          curve: Curves.fastOutSlowIn,
          margin: EdgeInsets.zero,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: kMinInteractiveDimension,
            ),
            child: titleWidget,
          ),
        ),
      ),
      expandIconWidget,
    ]);

    if (canTapOnHeader) {
      headerWidget = MergeSemantics(
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () => onPress(index, isExpanded),
          child: headerWidget,
        ),
      );
    }

    return headerWidget;
  }

  Widget _buildTitleWidget(BuildContext context) {
    final titleWidget = headerBuilder(context, isExpanded);
    return ListTile(
      title: titleWidget,
    );
  }

  Widget _buildExpandIconWidget(BuildContext context) {
    Widget expandedIcon = Container(
      key: TDCollapseSaltedKey<BuildContext, int>(context, index * 2),
      margin: const EdgeInsetsDirectional.all(0.0),
      child: ExpandIcon(
        isExpanded: isExpanded,
        padding: const EdgeInsets.all(16.0),
        onPressed: !canTapOnHeader
            ? (bool isExpanded) => onPress(index, isExpanded)
            : null,
      ),
    );

    if (!canTapOnHeader) {
      final localizations = MaterialLocalizations.of(context);
      expandedIcon = Semantics(
        container: true,
        child: expandedIcon,
        label: isExpanded
            ? localizations.expandedIconTapHint
            : localizations.collapsedIconTapHint,
      );
    }

    return expandedIcon;
  }
}
