/*
 * Created by dorayhong@tencent.com on 6/8/23.
 */
import 'package:flutter/cupertino.dart';

import '../../../td_export.dart';
import 'td_inset_divider.dart';

class TDCollapsePanelBody extends StatelessWidget {
  const TDCollapsePanelBody({
    required this.animationDuration,
    required this.body,
    required this.isExpanded,
    Key? key,
  }) : super(key: key);

  final Widget body;
  final bool isExpanded;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Container(height: 0.0),
      secondChild: Column(
        children: [
          const TDInsetDivider(),
          Container(
            padding: EdgeInsets.all(TDTheme.of(context).spacer16),
            child: body,
          ),
        ],
      ),
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: animationDuration,
    );
  }
}
