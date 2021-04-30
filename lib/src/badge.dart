//  Created by lyrisli on 2021/4/26.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

/// 徽标控件

import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';
import 'dart:math' as math;

/// Badge支持的预设尺寸枚举
enum BadgeSize { medium, small }

/// Badge的形状枚举
enum BadgeShape { circle, rounded, ribbon }

/// 会基于Badge尺寸变化的特定配置
class _BadgeSizeSpecConfig {
  /// Badge类型为`BadgeShape.circle`或`BadgeShape.rounded`时，Badge的高度
  final double height;

  /// Badge类型为`BadgeShape.rounded`时，Badge的圆角半径
  final double roundedBorderRadius;

  /// Badge上文字的字体大小
  final double textSize;

  /// 文字两侧的边距，用于略微加宽Badge
  final double sidePadding;

  /// Badge为圆点时圆点大小
  final double dotSize;

  /// Badge类型为`BadgeShape.Rib`时，缎带靠近角落的侧边的与右侧边缘的距离
  final double ribbonIn;

  /// Badge类型为`BadgeShape.Rib`时，缎带远离角落的侧边的与右侧边缘的距离
  final double ribbonOut;
  const _BadgeSizeSpecConfig({
    required this.height,
    required this.roundedBorderRadius,
    required this.textSize,
    required this.sidePadding,
    required this.dotSize,
    required this.ribbonIn,
    required this.ribbonOut,
  });
}

// 默认配置
abstract class _Default {
  // 不同`size`的Badge所对应的默认配置
  static const Map<BadgeSize, _BadgeSizeSpecConfig> sizeSpecConfig = {
    BadgeSize.medium: _BadgeSizeSpecConfig(
      height: 17,
      roundedBorderRadius: 4,
      textSize: 13.5,
      sidePadding: 3,
      dotSize: 8,
      ribbonIn: 18,
      ribbonOut: 45,
    ),
    BadgeSize.small: _BadgeSizeSpecConfig(
      height: 14,
      roundedBorderRadius: 3,
      textSize: 10.5,
      sidePadding: 2,
      dotSize: 6,
      ribbonIn: 15,
      ribbonOut: 35,
    ),
  };

  // 文字颜色
  static const textColor = Colors.white;

  // Badge主体颜色
  static const color = TDColors.red;
}

/// 徽标组件
///
/// 能力及接口参考：http://tdesign.woa.com/vue-mobile/components/
///
/// 使用示例：
/// ```dart
/// Badge(
///   dot: true,
///   child: Icon(TDIcons.refresh),
/// )
/// ```
/// ```dart
/// Badge(
///   content: 'NEW',
///   shape: BadgeShape.ribbon,
///   child: ListTile(title: Text('ListTile')),
/// )
/// ```
class Badge extends StatefulWidget {
  const Badge({
    this.child,
    this.dot = false,
    this.color = _Default.color,
    this.textColor = _Default.textColor,
    this.count,
    this.maxCount = 99,
    this.content,
    this.size = BadgeSize.medium,
    this.shape = BadgeShape.circle,
    this.showZero = false,
    this.offset = const Offset(0, 0),
  });

  /// 这个Badge所依附的widget。如果为`null`，则badge独立存在。
  final Widget? child;

  /// 是否显示为小红点
  ///
  /// 默认为`false`
  final bool dot;

  /// Bagde的背景色
  ///
  /// 默认为`TDColors.red`
  final Color color;

  /// Badge的文字颜色
  ///
  /// 默认为`Colors.white`
  final Color textColor;

  /// Badge上展示的数字，优先级低于`content`
  ///
  /// 若[content], [count]都为null，则Badge展示为小红点
  final int? count;

  /// Badge上展示的数字的最大值
  ///
  /// 默认为`99`，即当`count > 99`，则显示为`99+`。
  final int maxCount;

  /// Badge上展示的自定义文字，优先级高于`count`。
  final String? content;

  /// Badge的尺寸
  ///
  /// 默认为`BadgeSize.medium`。
  final BadgeSize size;

  /// Badge的形状
  ///
  /// 默认为`BadgeShape.circle`。
  final BadgeShape shape;

  /// 在显示`count`的情况下，当`count = 0`时是否要显示Badge
  ///
  /// 默认为`false`
  final bool showZero;

  /// Badge在[child]上的位置偏移
  ///
  /// 默认的位置是[child]的右上角
  final Offset offset;

  @override
  State<StatefulWidget> createState() {
    return _BadgeState();
  }
}

class _BadgeState extends State<Badge> {
  @override
  Widget build(BuildContext context) {
    // 未传入任何显示内容且dot == false，直接返回child或空Widget。
    if (!widget.dot && widget.content == null && widget.count == null) {
      return widget.child ?? Container();
    }
    final _config = _Default.sizeSpecConfig[widget.size]!;
    final _noChild = widget.child == null;
    // 显示为dot
    if (widget.dot == true) {
      if (_noChild) {
        return _buildDotWithoutChild(_config);
      }
      return _buildDot(_config);
    }
    // 类型为ribbon
    if (widget.shape == BadgeShape.ribbon) {
      if (_noChild) {
        return Container();
      }
      return _buildRibbon(_config);
    }
    // 剩余情况：类型为circle或rounded
    if (_noChild) {
      return _buildBadgeWithoutChild(_config);
    } else {
      return _buildBadge(_config);
    }
  }

  Widget _buildDot(_BadgeSizeSpecConfig _config) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        widget.child!,
        PositionedDirectional(
          child: _buildDotWithoutChild(_config),
          top: -(widget.offset.dx + _config.dotSize / 2),
          end: -(widget.offset.dy + _config.dotSize / 2),
        )
      ],
    );
  }

  Widget _buildDotWithoutChild(_BadgeSizeSpecConfig _config) {
    return ClipRRect(
      child: Container(
        width: _config.dotSize,
        height: _config.dotSize,
        color: widget.color,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(_config.dotSize / 2),
      ),
    );
  }

  Widget _buildBadge(_BadgeSizeSpecConfig _config) {
    final textWidth =
        _calculateTextWidth(_getText(), TextStyle(fontSize: _config.textSize));
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        widget.child!,
        PositionedDirectional(
          child: _buildBadgeWithoutChild(_config),
          top: -(widget.offset.dx + _config.height / 2),
          /**
             * 利用文字的绘制宽度计算Bagde在横轴的偏移量：
             * 偏移量应为：Bagde宽度/2，即：文字绘制宽度/2 + 两侧边距。
             * 但当此偏移量小于高度/2，即宽度小于高度时，会强制使宽度=高度，Badge展示为圆形或正方形，偏移量取高度/2
             */
          end: -(widget.offset.dy +
              math.max(
                  textWidth / 2 + _config.sidePadding, _config.height / 2)),
        ),
      ],
    );
  }

  Widget _buildBadgeWithoutChild(_BadgeSizeSpecConfig _config) {
    final width = math.max(
        _calculateTextWidth(_getText(), TextStyle(fontSize: _config.textSize)) +
            _config.sidePadding * 2,
        _config.height);
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Offstage(
        offstage: widget.content == null &&
            (widget.count ?? -1) <= 0,
        child: ClipRRect(
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: _config.height,
            color: widget.color,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _config.sidePadding),
              child: Text(
                _getText(),
                style: TextStyle(
                    color: widget.textColor, fontSize: _config.textSize),
              ),
            ),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.shape == BadgeShape.circle
                ? _config.height / 2
                : _config.roundedBorderRadius),
          ),
        ),
      ),
    ]);
  }

  Widget _buildRibbon(_BadgeSizeSpecConfig _config) {
    return CustomPaint(
      foregroundPainter: _RibbonPainter(
        title: _getText(),
        color: widget.color,
        config: _config,
      ),
      child: widget.child,
    );
  }

  String _getText() {
    return widget.content ??
        (widget.count! <= widget.maxCount
            ? '${widget.count}'
            : '${widget.maxCount}+');
  }

  double _calculateTextWidth(String text, TextStyle textStyle) {
    final Size size = (TextPainter(
      text: TextSpan(text: text, style: textStyle),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;
    return size.width;
  }
}

// 缎带型Badge的绘制器
class _RibbonPainter extends CustomPainter {
  // 缎带靠近角落的侧边的与右侧边缘的距离
  double _inLength;

  // 缎带远离角落的侧边的与右侧边缘的距离
  double _outLength;

  // 传入的Badge配置数据
  final _BadgeSizeSpecConfig config;

  // 展示的文字内容
  final String title;

  // 缎带Badge主体颜色
  final Color color;

  _RibbonPainter({
    required this.title,
    required this.color,
    required this.config,
  })   : _inLength = config.ribbonIn,
        _outLength = config.ribbonOut;
  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(color: _Default.textColor, fontSize: config.textSize),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    // 配置绘制缎带的绘制器
    final paintRibbon = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    // 确定梯形缎带的绘制起点，绘制4条边
    path.moveTo(size.width - _inLength, 0);
    path.lineTo(size.width - _outLength, 0);
    path.lineTo(size.width, _outLength);
    path.lineTo(size.width, _inLength);
    path.close();
    // 文字置于缎带顶端所需偏移量
    final offsetRibbon = Offset(size.width - _inLength, 0);
    // 绘制缎带，文字的偏移、旋转
    canvas
      ..drawPath(path, paintRibbon)
      ..translate(offsetRibbon.dx, offsetRibbon.dy)
      ..rotate(math.pi / 4);
    // 绘制文字，以文字大小为因子微调文字位置
    textPainter.paint(
        canvas, Offset(-textPainter.width / 18, textPainter.height / 18));
  }

  @override
  bool shouldRepaint(_RibbonPainter oldPainter) {
    return title != oldPainter.title || color != oldPainter.color;
  }
}
