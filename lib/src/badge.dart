/// 评星控件
///
/// 能力参考：http://tdesign.woa.com/vue-mobile/components/badge

import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';
import 'dart:math' as math;

/// Badge支持的预设尺寸
enum BadgeSize { medium, small }

/// Badge的形状
enum BadgeShape { circle, rounded, ribbon }

class _BadgeSizeConfig {
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

  /// Badge类型为`BadgeShape.Rib`时，较短侧边的长度
  final double ribbonIn;

  /// Badge类型为`BadgeShape.Rib`时，较长侧边的长度
  final double ribbonOut;
  const _BadgeSizeConfig({
    required this.height,
    required this.roundedBorderRadius,
    required this.textSize,
    required this.sidePadding,
    required this.dotSize,
    required this.ribbonIn,
    required this.ribbonOut,
  });
}

/// 默认配置
abstract class _Default {
  /// 不同`size`的Badge所对应的默认配置
  static const Map<BadgeSize, _BadgeSizeConfig> _sizeSpecConfig = {
    BadgeSize.medium: _BadgeSizeConfig(
      height: 17,
      roundedBorderRadius: 4,
      textSize: 13.5,
      sidePadding: 3,
      dotSize: 8,
      ribbonIn: 18,
      ribbonOut: 45,
    ),
    BadgeSize.small: _BadgeSizeConfig(
        height: 14,
        roundedBorderRadius: 2,
        textSize: 10.5,
        sidePadding: 2,
        dotSize: 6,
        ribbonIn: 11,
        ribbonOut: 30),
  };

  /// 文字颜色
  static const textColor = Colors.white;

  /// Badge主体颜色
  static const color = TDColors.red;
}

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
    if (!widget.dot && widget.content == null && widget.count == null) {
      return widget.child == null ? Container() : widget.child!;
    }
    final _config = _Default._sizeSpecConfig[widget.size]!;
    final _defaultOffset =
        widget.dot ? _config.dotSize / 2 : _config.height / 2;
    if (widget.shape == BadgeShape.ribbon) {
      return _buildRibbon(_config);
    }
    if (widget.child == null) {
      return _getBadge(_config);
    }
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        widget.child!,
        PositionedDirectional(
            child: _getBadge(_config),
            top: -(widget.offset.dx + _defaultOffset),
            end: -(widget.offset.dy + _defaultOffset))
      ],
    );
  }

  Widget _getBadge(_BadgeSizeConfig _config) {
    final Widget content;
    if (widget.dot) {
      content = _buildDot(_config);
    } else if (widget.content == null && widget.count == null) {
      content = Container();
    } else {
      content = _buildContent(_config);
    }
    return Row(mainAxisSize: MainAxisSize.min, children: [content]);
  }

  Widget _buildDot(_BadgeSizeConfig _config) {
    return ClipRRect(
        child: Container(
          width: _config.dotSize,
          height: _config.dotSize,
          color: widget.color,
        ),
        borderRadius: BorderRadius.all(Radius.circular(_config.dotSize / 2)));
  }

  Widget _buildContent(_BadgeSizeConfig _config) {
    return Offstage(
        offstage: widget.content == null &&
            widget.count != null &&
            widget.count! <= 0,
        child: ClipRRect(
          child: Container(
              alignment: Alignment.center,
              width: widget.count != null && widget.count! < 10
                  ? _config.height
                  : null,
              height: _config.height,
              color: widget.color,
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: _config.sidePadding),
                  child: Text(
                    _getText(),
                    style: TextStyle(
                        color: widget.textColor, fontSize: _config.textSize),
                  ))),
          borderRadius: BorderRadius.all(Radius.circular(
              widget.shape == BadgeShape.circle
                  ? _config.height / 2
                  : _config.roundedBorderRadius)),
        ));
  }

  Widget _buildRibbon(_BadgeSizeConfig _config) {
    // 缎带型组件不能独立存在，child必须不为空。
    if (widget.child == null) {
      return Container();
    }
    return CustomPaint(
      foregroundPainter: _RibbonPainter(
          title: _getText(), color: widget.color, config: _config),
      child: widget.child,
    );
  }

  String _getText() {
    return widget.content != null
        ? widget.content!
        : widget.count! <= widget.maxCount
            ? '${widget.count}'
            : '${widget.maxCount}+';
  }
}

/// 缎带型Badge`BadgeShape.ribbon`的绘制器
class _RibbonPainter extends CustomPainter {
  double _inLength;
  double _outLength;

  final _BadgeSizeConfig config;

  final String title;
  final Color color;

  TextPainter? textPainter;
  Paint? paintRibbon;
  Path? pathRibbon;
  double? rotateRibbon;
  Offset? offsetRibbon;
  Offset? offsetTitle;
  Paint? paintShadow;
  _RibbonPainter({
    required this.title,
    required this.color,
    required this.config,
  })   : _inLength = config.ribbonIn,
        _outLength = config.ribbonOut;
  @override
  void paint(Canvas canvas, Size size) {
    _init(size);
    canvas
      ..drawPath(pathRibbon!, paintRibbon!)
      ..translate(offsetRibbon!.dx, offsetRibbon!.dy)
      ..rotate(rotateRibbon!);
    textPainter!.paint(canvas, offsetTitle!);
  }

  @override
  bool shouldRepaint(_RibbonPainter oldDelegate) {
    return title != oldDelegate.title || color != oldDelegate.color;
  }

  void _init(Size size) {
    if (_outLength > size.width) {
      _outLength = size.width;
    }
    TextSpan span = TextSpan(
        text: title,
        style: TextStyle(color: _Default.textColor, fontSize: config.textSize));
    textPainter = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter!.layout();
    paintRibbon = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    offsetTitle = Offset(-textPainter!.width / 2.1, -textPainter!.height / 1.8);
    rotateRibbon = _rotation;
    pathRibbon = _ribbonPath(size);
  }

  Path _ribbonPath(Size size) {
    Path path = Path();
    List<Offset> vec = [];
    path.moveTo(size.width - _inLength, 0);
    vec.add(Offset(size.width - _inLength, 0));
    path.lineTo(size.width - _outLength, 0);
    vec.add(Offset(size.width - _outLength, 0));
    path.lineTo(size.width, _outLength);
    vec.add(Offset(size.width, _outLength));
    path.lineTo(size.width, _inLength);
    vec.add(Offset(size.width, _inLength));
    path.close();
    offsetRibbon = _center(vec);
    return path;
  }

  double get _rotation {
    return math.pi / 4;
  }

  Offset _center(List<Offset> vecs) {
    double sumX = 0, sumY = 0, sumS = 0;
    double x1 = vecs[0].dx;
    double y1 = vecs[0].dy;
    double x2 = vecs[1].dx;
    double y2 = vecs[1].dy;
    double x3, y3;
    for (int i = 2; i < vecs.length; i++) {
      x3 = vecs[i].dx;
      y3 = vecs[i].dy;
      double s = ((x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1)) / 2.0;
      sumX += (x1 + x2 + x3) * s;
      sumY += (y1 + y2 + y3) * s;
      sumS += s;
      x2 = x3;
      y2 = y3;
    }
    double cx = sumX / sumS / 3.0;
    double cy = sumY / sumS / 3.0;
    return Offset(cx, cy);
  }
}
