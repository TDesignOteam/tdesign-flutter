/// 评星控件
/// 
/// 提供的接口参考：http://tdesign.woa.com/vue-mobile/components/rate
/// 
/// 实现参考了 [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar)

import 'dart:math' as math;

import 'package:flutter/material.dart';

// TODO
// 支持辅助文字能力
// 删除多余的代码
// Rate字段精简
// 代码架构整理

/// Defines widgets which are to used as rating bar items.
class RatingIconConfig {
  RatingIconConfig({
    required this.full,
    required this.half,
    required this.empty,
  });

  /// Defines widget to be used as rating bar item when the item is completely rated.
  final Widget full;

  /// Defines widget to be used as rating bar item when only the half portion of item is rated.
  final Widget half;

  /// Defines widget to be used as rating bar item when the item is unrated.
  final Widget empty;
}

/// A widget to receive rating input from users.
///
/// [Rate] can also be used to display rating
class Rate extends StatefulWidget {
  /// Creates [Rate] using the [ratingIcons].
  const Rate({
    /// Customizes the Rating Bar item with [RatingWidget].
    required RatingIconConfig ratingIcons,
    required this.onRatingUpdate,
    this.color,
    this.allowHalf = false,
    this.value = 0.0,
    this.count = 5,
    this.size = 40.0,
    this.showText = false,
    this.texts = const <String>[],
    this.textColor = Colors.black54, 
    this.readOnly = false,
  })  : _itemBuilder = null,
        _ratingIcons = ratingIcons,
        _unratedColor = const Color(0xFFCCCCCC),  // lightGray
        _minRating = 0,
        _itemPadding = EdgeInsets.zero,
        _glow = false,
        _glowRadius = 2,
        _direction = Axis.horizontal,
        _updateOnDrag = false,
        _tapOnlyMode = false;

  /// Creates [Rate] using the [itemBuilder].
  const Rate.builder({
    required IndexedWidgetBuilder itemBuilder,
    required this.onRatingUpdate,
    this.color,
    this.allowHalf = false,
    this.value = 0.0,
    this.count = 5,
    this.size = 40.0,
    this.showText = false,
    this.texts = const <String>[],
    this.textColor = Colors.black54,
    this.readOnly = false,
  })  : _itemBuilder = itemBuilder,
        _ratingIcons = null,
        _unratedColor = const Color(0xFFCCCCCC),
        _minRating = 0,
        _itemPadding = EdgeInsets.zero,
        _glow = false,
        _glowRadius = 2,
        _direction = Axis.horizontal,
        _updateOnDrag = false,
        _tapOnlyMode = false;

  /// 打星粒度是否支持半星 (如：1.5星、2.5星)
  final bool allowHalf;

  /// 是否显示辅助文字
  final bool showText;

  /// 评分等级对应的辅助文字
  final List<String> texts;

  /// 辅助文字颜色
  final Color textColor;

  /// 是否只用来显示，不可操作
  /// 
  /// 默认为 `false`
  final bool readOnly;

  /// Defines the initial rating to be set to the rating bar.
  final double value;

  /// Defines total number of rating bar items.
  ///
  /// Default is 5.
  final int count;

  /// Defines width and height of each rating item in the bar.
  ///
  /// Default is 40.0
  final double size;

  /// Return current rating whenever rating is updated.
  final ValueChanged<double> onRatingUpdate;

  /// Defines color for glow.
  ///
  /// Default is [ThemeData.accentColor].
  final Color? color;

  // Defines color for the unrated portion.
  // Default is lightGray(0xcccccc).
  final Color _unratedColor;

  // Direction of rating bar.
  // Default = Axis.horizontal
  final Axis _direction;

  // if set to true, Rating Bar item will glow when being touched.
  // Default is true.
  final bool _glow;

  // Defines the radius of glow.
  // Default is 2.
  final double _glowRadius;

  // The amount of space by which to inset each rating item.
  final EdgeInsetsGeometry _itemPadding;

  // Sets minimum rating
  // Default is 0.
  final double _minRating;

  // if set to true will disable drag to rate feature. Note: Enabling this mode will disable half rating capability.
  // Default is false.
  final bool _tapOnlyMode;

  // Defines whether or not the `onRatingUpdate` updates while dragging.
  // Default is false.
  final bool _updateOnDrag;

  final IndexedWidgetBuilder? _itemBuilder;
  final RatingIconConfig? _ratingIcons;

  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  double _rating = 0.0;
  bool _isRTL = false;
  double iconRating = 0.0;

  late double _minRating, _maxRating;
  late final ValueNotifier<bool> _glow;

  @override
  void initState() {
    super.initState();
    _glow = ValueNotifier(false);
    _minRating = widget._minRating;
    _maxRating = widget.count.toDouble();
    _rating = widget.value;
  }

  @override
  void didUpdateWidget(Rate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _rating = widget.value;
    }
    _minRating = widget._minRating;
    _maxRating = widget.count.toDouble();
  }

  @override
  void dispose() {
    _glow.dispose();
    super.dispose();
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
        direction: widget._direction,
        children: List.generate(
          widget.count,
          (index) => _buildRating(context, index),
        ),
      ),
    );
  }

  Widget _buildRating(BuildContext context, int index) {
    final ratingIcons = widget._ratingIcons;
    final item = widget._itemBuilder?.call(context, index);
    final ratingOffset = widget.allowHalf ? 0.5 : 1.0;

    Widget ratingIcon;

    if (index >= _rating) {
      ratingIcon = _NoRatingIcon(
        size: widget.size,
        child: ratingIcons?.empty ?? item!,
        enableMask: ratingIcons == null,
        unratedColor: widget._unratedColor,
      );
    } else if (index >= _rating - ratingOffset && widget.allowHalf) {
      if (ratingIcons?.half == null) {
        ratingIcon = _HalfRatingIcon(
          size: widget.size,
          child: item!,
          enableMask: ratingIcons == null,
          rtlMode: _isRTL,
          unratedColor: widget._unratedColor,
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

  bool get _isHorizontal => widget._direction == Axis.horizontal;

  void _onDragUpdate(DragUpdateDetails dragDetails) {
    if (!widget._tapOnlyMode) {
      final box = context.findRenderObject() as RenderBox?;
      if (box == null) return;

      final _pos = box.globalToLocal(dragDetails.globalPosition);
      double i;
      if (widget._direction == Axis.horizontal) {
        i = _pos.dx / (widget.size + widget._itemPadding.horizontal);
      } else {
        i = _pos.dy / (widget.size + widget._itemPadding.vertical);
      }
      var currentRating = widget.allowHalf ? i : i.round().toDouble();
      if (currentRating > widget.count) {
        currentRating = widget.count.toDouble();
      }
      if (currentRating < 0) {
        currentRating = 0.0;
      }
      if (_isRTL && widget._direction == Axis.horizontal) {
        currentRating = widget.count - currentRating;
      }

      _rating = currentRating.clamp(_minRating, _maxRating);
      if (widget._updateOnDrag) widget.onRatingUpdate(iconRating);
      setState(() {});
    }
  }

  void _onDragStart(DragStartDetails details) {
    _glow.value = true;
  }

  void _onDragEnd(DragEndDetails details) {
    _glow.value = false;
    widget.onRatingUpdate(iconRating);
    iconRating = 0.0;
  }

  // 手势事件处理
  Widget _gestureDetector(int index, Widget ratingIcon) {
    return GestureDetector(
        onTapDown: (details) {
          double value;
          if (index == 0 && (_rating == 1 || _rating == 0.5)) {
            value = 0;
          } else {
            final tappedPosition = details.localPosition.dx;
            final tappedOnFirstHalf = tappedPosition <= widget.size / 2;
            value = index +
                (tappedOnFirstHalf && widget.allowHalf ? 0.5 : 1.0);
          }

          value = math.max(value, widget._minRating);
          widget.onRatingUpdate(value);
          _rating = value;
          setState(() {});
        },
        onHorizontalDragStart: _isHorizontal ? _onDragStart : null,
        onHorizontalDragEnd: _isHorizontal ? _onDragEnd : null,
        onHorizontalDragUpdate: _isHorizontal ? _onDragUpdate : null,
        onVerticalDragStart: _isHorizontal ? null : _onDragStart,
        onVerticalDragEnd: _isHorizontal ? null : _onDragEnd,
        onVerticalDragUpdate: _isHorizontal ? null : _onDragUpdate,
        child: Padding(
          padding: widget._itemPadding,
          child: ValueListenableBuilder<bool>(
            valueListenable: _glow,
            builder: (context, glow, child) {
              if (glow && widget._glow) {
                final glowColor =
                    widget.color ?? Theme.of(context).accentColor;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withAlpha(30),
                        blurRadius: 10,
                        spreadRadius: widget._glowRadius,
                      ),
                      BoxShadow(
                        color: glowColor.withAlpha(20),
                        blurRadius: 10,
                        spreadRadius: widget._glowRadius,
                      ),
                    ],
                  ),
                  child: child,
                );
              }
              return child!;
            },
            child: ratingIcon,
          ),
        ),
      );
  }
}

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
