import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'responsive_config.dart';
import 'responsive_model.dart';

/// 响应式布局根页面
///
/// 支持单列布局和三栏两种布局，三栏从左到右分别是tabBar、home、detail这三个
/// 支持根据屏幕自动选中布局
/// 支持转屏两种布局自动切换
/// 支持动画并透传动画进度
/// 分栏时支持全屏home页面和全屏detail页面
/// 支持手势拖动切换全屏状态
class ResponsivePage extends StatefulWidget {
  /// 空页面，detail没有的时候默认显示这个widget
  final Widget emptyWidget;

  /// 初始化方法
  ResponsivePage({required this.emptyWidget}) : super(key: ResponsiveConfig.key);
  @override
  ResponsivePageState createState() => ResponsivePageState();
}

class _MaskAnimated extends ResponsiveAnimatedModel {
  _MaskAnimated(Duration duration) {
    this.duration = duration;
  }
}

/// 响应式布局的根部state
class ResponsivePageState extends State<ResponsivePage> with TickerProviderStateMixin {
  final _maskAnimated = _MaskAnimated(Duration(milliseconds: 100));
  @override
  Widget build(BuildContext context) {
    Provider.of<StyleModel>(context, listen: false).initWith(MediaQuery.of(context).size.width);
    return ChangeNotifierProvider(create: (_) => _maskAnimated, child: _body());
  }

  Widget _homeWidget() {
    return Consumer<HomeModel>(builder: (context, provider, _) => provider.widget ?? Container());
  }

  Widget _detailWidget() {
    return Consumer<DetailModel>(builder: (context, provider, _) => provider.widget ?? widget.emptyWidget);
  }

  Widget _body() {
    return SafeArea(
      top: false,
      bottom: false,
      child: Consumer4<HomeAnimated, DetailAnimated, DetailModel, StyleModel>(
        builder: (ctx, home, detail, dModel, style, _) {
          final isSplit = style.layout == LayoutStyle.split;
          final isHomeFull = style.fullScreen == FullScreenStyle.home;
          final mediaData = MediaQuery.of(context);
          final width = mediaData.size.width - mediaData.padding.left - mediaData.padding.right;
          final double hw = isSplit ? ResponsiveConfig.splitHomeWidth.ceilToDouble() : width;
          final double dw = isSplit
              ? ResponsiveConfig.splitDetailWidth(context, width.floorToDouble())
              : ((dModel.widget == null || isHomeFull) ? 0 : width);
          final bool isShowHome = style.layout == LayoutStyle.single && (dModel.widget == null || isHomeFull);
          final double hValue = isSplit ? home.value : 0;
          final double dValue = isSplit ? detail.value : 0;
          ResponsiveConfig.log('Responsive layout $hw $dw -- $width / ${mediaData.size.width}  h:$hValue d:$dValue');
          return Stack(children: <Widget>[
            Offstage(
              offstage: (isShowHome || isSplit) ? false : true,
              child: Row(
                children: <Widget>[
                  Container(
                    transform:
                        Matrix4.translationValues(-(width - dw) * dValue * ResponsiveConfig.splitHomeSpeed, 0, 0),
                    width: hw + dw * hValue,
                    child: _homeWidget(),
                  ),
                  Container(
                    transform: Matrix4.translationValues(-(width - dw) * dValue, 0, 0),
                    child: (dValue != 1 && isSplit)
                        ? VerticalDivider(width: 0, color: ResponsiveConfig.separatedColor)
                        : Container(),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ClipRect(
                  child: Container(
                    transform: Matrix4.translationValues(dw * hValue, 0, 0),
                    color: Colors.white,
                    width: dw + (width - dw) * dValue,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _detailWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]);
        },
      ),
    );
  }
}
