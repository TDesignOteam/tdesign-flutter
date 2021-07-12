import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'responsive_config.dart';
import 'responsive_page.dart';

/// 用于切换列表也或者详情页，作为基类，不建议直接使用
class ResponsiveWidgetModel with ChangeNotifier {
  Widget? _widget;
  ResponsiveWidgetModel(this._widget);
  Widget? get widget => _widget;

  /// 传入一个新widget替换掉当前显示的，可以传入null
  switchPage(Widget? page) {
    bool isSamePage = (page == _widget && page != null);
    _widget = page;
    if (!isSamePage) {
      notifyListeners();
    }
    debugPrint('switch page: isSamePage - $isSamePage / switch to - $page');
  }
}

/// 列表页的widget控制
class HomeModel extends ResponsiveWidgetModel {
  HomeModel(Widget widget) : super(widget);
}

/// 详情页的widget控制
class DetailModel extends ResponsiveWidgetModel {
  DetailModel(Widget? widget) : super(widget);

  /// 显示详情页，会自动判断显示方式
  /// [ticker]动画参数，目前未实现
  static showPage(BuildContext context, Widget page, TickerProvider? ticker) {
    // home全屏的时候直接push
    final style = Provider.of<StyleModel>(context, listen: false);
    if (style.fullScreen == FullScreenStyle.home) {
      // 列表页全屏的时候再打开一个详情页，push前先移除分栏中的详情页
      if (ResponsiveConfig.key.currentContext != null) {
        Provider.of<DetailModel>(ResponsiveConfig.key.currentContext!, listen: false).switchPage(null);
      }
      Navigator.of(context).push(ResponsiveConfig.pageBuilder(page));
    } else if (context.findAncestorWidgetOfExactType<ResponsivePage>() != null && !Navigator.of(context).canPop()) {
      Provider.of<DetailModel>(context, listen: false).switchPage(page);
    } else {
      Navigator.of(context).push(ResponsiveConfig.pageBuilder(page));
    }
  }

  /// 关闭详情页，会自动处理当前状态
  static pop(BuildContext context, TickerProvider? ticker) {
    if (context.findAncestorWidgetOfExactType<ResponsivePage>() != null) {
      final style = Provider.of<StyleModel>(context, listen: false);
      if (style.layout == LayoutStyle.single) {
        if (style.fullScreen == FullScreenStyle.detail) {
          style.toggleDetail(context, null);
        }
        Provider.of<DetailModel>(context, listen: false).switchPage(null);
      } else {
        if (style.fullScreen == FullScreenStyle.detail) {
          style.toggleDetail(context, ticker);
        } else {
          Provider.of<DetailModel>(context, listen: false).switchPage(null);
        }
      }
    } else if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      assert(false, '退出异常');
    }
  }
}

/// 布局样式，目前就单列和分栏两种
enum LayoutStyle {
  /// 单列布局
  single,

  /// 分栏布局
  split,
}

/// 全屏样式
enum FullScreenStyle {
  none,

  /// 列表页全屏
  home,

  /// 详情页全屏
  detail,
}

/// 布局相关Provider，挂根节点
class StyleModel with ChangeNotifier {
  bool _isShowSingleTabBar = true;
  FullScreenStyle _fullScreen = FullScreenStyle.none;
  LayoutStyle _layout = ResponsiveConfig.firstTestLayout;

  /// 当前布局样式
  LayoutStyle get layout => _layout;

  /// 当前全屏状态
  FullScreenStyle get fullScreen => _fullScreen;

  /// 单列模式的时候是否显示tabBar
  bool get isSingleShowTabBar =>
      _isShowSingleTabBar &&
      layout == LayoutStyle.single &&
      (Provider.of<DetailModel>(ResponsiveConfig.key.currentContext!, listen: false).widget == null ||
          fullScreen == FullScreenStyle.home);

  /// 当前是否只显示的详情页。包括详情页全屏或单栏详情页
  static bool get isCurrentShowDetail =>
      (Provider.of<DetailModel>(ResponsiveConfig.key.currentContext!, listen: false).widget != null &&
          Provider.of<StyleModel>(ResponsiveConfig.key.currentContext!, listen: false).fullScreen !=
              FullScreenStyle.home);

  /// app宽度改变的时候需要调用该方法更新信息
  initWith(double width) {
    final old = _layout;
    _layout = width >= ResponsiveConfig.splitMinWidth ? LayoutStyle.split : LayoutStyle.single;
    if (old != _layout) {
      Future.delayed(Duration(milliseconds: 0)).then((e) {
        notifyListeners();
      });
      ResponsiveConfig.log('StyleModel change width: $width style: $old -> $_layout $_fullScreen');
    } else {
      debugPrint('StyleModel initWith width: $width style: $_layout $_fullScreen');
    }
  }

  /// 只会修改单栏模式的tabBar显示状态
  changeSingleTabBar(bool show) {
    bool isChanged = _isShowSingleTabBar != show;
    _isShowSingleTabBar = show;
    if (isChanged) {
      notifyListeners();
    }
  }

  /// 切换详情页全屏状态，[ticker]如果传null的就没有动画
  toggleDetail(BuildContext? context, TickerProvider? ticker) {
    if (context != null) {
      final isFullScreen = _fullScreen == FullScreenStyle.detail;
      // 先还原另外一个状态的动画值
      Provider.of<HomeAnimated>(ResponsiveConfig.key.currentContext!, listen: false).end(null);

      if (isFullScreen) {
        Provider.of<DetailAnimated>(ResponsiveConfig.key.currentContext!, listen: false).end(ticker);
      } else {
        Provider.of<DetailAnimated>(ResponsiveConfig.key.currentContext!, listen: false).start(ticker);
      }
    }

    notifyListeners();
  }

  /// 切换列表页全屏状态，[ticker]如果传null的就没有动画
  toggleHome(BuildContext? context, TickerProvider ticker) {
    if (context != null) {
      final isFullScreen = _fullScreen == FullScreenStyle.home;
      // 先还原另外一个状态的动画值
      Provider.of<DetailAnimated>(ResponsiveConfig.key.currentContext!, listen: false).end(null);

      if (isFullScreen) {
        Provider.of<HomeAnimated>(ResponsiveConfig.key.currentContext!, listen: false).end(ticker);
      } else {
        Provider.of<HomeAnimated>(ResponsiveConfig.key.currentContext!, listen: false).start(ticker);
      }
    }

    notifyListeners();
  }
}

/// 动画同步模型，基类不建议直接使用
class ResponsiveAnimatedModel with ChangeNotifier {
  double? _currentDefault;
  double get value => (_currentDefault ?? _animation?.value) ?? 0;

  /// 可以自己设置，空的时候会使用[ResponsiveConfig.animationDuration]
  Duration? duration;
  AnimationController? _controller;
  Animation<double>? _animation;

  /// 更新动画进度
  update(TickerProvider ticker, double value) {
    if (value < 1 && value >= 0) {
      // 注意: 这里不能等于1，因为传1进去会导致动画完成 触发didChangeStatus
      _makeController(ticker);
      double oldValue = this.value;
      _controller?.value = value;
      if (oldValue != this.value) {
        notifyListeners();
      }
    }
  }

  /// 动画状态改变
  didChangeStatus(AnimationStatus status) {
    ResponsiveConfig.log('${this.runtimeType} didChangeStatus ${status.toString()}');
  }

  _makeController(TickerProvider ticker) {
    _currentDefault = null;
    if (_controller == null) {
      _controller = AnimationController(duration: duration ?? ResponsiveConfig.animationDuration, vsync: ticker);
      final CurvedAnimation curve = CurvedAnimation(parent: _controller!, curve: Curves.linear);
      _animation = Tween<double>(begin: 0, end: 1).animate(curve)
        ..addListener(() {
          notifyListeners();
        })
        ..addStatusListener((status) {
          didChangeStatus(status);
        });
    }
  }

  /// 开始动画，[value] -> 1，[ticker]传null表示没有动画
  start(TickerProvider? ticker) {
    if (ResponsiveConfig.isOpenAnimation == false || ticker == null) {
      _currentDefault = 1;
      _controller?.value = 1;
      ResponsiveConfig.log('${this.runtimeType} no animation to 1');
      didChangeStatus(AnimationStatus.completed);
      return;
    }

    _makeController(ticker);
    _controller?.forward();
  }

  /// 结束动画，[value] -> 0，[ticker]传null表示没有动画
  end(TickerProvider? ticker) {
    if (ResponsiveConfig.isOpenAnimation == false || ticker == null) {
      _currentDefault = 0;
      _controller?.value = 0;
      ResponsiveConfig.log('${this.runtimeType} no animation to 0');
      didChangeStatus(AnimationStatus.dismissed);
      return;
    }

    _makeController(ticker);
    _controller?.reverse();
  }
}

/// home页面全屏动画，动画完成会修改全屏状态[StyleModel.fullScreen]
class HomeAnimated extends ResponsiveAnimatedModel {
  final StyleModel _model;
  HomeAnimated(this._model);
  @override
  didChangeStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
      _model._fullScreen = status == AnimationStatus.completed ? FullScreenStyle.home : FullScreenStyle.none;
      _model.notifyListeners();
      ResponsiveConfig.log('${this.runtimeType} StyleModel didChange to style: ${_model.layout} ${_model.fullScreen}');
    }
    return super.didChangeStatus(status);
  }
}

/// 详情页面全屏动画，动画完成会修改全屏状态[StyleModel.fullScreen]
class DetailAnimated extends ResponsiveAnimatedModel {
  final StyleModel _model;
  DetailAnimated(this._model);
  @override
  didChangeStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
      _model._fullScreen = status == AnimationStatus.completed ? FullScreenStyle.detail : FullScreenStyle.none;
      _model.notifyListeners();
      ResponsiveConfig.log('${this.runtimeType} StyleModel didChange to style: ${_model.layout} ${_model.fullScreen}');
    }
    return super.didChangeStatus(status);
  }
}
