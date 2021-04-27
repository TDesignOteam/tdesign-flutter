/// 评星控件
/// 
/// 实现参考了 [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar)

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

/// 配置Rate项的图标 (支持图片)
class RatingIconConfig {
  RatingIconConfig({
    required this.full,
    required this.half,
    required this.empty,
  });

  /// 选中某项时所使用的图标
  final Widget full;

  /// 当支持的粒度为半星时，选择了半颗星时所使用的图标
  final Widget half;

  /// 未选时使用的图标
  final Widget empty;
}

/// 评分组件
///
/// 能力及接口参考：[TDesign Mobile Rate](http://tdesign.woa.com/vue-mobile/components/rate)
/// 
/// 使用示例：
/// ``` dart
/// Rate(
///   value: 2,
///   count: 5,
/// )
/// ```
class Rate extends StatefulWidget {
  /// 构造 [Rate]
  /// 
  /// 图标配置方式有两种：(当这两个参数都不设置时，使用默认的)
  /// - 在创建 [Rate] 时就通过 [ratingIcons] 来配置
  /// - 在运行时，通过设置的 [itemBuilder] 来获取
  const Rate({
    RatingIconConfig? ratingIcons,
    IndexedWidgetBuilder? itemBuilder,
    this.onRatingUpdate,
    this.color = const Color(0xfff1ad3d),
    this.allowHalf = false,
    this.value = 0.0,
    this.count = 5,
    this.size = 40.0,
    this.showText = false,
    this.texts = const <String>[],
    this.textColor = const Color(0xffe8e8e8), 
    this.readOnly = false, 
    this.textSize = 14,
  })  : _itemBuilder = itemBuilder,
        _ratingIcons = ratingIcons;

  /// 打星粒度是否支持半星 (如：1.5星、2.5星)
  final bool allowHalf;

  /// 是否显示辅助文字
  /// 
  /// 默认值为 `false`
  final bool showText;

  /// 评分等级对应的辅助文字
  final List<String> texts;

  /// 辅助文字颜色
  /// 
  /// 默认值为 `Color(0xffe8e8e8)`
  final Color textColor;

  /// 辅助文字大小
  /// 
  /// 默认值为 `14`
  final double textSize;

  /// 是否只用来显示，不可操作
  /// 
  /// 默认值为 `false`
  final bool readOnly;

  /// 当前评分值
  /// 
  /// 默认值为 `0`
  final double value;

  /// 评分组件中有几个Item
  ///
  /// 默认值为 `5`
  final int count;

  /// 评分项的尺寸大小
  ///
  /// 默认值为 `40.0`
  final double size;

  /// 获取评分结果，每次变化时都会通知出去
  /// 
  /// 可选的，当组件仅用来展示数据时，外部就没必要设置该回调
  final ValueChanged<double>? onRatingUpdate;

  /// 评分图标的颜色
  ///
  /// 默认值为 `Color(0xfff1ad3d)`
  final Color color;

  final IndexedWidgetBuilder? _itemBuilder;
  final RatingIconConfig? _ratingIcons;

  @override
  _RateState createState() => _RateState();
}

// 几处默认配置项
abstract class _Default {
  // 未选择的评分组件颜色
  static const unratedColor = const Color(0xFFCCCCCC);  // lightGray

  // 评分组件的方向，配置为水平
  static const direction = Axis.horizontal;

  // 是否支持拖拽评分
  static const supportDrag = true;

  // 评分item之间的间距
  static const itemPadding = EdgeInsets.zero;

  // 评星与描述之间的间距
  static const descPadding = 20.0;

  // 传入color，返回默认构造Rate Item的构造器
  static final IndexedWidgetBuilder Function(Color color) itemBuilder = (color) => (_, __) => Icon(TDIcons.starFilled, color: color);
}

class _RateState extends State<Rate> {
  double _rating = 0.0;
  bool _isRTL = false;
  double iconRating = 0.0;

  late double _minRating, _maxRating;

  @override
  void initState() {
    super.initState();
    _minRating = 0;
    _maxRating = widget.count.toDouble();
    _rating = widget.value;
  }

  @override
  void didUpdateWidget(Rate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _rating = widget.value;
    }
    _minRating = 0;
    _maxRating = widget.count.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    _isRTL = textDirection == TextDirection.rtl;
    iconRating = 0.0;

    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.start,
        textDirection: textDirection,
        direction: _Default.direction,
        children: _buildAll(context),
      ),
    );
  }

  List<Widget> _buildAll(BuildContext context) {
    var widgets = List.generate(
      widget.count,
      (index) => _buildRating(context, index),
    );
    if (!widget.showText) {
      return widgets;
    }

    // 评星跟描述之间添加一个间距
    widgets.add(SizedBox(width: _Default.descPadding)); 

    widgets.add(_buildDesc(context));
    return widgets;
  }

  Widget _buildRating(BuildContext context, int index) {
    final ratingIcons = widget._ratingIcons;
    final itemBuilder = widget._itemBuilder ?? _Default.itemBuilder(widget.color);
    final item = itemBuilder(context, index);
    final ratingOffset = widget.allowHalf ? 0.5 : 1.0;

    Widget ratingIcon;

    if (index >= _rating) {
      ratingIcon = _NoRatingIcon(
        size: widget.size,
        child: ratingIcons?.empty ?? item,
        enableMask: ratingIcons == null,
        unratedColor: _Default.unratedColor,
      );
    } else if (index >= _rating - ratingOffset && widget.allowHalf) {
      if (ratingIcons?.half == null) {
        ratingIcon = _HalfRatingIcon(
          size: widget.size,
          child: item,
          enableMask: ratingIcons == null,
          rtlMode: _isRTL,
          unratedColor: _Default.unratedColor,
        );
      } else {
        ratingIcon = SizedBox(
          width: widget.size,
          height: widget.size,
          child: FittedBox(
            fit: BoxFit.contain,
            child: _isRTL
                ? Transform(
                    transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                    alignment: Alignment.center,
                    transformHitTests: false,
                    child: ratingIcons!.half,
                  )
                : ratingIcons!.half,
          ),
        );
      }
      iconRating += 0.5;
    } else {
      ratingIcon = SizedBox(
        width: widget.size,
        height: widget.size,
        child: FittedBox(
          fit: BoxFit.contain,
          child: ratingIcons?.full ?? item,
        ),
      );
      iconRating += 1.0;
    }

    return IgnorePointer(
      ignoring: widget.readOnly,
      child: _gestureDetector(index, ratingIcon),
    );
  }

  Widget _buildDesc(BuildContext context) {
    return SizedBox(
      height: widget.size,
      child: FittedBox(
        fit: BoxFit.none,
        child: Text(
          _descTitle(),
          style: TextStyle(
            color: widget.textColor,
            fontSize: widget.textSize
          ),
        )
      ),
    );
  }

  bool get _isHorizontal => _Default.direction == Axis.horizontal;

  void _onDragUpdate(DragUpdateDetails dragDetails) {
    if (_Default.supportDrag) {
      final box = context.findRenderObject() as RenderBox?;
      if (box == null) return;

      final _pos = box.globalToLocal(dragDetails.globalPosition);
      double i;
      if (_isHorizontal) {
        i = _pos.dx / (widget.size + _Default.itemPadding.horizontal);
      } else {
        i = _pos.dy / (widget.size + _Default.itemPadding.vertical);
      }
      var currentRating = widget.allowHalf ? i : i.round().toDouble();
      if (currentRating > widget.count) {
        currentRating = widget.count.toDouble();
      }
      if (currentRating < 0) {
        currentRating = 0.0;
      }
      if (_isRTL && _isHorizontal) {
        currentRating = widget.count - currentRating;
      }

      _rating = currentRating.clamp(_minRating, _maxRating);
      setState(() {});
    }
  }

  void _onDragEnd(DragEndDetails details) {
    widget.onRatingUpdate?.call(iconRating);
    iconRating = 0.0;
  }

  // 手势事件处理
  Widget _gestureDetector(int index, Widget ratingIcon) {
    return GestureDetector(
        onTapDown: (details) {
          double value;
          // 当点击第一个icon时，就表示打1分或取消打1分（或0.5分）的逻辑
          if (index == 0 && (_rating == 1 || _rating == 0.5)) {
            value = 0;
          } else {
            final tappedPosition = details.localPosition.dx;
            final tappedOnFirstHalf = tappedPosition <= widget.size / 2;
            value = index +
                (tappedOnFirstHalf && widget.allowHalf ? 0.5 : 1.0);
          }

          value = math.max(value, _minRating);
          widget.onRatingUpdate?.call(value);
          _rating = value;
          setState(() {});
        },
        onHorizontalDragEnd: _isHorizontal ? _onDragEnd : null,
        onHorizontalDragUpdate: _isHorizontal ? _onDragUpdate : null,
        onVerticalDragEnd: _isHorizontal ? null : _onDragEnd,
        onVerticalDragUpdate: _isHorizontal ? null : _onDragUpdate,
        child: Padding(
          padding: _Default.itemPadding,
          child: ratingIcon
        ),
      );
  }
}

extension _RateStatePrivate on _RateState {
  // 获取要显示的文案内容
  String _descTitle() {
    // 如果支持半星粒度，则每增加半颗星，就获取下一个详情
    // 但详情描述不够时，就一直返回最后一个
    final index = (_rating * (widget.allowHalf ? 2 : 1)).ceil();
    if (widget.texts.length > index) {
      return widget.texts[index];
    } else if (widget.texts.length > 0) {
      return widget.texts.last;
    }
    return '';
  }
}

// 在打星的图标上面加一半的蒙层，加蒙层的部分看起来就像未打星一样
class _HalfRatingIcon extends StatelessWidget {
  _HalfRatingIcon({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.rtlMode,
    required this.unratedColor,
  });

  final Widget child;
  final double size;
  final bool enableMask;
  final bool rtlMode;
  final Color unratedColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: enableMask
          ? Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: _NoRatingIcon(
                    child: child,
                    size: size,
                    unratedColor: unratedColor,
                    enableMask: enableMask,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: ClipRect(
                    clipper: _HalfClipper(
                      rtlMode: rtlMode,
                    ),
                    child: child,
                  ),
                ),
              ],
            )
          : FittedBox(
              child: child,
              fit: BoxFit.contain,
            ),
    );
  }
}

class _HalfClipper extends CustomClipper<Rect> {
  _HalfClipper({required this.rtlMode});

  final bool rtlMode;

  @override
  Rect getClip(Size size) => rtlMode
      ? Rect.fromLTRB(
          size.width / 2,
          0.0,
          size.width,
          size.height,
        )
      : Rect.fromLTRB(
          0.0,
          0.0,
          size.width / 2,
          size.height,
        );

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

// 支持在未打星的Icon上面加蒙层，这样就可以不提供NoRating的Icon
// 通过与未打星的颜色混合得到
class _NoRatingIcon extends StatelessWidget {
  _NoRatingIcon({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.unratedColor,
  });

  final double size;
  final Widget child;
  final bool enableMask;
  final Color unratedColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child: enableMask
            ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                  unratedColor,
                  BlendMode.srcIn,
                ),
                child: child,
              )
            : child,
      ),
    );
  }
}
