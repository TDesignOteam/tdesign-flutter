import 'package:flutter/material.dart';
import 'package:tdesign_flutter/td_export.dart';
import '../example_base.dart';

class TdNavBarPage extends StatelessWidget {
  const TdNavBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleWidget(
      title: 'TDNavBar',
      children: [
        ExampleItem(
          desc: '基础导航栏',
          builder: (_) {
            return const TDNavBar(title: '标题');
          },
        ),
        ExampleItem(
          desc: '左侧双操作导航栏',
          builder: (_) {
            return TDNavBar(
              title: '标题',
              useDefaultBack: false,
              leftBarItems: [
                TDNavBarItem(icon: Icons.arrow_back_ios),
                TDNavBarItem(icon: Icons.close),
              ],
              rightBarItems: [TDNavBarItem(icon: Icons.more_horiz)],
            );
          },
        ),
        ExampleItem(
          desc: '右侧双操作导航栏',
          builder: (_) {
            return TDNavBar(
              title: '标题',
              rightBarItems: [
                TDNavBarItem(icon: Icons.add_alert_outlined),
                TDNavBarItem(icon: Icons.more_horiz),
              ],
            );
          },
        ),
        ExampleItem(
          desc: '基础小程序导航栏',
          builder: (_) {
            return TDNavBar(
              title: '标题',
              useDefaultBack: false,
              useBorderStyle: true,
              rightBarItems: [
                TDNavBarItem(icon: Icons.more_horiz),
                TDNavBarItem(icon: Icons.dangerous_outlined),
              ],
            );
          },
        ),
        ExampleItem(
          desc: '带返回导航栏',
          builder: (_) {
            return TDNavBar(
              title: '标题',
              useBorderStyle: true,
              rightBarItems: [
                TDNavBarItem(icon: Icons.more_horiz),
                TDNavBarItem(icon: Icons.dangerous_outlined),
              ],
            );
          },
        ),
        ExampleItem(
          desc: '带返回、主页按钮导航栏',
          builder: (_) {
            return TDNavBar(
              title: '标题',
              useDefaultBack: false,
              useBorderStyle: true,
              leftBarItems: [
                TDNavBarItem(icon: Icons.arrow_back_ios),
                TDNavBarItem(icon: Icons.home),
              ],
              rightBarItems: [
                TDNavBarItem(icon: Icons.more_horiz),
                TDNavBarItem(icon: Icons.dangerous_outlined),
              ],
            );
          },
        ),
        ExampleItem(
          desc: '自定义品牌导航栏',
          builder: (_) {
            return TDNavBar(
              title: '品牌名称',
              useDefaultBack: false,
              useBorderStyle: true,
              centerTitle: false,
              titleFontWeight: FontWeight.w600,
              rightBarItems: [
                TDNavBarItem(icon: Icons.more_horiz),
                TDNavBarItem(icon: Icons.dangerous_outlined),
              ],
            );
          },
        ),
        ExampleItem(
          desc: '自定义图片导航栏',
          builder: (_) {
            return TDNavBar(
              titleWidget: Container(
                width: 200,
                color: Colors.red,
                height: 20,
              ),
              useDefaultBack: false,
              useBorderStyle: true,
              centerTitle: false,
              rightBarItems: [
                TDNavBarItem(icon: Icons.more_horiz),
                TDNavBarItem(icon: Icons.dangerous_outlined),
              ],
            );
          },
        ),
        ExampleItem(
          desc: '品牌超长文字导航栏',
          builder: (_) {
            return TDNavBar(
              title: '品牌名称最长最长最长最长最长最长最长最长最长最长最长',
              useDefaultBack: false,
              useBorderStyle: true,
              centerTitle: false,
              titleFontWeight: FontWeight.w600,
              rightBarItems: [
                TDNavBarItem(icon: Icons.more_horiz),
                TDNavBarItem(icon: Icons.dangerous_outlined),
              ],
            );
          },
        ),
        ExampleItem(
          desc: '自定义背景色',
          builder: (_) {
            return TDNavBar(
              title: '标题',
              titleColor: Colors.white,
              backgroundColor: TDTheme.of(context).brandColor8,
              useDefaultBack: false,
            );
          },
        ),
      ],
    );
  }
}
