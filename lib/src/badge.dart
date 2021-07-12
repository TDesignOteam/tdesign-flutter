//  Created by lyrisli on 2021/4/26.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

/// 徽标控件

import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';
import 'dart:math' as math;

/// Badge支持的预设尺寸枚举
enum TDBadgeSize { medium, small }

/// Badge的形状枚举
enum TDBadgeShape { circle, rounded, ribbon }

// 会基于Badge尺寸变化的特定配置
class _BadgeSizeSpecConfig {
  // Badge类型为`BadgeShape.rounded`时，Badge的圆角半径
  final double roundedBorderRadius;

  // Badge上文字的字体大小
  final double textSize;

  // 文字两侧的边距，用于略微加宽Badge
  final double sidePadding;

  // Badge为圆点时圆点大小
  final double dotSize;

  // Badge类型为`BadgeShape.Rib`时，缎带靠近角落的侧边的与右侧边缘的距离
  final double ribbonIn;

  // Badge类型为`BadgeShape.Rib`时，缎带远离角落的侧边的与右侧边缘的距离
  final double ribbonOut;

  // Badge类型为`BadgeShape.Rib`时，使文字对齐缎带的偏移半径
  final double ribbonOffset;

  const _BadgeSizeSpecConfig({
    required this.roundedBorderRadius,
    required this.textSize,
    required this.sidePadding,
    required this.dotSize,
    required this.ribbonIn,
    required this.ribbonOut,
    required this.ribbonOffset,
  });
}

// 默认配置
abstract class _Default {
  // 不同`size`的Badge所对应的默认配置
  static const Map<TDBadgeSize, _BadgeSizeSpecConfig> sizeSpecConfig = {
    TDBadgeSize.medium: _BadgeSizeSpecConfig(
      roundedBorderRadius: 4,
      textSize: 14,
      sidePadding: 3,
      dotSize: 8,
      ribbonIn: 18,
      ribbonOut: 45,
      ribbonOffset: 9.5,
    ),
    TDBadgeSize.small: _BadgeSizeSpecConfig(
      roundedBorderRadius: 3,
      textSize: 11,
      sidePadding: 2,
      dotSize: 6,
      ribbonIn: 15,
      ribbonOut: 35,
      ribbonOffset: 7.5,
    ),
  };

  // Badge是否显示为点状的默认值
  static const dot = false;

  // Badge显示数字时的最大值的默认值
  static const maxCount = 99;

  // Badge大小未设置时的的默认值
  static const size = TDBadgeSize.medium;

  // Badge形状未设置时的默认形状
  static const shape = TDBadgeShape.circle;

  // Badge显示数字时是否显示0的默认值
  static const showZero = false;

  // Badge的默认位移
  static const offset = const Offset(0, 0);
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
class TDBadge extends StatefulWidget {
  const TDBadge({
    this.child,
    this.dot = _Default.dot,
    this.color,
    this.textColor,
    this.count,
    this.maxCount = _Default.maxCount,
    this.content,
    this.size = _Default.size,
    this.shape = _Default.shape,
    this.showZero = _Default.showZero,
    this.offset = _Default.offset,
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
  final Color? color;

  /// Badge的文字颜色
  ///
  /// 默认为`Colors.white`
  final Color? textColor;

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
  final TDBadgeSize size;

  /// Badge的形状
  ///
  /// 默认为`BadgeShape.circle`。
  final TDBadgeShape shape;

  /// 在显示`count`的情况下，当`count = 0`时是否要显示Badge
  ///
  /// 默认为`false`
  final bool showZero;

  /// Badge在[child]上的位置偏移
  ///
  /// 默认的位置是[child]的右上角
  final Offset offset;

  @override
  State<StatefulWidget> createState() => _BadgeState();
}

class _BadgeState extends State<TDBadge> {
  TDTheme? theme;

  @override
  Widget build(BuildContext context) {
    theme = TDTheme.of(context);
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
    if (widget.shape == TDBadgeShape.ribbon) {
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
        color: widget.color ?? theme?.themeColor.errorColor ?? TDColors.red,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(_config.dotSize / 2),
      ),
    );
  }

  Widget _buildBadge(_BadgeSizeSpecConfig _config) {
    final size = _calculateTextSize(_getText(), TextStyle(fontSize: _config.textSize));
    final textWidth = size.width;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        widget.child!,
        PositionedDirectional(
          child: _buildBadgeWithoutChild(_config),
          top: -(widget.offset.dx + size.height / 2),
          /**
             * 利用文字的绘制宽度计算Bagde在横轴的偏移量：
             * 偏移量应为：Bagde宽度/2，即：文字绘制宽度/2 + 两侧边距。
             * 但当此偏移量小于高度/2，即宽度小于高度时，会强制使宽度=高度，Badge展示为圆形或正方形，偏移量取高度/2
             */
          end: -(widget.offset.dy + math.max(textWidth / 2 + _config.sidePadding, size.height / 2)),
        ),
      ],
    );
  }

  Widget _buildBadgeWithoutChild(_BadgeSizeSpecConfig _config) {
    final size = _calculateTextSize(_getText(), TextStyle(fontSize: _config.textSize));
    final width = math.max(size.width + _config.sidePadding * 2, size.height);
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Offstage(
        offstage: (widget.content == null && (widget.count ?? -1) < 0) || (!widget.showZero && widget.count == 0),
        child: ClipRRect(
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: size.height,
            color: widget.color ?? theme?.themeColor.errorColor ?? TDColors.red,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _config.sidePadding),
              child: Text(
                _getText(),
                style: TextStyle(
                  color: widget.textColor ?? theme?.themeColor.textAntiPrimaryColor ?? TDColors.fontBlack,
                  fontSize: _config.textSize,
                ),
              ),
            ),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.shape == TDBadgeShape.circle ? size.height / 2 : _config.roundedBorderRadius),
          ),
        ),
      ),
    ]);
  }

  Widget _buildRibbon(_BadgeSizeSpecConfig _config) {
    return CustomPaint(
      foregroundPainter: _RibbonPainter(
        title: _getText(),
        color: widget.color ?? theme?.themeColor.errorColor ?? TDColors.red,
        textColor: widget.textColor ?? theme?.themeColor.textAntiPrimaryColor ?? TDColors.fontWhite,
        config: _config,
      ),
      child: widget.child,
    );
  }

  String _getText() {
    return widget.content ?? (widget.count! <= widget.maxCount ? '${widget.count}' : '${widget.maxCount}+');
  }

  Size _calculateTextSize(String text, TextStyle textStyle) {
    final Size size = (TextPainter(
      text: TextSpan(text: text, style: textStyle),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;
    return size;
  }
}

// 缎带型Badge的绘制器
class _RibbonPainter extends CustomPainter {
  // 缎带靠近角落的侧边的与右侧边缘的距离
  double inLength;

  // 缎带远离角落的侧边的与右侧边缘的距离
  double outLength;

  // 传入的Badge配置数据
  final _BadgeSizeSpecConfig config;

  // 展示的文字内容
  final String title;

  // 展示的文字颜色
  final Color textColor;

  // 缎带Badge主体颜色
  final Color color;

  _RibbonPainter({
    required this.title,
    required this.color,
    required this.textColor,
    required this.config,
  })  : inLength = config.ribbonIn,
        outLength = config.ribbonOut;
  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(color: textColor, fontSize: config.textSize),
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
    path.moveTo(size.width - inLength, 0);
    path.lineTo(size.width - outLength, 0);
    path.lineTo(size.width, outLength);
    path.lineTo(size.width, inLength);
    path.close();
    // 文字置于缎带上方所需偏移量(优先满足下方以大小为因子的调整后，微调使文字位置正确)
    final offsetRibbon = Offset(size.width - inLength + config.ribbonOffset, config.ribbonOffset);
    // 绘制缎带，文字的偏移、旋转
    canvas
      ..drawPath(path, paintRibbon)
      ..translate(offsetRibbon.dx, offsetRibbon.dy)
      ..rotate(math.pi / 4);
    // 绘制文字，以文字大小为因子调整文字位置(横向必须为宽度的一半，使文字中心位置始终在缎带中心)
    textPainter.paint(canvas, Offset(-textPainter.width / 2, textPainter.height / 10));
  }

  @override
  bool shouldRepaint(_RibbonPainter oldPainter) {
    return title != oldPainter.title || color != oldPainter.color;
  }
}
