import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class BadgePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BadgePageState();
  }
}

class _BadgePageState extends State<BadgePage> {
  int _mediumBadgeValue = 1;
  int _smallBadgeValue = 1;

  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(), title: 'Badge');
  }

  Widget _widget() {
    return ListView(children: [
      PageUtil.buildSubTitle('覆盖于组件的徽标'),
      _buildTile(_badgesOnButtonList(BadgeSize.small)),
      Divider(height: 0),
      _buildTile(_badgesOnButtonList(BadgeSize.medium)),
      Divider(height: 0),
      _buildTile(_badgeOnIconList()),
      PageUtil.buildSubTitle('缎带型徽标'),
      _ribbonExample(),
      PageUtil.buildSubTitle('独立存在的徽标'),
      _tileWithIsolateBadge(Badge(dot: true)),
      Divider(height: 0),
      _tileWithIsolateBadge(Badge(count: 15)),
      Divider(height: 0),
      _tileWithIsolateBadge(Badge(
        content: 'NEW',
        shape: BadgeShape.rounded,
      )),
      Divider(height: 0),
    ]);
  }

  Widget _exampleButton(String text, {double height = 30, double? width}) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
        height: height,
        width: width,
        color: TDColors.blue,
        alignment: Alignment.center,
      ),
    ]);
  }

  Widget _buildTile(List<Widget> list) {
    return PageUtil.buildTile(
      context,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: list,
      ),
      alignment: Alignment.center
    );
  }

  List<Widget> _badgeOnIconList() {
    return [
      Badge(dot: true, child: Icon(TDIcons.refresh, size: TDTheme.iconDefault)),
      Badge(color: TDColors.green, count: 20, child: Icon(TDIcons.mail, size: TDTheme.iconDefault)),
      Badge(
        color: TDColors.orange,
        shape: BadgeShape.rounded,
        count: 30,
        child: Icon(TDIcons.usergroup, size: TDTheme.iconDefault),
      ),
      Badge(
        color: Colors.yellow,
        textColor: Colors.black45,
        shape: BadgeShape.rounded,
        content: 'NEW',
        child: Icon(TDIcons.shop, size: TDTheme.iconDefault),
      ),
    ];
  }

  List<Widget> _badgesOnButtonList(BadgeSize size) {
    return [
      Text(size == BadgeSize.small ? '小型' : '中型'),
      Badge(size: size, child: _exampleButton('红点'), dot: true),
      Badge(
        size: size,
        child: GestureDetector(
          child: _exampleButton('点我+1'),
          onTap: () {
            setState(() {
              if (size == BadgeSize.small) {
                _smallBadgeValue++;
              } else {
                _mediumBadgeValue++;
              }
            });
          },
        ),
        count: size == BadgeSize.small ? _smallBadgeValue : _mediumBadgeValue,
      ),
      Badge(
        child: _exampleButton('文字'),
        content: 'NEW',
        size: size,
      ),
      Badge(
        child: _exampleButton('max:99'),
        count: 100,
        maxCount: 99,
        size: size,
      ),
    ];
  }

  Widget _ribbonExample() {
    return Badge(
      shape: BadgeShape.ribbon,
      content: 'NEW',
      child: ListTile(
        tileColor: Theme.of(context).dialogBackgroundColor,
        leading: Badge(
          content: 'NEW',
          shape: BadgeShape.ribbon,
          size: BadgeSize.small,
          child: _exampleButton('', height: 40, width: 40),
        ),
        title: Text('缎带型徽标'),
      ),
    );
  }

  Widget _tileWithIsolateBadge(Widget badge) {
    return ListTile(tileColor: Theme.of(context).dialogBackgroundColor, leading: Text('单行标题'), trailing: badge);
  }
}
