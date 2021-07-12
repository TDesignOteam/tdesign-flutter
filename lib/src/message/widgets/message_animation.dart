//  Created by thomasfan, 02Jun21.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/widgets.dart';

abstract class MessageAnimation {
  MessageAnimation();

  Widget call(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return buildWidget(
      child,
      controller,
      alignment,
    );
  }

  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  );
}

class SlideMessageAnimation extends MessageAnimation {
  SlideMessageAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    ///Slide from top animation
    Animation<Offset> slideFromTopAnim = controller.drive(
      Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero).chain(
        CurveTween(
          curve: Curves.linear,
        ),
      ),
    );

    return SlideTransition(
      position: slideFromTopAnim,
      child: child,
    );
  }
}
