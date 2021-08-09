import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign/tdesign.dart';

/// NoticeBar支持的主题类型枚举
enum TDNoticeBarType { info, error }

/// NoticeBar支持的显示模式枚举
enum TDNoticeBarMode { normal, text, link, closeable }

// 配置默认项
abstract class _Default {
  // NoticeBar 默认的主题类型为 TDNoticeBarType.info，不同的主题类型将会影响NoticeBar的颜色。
  static const type = TDNoticeBarType.info;

  // NoticeBar 默认的显示模式为 TDNoticeBarMode.normal，显示模式将会影响icon的显示。
  static const mode = TDNoticeBarMode.normal;

  // 文本信息是否需要滚动显示。
  static const scrollable = false;

  // 文本信息滚动播放的速度。
  static const speed = 50;

  // 文本信息滚动播放动画的延迟（ms）。
  static const delay = 1000;
}

/// 通知栏组件
///
/// 能力及接口参考：[TDesign Mobile NoticeBar](http://tdesign.woa.com/vue-mobile/components/noticebar)
///
/// 使用示例：
/// ``` dart
/// TDNoticeBar(
///   text: _text,
///   scrollable: true,
/// )
/// ```
class TDNoticeBar extends StatefulWidget {
  const TDNoticeBar({
    Key? key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.scrollable = _Default.scrollable,
    this.type = _Default.type,
    this.mode = _Default.mode,
    this.leftIcon,
    this.iconColor,
    this.detailText,
    this.detailTextColor,
    this.speed = _Default.speed,
    this.delay = _Default.delay,
    this.onClose,
    this.onDetail,
    this.onLink,
  })  : assert(speed > 0, 'scroll speed must be a num greater than 0 !'),
        assert(delay > 0, 'delay must be a num greater than 0 !'),
        super(key: key);

  /// NoticeBar所显示的文本信息。
  ///
  /// 文本信息可以选择`滚动显示`和`静态显示`两种方式，通过[scrollable]来进行设置。
  final String text;

  /// 文本信息的颜色。
  ///
  /// 用户没有指定该颜色的情况下，将会根据显示主题[type]来确定[textColor]的默认值。
  final Color? textColor;

  /// 背景的颜色。
  ///
  /// 用户没有指定该颜色的情况下，将会根据显示主题[type]来确定[backgroundColor]的默认值。
  final Color? backgroundColor;

  /// 文本信息是否需要滚动显示。
  ///
  /// 默认值为`false`，并且只有当文本信息长度大于NoticeBar可展示文本的最大长度的时候生效。
  /// 该设置生效时，文本信息将会循环滚动显示。
  final bool scrollable;

  /// NoticeBar的主题类型。
  ///
  /// 默认值为`TDNoticeBarType.info`，该属性的设置将会影响[textColor]、[detailTextColor]、[backgroundColor]、[iconColor]的默认值。
  ///
  /// 当[type]为`TDNoticeBarType.info`时，[textColor]、[detailTextColor]和[iconColor]的默认值为`TDTheme.themeColor.primaryColor`，
  /// [backgroundColor]的默认值为`TDTheme.themeColor.primaryColorDisabled`
  ///
  /// 当[type]为`TDNoticeBarType.error`时，[textColor]、[detailTextColor]和[iconColor]的默认值为`TDTheme.themeColor.errorColor`，
  /// [backgroundColor]的默认值为`TDTheme.themeColor.errorColorDisabled`
  final TDNoticeBarType type;

  /// NoticeBar的显示模式。
  ///
  /// 默认值为`TDNoticeBarMode.normal`，该属性的设置将会影响NoticeBar的显示布局。
  /// 当[mode]为`TDNoticeBarMode.normal`时，将会展示[leftIcon]和[text]两部分内容。
  ///
  /// 当[mode]为`TDNoticeBarMode.text`时，将会只展示[text]这部分内容。
  ///
  /// 当[mode]为`TDNoticeBarMode.closeable`时，将会展示[leftIcon]、[text]和[rightIcon]三部分内容，
  /// 并且[rightIcon]部分的图标为`Icons.close`，点击后会调用[onClose]方法
  ///
  /// 当[mode]为`TDNoticeBarMode.closeable`时，将会展示[leftIcon]、[text]和[rightIcon]三部分内容，
  /// 并且[rightIcon]部分的图标为`Icons.keyboard_arrow_right`，点击后会调用[onLink]方法
  final TDNoticeBarMode mode;

  /// NoticeBar左侧的Icon。
  ///
  /// 在[mode]为`TDNoticeBarMode.normal`、`TDNoticeBarMode.closeable`、`TDNoticeBarMode.link`时会显示，
  /// 当[mode]为`TDNoticeBarMode.normal`、`TDNoticeBarMode.link`时，默认值为`Icons.info`
  /// 当[mode]为`TDNoticeBarMode.closeable`时，默认值为`Icons.volume_up`
  final IconData? leftIcon;

  /// 文本信息左右两侧Icon的颜色。
  ///
  /// 用户没有指定该颜色的情况下，将会根据显示主题[type]来确定[iconColor]的默认值。
  final Color? iconColor;

  /// detail链接对应的文本消息。
  ///
  /// 在[detailText]为空的情况下，[text]显示的最大行数为2行，超出部分会用`TextOverflow.ellipsis`方式省略，
  /// 若[detailText]不为空时，会显示完整的[text]内容和[detailText]，点击会调用[onDetail]函数
  /// 若[scrollable]为true，则[detailText]不生效。
  final String? detailText;

  /// detailText的显示颜色。
  ///
  /// 用户没有指定该颜色的情况下，将会根据显示主题[type]来确定[detailTextColor]的默认值。
  final Color? detailTextColor;

  /// 文本信息滚动显示的速度。
  ///
  /// 文本信息在每个滚动周期[delay]移动的像素值的大小，最终文本滚动的快慢由[speed]/[delay]决定。
  /// 默认值为`50`。
  final int speed;

  /// 文本信息滚动动画的延迟 (ms)。
  ///
  /// 默认值为`1000`。
  final int delay;

  /// 点击close图标时执行的方法。
  ///
  /// 只有在[mode]为`TDNoticeBarMode.closeable`时生效，示例：
  ///
  /// ```dart
  /// TDNoticeBar(
  ///   text: _text,
  ///   mode: TDNoticeBarMode.closeable,
  ///   onClose: () {
  ///   ...
  ///   do something when close the NoticeBar
  ///   ...
  ///   },
  /// ),
  /// ```
  final Function? onClose;

  /// 点击link图标时执行的方法。
  ///
  /// 只有在[mode]为`TDNoticeBarMode.link`时生效。
  final Function? onLink;

  /// 点击detailText文本信息时执行的方法。
  ///
  /// 只有在[detailText]不为null时生效。
  final Function? onDetail;

  @override
  _TDNoticeBarState createState() => _TDNoticeBarState();
}

class _TDNoticeBarState extends State<TDNoticeBar> {
  final _controller = ScrollController();
  final spaceWidth = 300.0;
  bool showNoticeBar = true;
  Color? defaultForegroundColor;
  Color? defaultBackgroundColor;
  Timer? _timer;
  TDTheme? theme;

  @override
  void initState() {
    // 设置滚动事件
    if (widget.scrollable) {
      _initScroll();
    }
    super.initState();
  }

  _initScroll() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // 判断文本信息长度是否超过可显示的长度
      if ((_controller.position.maxScrollExtent - spaceWidth) > _controller.position.extentInside) {
        _timer ??= Timer.periodic(Duration(milliseconds: widget.delay), (timer) {
          double maxScrollExtent = _controller.position.maxScrollExtent;
          double position = _controller.position.pixels;
          double width = _controller.position.extentInside;

          /**
           * 判断文本信息是否已经滚动到尾部
           * 这里通过重复两本[text]中文本的方式，达到循环滚动的效果，
           * 当第二遍文字快要滚动到结尾的时候，跳转到第一段文字的同样位置
           */
          if (position + widget.speed >= maxScrollExtent) {
            position = (maxScrollExtent - spaceWidth + width) * 0.5 + position - (width + maxScrollExtent);
            _controller.jumpTo(position);
          }
          position += widget.speed;
          _controller.animateTo(
            position,
            duration: Duration(milliseconds: widget.delay),
            curve: Curves.linear,
          );
        });
      }
    });
  }

  @override
  void didUpdateWidget(TDNoticeBar oldWidget) {
    // 设置滚动事件，需要判断一下NoticeBar是否close
    if (widget.scrollable && showNoticeBar) {
      _initScroll();
    } else {
      _timer?.cancel();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 根据type初始化defaultColor的值
    _initColors();

    return Visibility(
      visible: showNoticeBar,
      child: Container(
        decoration: BoxDecoration(color: widget.backgroundColor ?? defaultBackgroundColor),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildLeftIcon(context),
            _buildText(context),
            ..._buildRightIcon(context),
          ],
        ),
      ),
    );
  }

  _initColors() {
    theme = TDTheme.of(context);
    defaultForegroundColor = widget.type == TDNoticeBarType.info
        ? (theme?.themeColor.primaryColor ?? Colors.blue)
        : (theme?.themeColor.errorColor ?? Colors.red);

    defaultBackgroundColor = widget.type == TDNoticeBarType.info
        ? (theme?.themeColor.primaryColorDisabled ?? Colors.blueAccent)
        : (theme?.themeColor.errorColorDisabled ?? Colors.redAccent);
  }

  Widget _buildText(BuildContext context) {
    TextStyle defaultTextStyle = TextStyle(color: widget.textColor ?? defaultForegroundColor);
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 2),
        child: widget.scrollable ? _scrollableText(defaultTextStyle) : _staticText(defaultTextStyle),
      ),
    );
  }

  Widget _scrollableText(TextStyle defaultTextStyle) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      controller: _controller,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(widget.text, style: defaultTextStyle),
          Container(width: spaceWidth),
          Text(widget.text, style: defaultTextStyle),
        ],
      ),
    );
  }

  Widget _staticText(TextStyle defaultTextStyle) {
    return widget.detailText == null
        ? Text(
            widget.text,
            style: defaultTextStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        : RichText(
            text: TextSpan(
              style: defaultTextStyle,
              children: <TextSpan>[
                TextSpan(text: widget.text + '  '),
                TextSpan(
                  text: widget.detailText,
                  style: TextStyle(
                    color: widget.detailTextColor ?? defaultForegroundColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = (widget.onDetail != null)
                        ? () {
                            widget.onDetail!();
                          }
                        : () {},
                ),
              ],
            ),
          );
  }

  List<Widget> _buildLeftIcon(BuildContext context) {
    return (widget.mode != TDNoticeBarMode.text)
        ? <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  widget.leftIcon ?? (widget.mode == TDNoticeBarMode.closeable ? Icons.volume_up : Icons.info),
                  color: widget.iconColor ?? defaultForegroundColor,
                ),
              ],
            ),
            SizedBox(width: 8),
          ]
        : <Widget>[Container()];
  }

  List<Widget> _buildRightIcon(BuildContext context) {
    return (widget.mode == TDNoticeBarMode.closeable || widget.mode == TDNoticeBarMode.link)
        ? <Widget>[
            SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  child: widget.mode == TDNoticeBarMode.closeable
                      ? Icon(Icons.close, color: widget.iconColor ?? defaultForegroundColor)
                      : Icon(
                          Icons.keyboard_arrow_right,
                          color: widget.iconColor ?? defaultForegroundColor,
                        ),
                  onTap: () => _onTapRightIcon(),
                )
              ],
            ),
          ]
        : <Widget>[Container()];
  }

  _onTapRightIcon() {
    if (widget.mode == TDNoticeBarMode.closeable) {
      setState(() {
        // 当NoticeBar隐藏不见的时候，将滚动播放的定时任务取消
        if (widget.scrollable && _timer != null) {
          _timer!.cancel();
        }
        // 点击close图标，NoticeBar将会不在显示
        showNoticeBar = false;
      });
      if (widget.onClose != null) {
        widget.onClose!();
      }
    }
    if (widget.mode == TDNoticeBarMode.link && widget.onLink != null) {
      widget.onLink!();
    }
  }
}
