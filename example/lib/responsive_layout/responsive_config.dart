import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'responsive_model.dart';
import 'responsive_page.dart';

/// 日志分发函数
typedef ResponsiveLog = Function(String text);

/// 全屏状态切换icon
typedef FullScreenIconBuilder = Widget Function(StyleModel style);

/// 详情页可能push的路由，可以外界覆盖用自己的路由
typedef ResponsivePageBuilder = PageRoute Function(Widget page);

/// 分栏模式详情页resize的时候的遮罩,[hValue]表示home页面动画进度，[dValue]表示detail页面动画进度，返回null表示没有
typedef ResponsiveSplitDetailResizeMask = Widget Function(double opacity);

/// 响应式框架的一些全局配置
class ResponsiveConfig {
  /// 整个响应式框架根部key
  static final key = GlobalKey<ResponsivePageState>(debugLabel: 'responsive_root_key');

  /// detail页面和home页面的宽度比
  static double ratio = 2;

  /// 大于等于这个宽度就使用分栏布局
  static double splitMinWidth = 700;

  /// 分栏模式切换详情页全屏的时候列表页的运行速度，1表示完全同步
  static double splitHomeSpeed = 0.5;

  /// 分栏模式遮罩颜色，详情页全屏的时候盖住左边部分，会根据动画进度更新透明度[0-0.5]。设置为null表示没有
  static Color splitMaskColor = Colors.black;

  /// 获取分屏模式下详情面的宽度 [width]是传入的整个app宽度
  static double splitHomeWidth = 200;

  /// 分割线颜色
  static Color separatedColor = Color(0x29000000);

  /// 获取分屏模式下主页面的宽度 [width]是传入的整个app宽度
  static double splitDetailWidth(BuildContext context, double width) {
    return width - splitHomeWidth;
  }

  /// 全屏按钮的icon
  static FullScreenIconBuilder fullScreenIconBuilder = (style) {
    return Icon(style.fullScreen == FullScreenStyle.home ? Icons.view_column : Icons.view_list, size: 20);
  };

  /// 默认开启全屏切换动画
  static bool isOpenAnimation = true;
  static var animationDuration = Duration(milliseconds: 300);

  /// SplitRoute的动画时间
  static var transitionDuration = Duration(milliseconds: 300);

  /// 初始化的时候的类型
  static LayoutStyle firstTestLayout = LayoutStyle.single;

  /// 各个页面根据自身宽度获取左右两边的缩进值
  static double padding(double width) {
    if (width <= 320) {
      return 16;
    } else if (width <= 640) {
      return 20;
    } else {
      return 40;
    }
  }

  /// 详情页可能push的路由，可以外界覆盖用自己的路由
  static ResponsivePageBuilder pageBuilder = (page) => CupertinoPageRoute(builder: (_) => page);

  /// log输出
  static ResponsiveLog log = (text) => print(text);
}
