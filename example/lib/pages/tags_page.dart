import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';
// import '../tags/tag_panel.dart';
import 'dart:convert';

class TagsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TagsPageState();
  }
}

class _TagsPageState extends State<TagsPage> {
  // 默认单选模式
  bool _singleSelection = false;

  // 展示型标签：初始标签标题列表1
  final List<String> _initTagTitles1 = [
    '重要',
    '危险',
    '警告',
    '成功',
    '信息',
  ];

  final List<TagItemStyle> _tagStyles1 = [
    TagItemStyle.primary,
    TagItemStyle.danger,
    TagItemStyle.warning,
    TagItemStyle.success,
    TagItemStyle.info,
  ];

  // 拷贝标签标题列表
  late List _tagTitles1;

  // 展示型标签：初始标签标题列表2
  final List<String> _initTagTitles2 = [
    '深色',
    '浅色',
    '朴素',
  ];

  final List<TagItemTheme> _tagThemes2 = [
    TagItemTheme.dark,
    TagItemTheme.light,
    TagItemTheme.plain,
  ];

  final List<TagItemShape> _tagShapes2 = [
    TagItemShape.square,
    TagItemShape.square,
    TagItemShape.mark,
  ];

  // 拷贝标签标题列表
  late List _tagTitles2;

  // 展示型标签：初始标签标题列表3
  final List<String> _initTagTitles3 = [
    '大号',
    '中号',
    '小号',
  ];

  final List<TagItemSize> _tagSizes3 = [
    TagItemSize.large,
    TagItemSize.medium,
    TagItemSize.small,
  ];

  // 拷贝标签标题列表
  late List _tagTitles3;

  // 展示型标签：初始标签标题列表4
  final List<String> _initTagTitles4 = [
    '圆角',
    '圆角',
    '圆角',
  ];

  final List<TagItemSize> _tagSizes4 = [
    TagItemSize.large,
    TagItemSize.medium,
    TagItemSize.small,
  ];

  // 拷贝标签标题列表
  late List _tagTitles4;

  // 点击型标签：初始标签标题列表5
  final List<String> _initTagTitles5 = [
    '苹果',
    '香蕉',
    '桃子',
    '火龙果',
  ];

  final List<bool> _tagDisabled5 = [
    false,
    false,
    false,
    true,
  ];

  final List<bool> _tagChecked5 = [
    true,
    false,
    false,
    false,
  ];

  // 拷贝标签标题列表
  late List _tagTitles5;

  // 点击型标签：初始标签标题列表7
  final List<String> _initTagTitles7 = [
    '可关闭',
    '可关闭',
    '可关闭',
    '失效标签',
  ];

  final List<TagItemSize> _tagSizes7 = [
    TagItemSize.large,
    TagItemSize.medium,
    TagItemSize.small,
    TagItemSize.small,
  ];

  final List<bool> _tagDisabled7 = [
    false,
    false,
    false,
    true,
  ];

  // 拷贝标签标题列表
  late List _tagTitles7;

  @override
  void initState() {
    super.initState();

    _tagTitles1 = _initTagTitles1.toList();
    _tagTitles2 = _initTagTitles2.toList();
    _tagTitles3 = _initTagTitles3.toList();
    _tagTitles4 = _initTagTitles4.toList();
    _tagTitles5 = _initTagTitles5.toList();
    _tagTitles7 = _initTagTitles7.toList();
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(), title: 'Tags');
  }

  Widget _widget() {
    return ListView(children: [
      PageUtil.buildSubTitle('展示型标签'),
      _tagPanel1,
      _tagPanel2,
      _tagPanel3,
      _tagPanel4,
      Divider(height: 0),
      PageUtil.buildSubTitle('点击型标签'),
      _tagPanel5,
      _tagPanel6,
      _tagPanel7,
    ]);
  }

  final GlobalKey<TDTagPanelState> _tagPanelKey1 = GlobalKey<TDTagPanelState>();
  final GlobalKey<TDTagPanelState> _tagPanelKey2 = GlobalKey<TDTagPanelState>();
  final GlobalKey<TDTagPanelState> _tagPanelKey3 = GlobalKey<TDTagPanelState>();
  final GlobalKey<TDTagPanelState> _tagPanelKey4 = GlobalKey<TDTagPanelState>();

  final GlobalKey<TDTagPanelState> _tagPanelKey5 = GlobalKey<TDTagPanelState>();
  final GlobalKey<TDTagPanelState> _tagPanelKey6 = GlobalKey<TDTagPanelState>();
  final GlobalKey<TDTagPanelState> _tagPanelKey7 = GlobalKey<TDTagPanelState>();

  Widget get _tagPanel1 {
    return TDTagPanel(
      key: _tagPanelKey1,
      heightHorizontalScroll: 60,
      itemCount: _tagTitles1.length,
      itemBuilder: (index) {
        final item = _tagTitles1[index];
        _tagPanelKey1.currentState?.appendATag(item);

        return TDTagItem(
          key: Key(index.toString()),
          index: index,
          title: item,
          style: _tagStyles1[index],
          singleSelection: _singleSelection,
          splashColor: Colors.green,
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
        );
      },
    );
  }

  Widget get _tagPanel2 {
    return TDTagPanel(
      key: _tagPanelKey2,
      heightHorizontalScroll: 60,
      itemCount: _tagTitles2.length,
      itemBuilder: (index) {
        final item = _tagTitles2[index];
        _tagPanelKey2.currentState?.appendATag(item);

        return TDTagItem(
          key: Key(index.toString()),
          index: index,
          title: item,
          theme: _tagThemes2[index],
          style: TagItemStyle.primary,
          shape: _tagShapes2[index],
          singleSelection: _singleSelection,
          splashColor: Colors.green,
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
        );
      },
    );
  }

  Widget get _tagPanel3 {
    return TDTagPanel(
      key: _tagPanelKey3,
      heightHorizontalScroll: 60,
      itemCount: _tagTitles3.length,
      itemBuilder: (index) {
        final item = _tagTitles3[index];
        _tagPanelKey3.currentState?.appendATag(item);

        return TDTagItem(
          key: Key(index.toString()),
          index: index,
          title: item,
          style: TagItemStyle.primary,
          size: _tagSizes3[index],
          singleSelection: _singleSelection,
          splashColor: Colors.green,
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
        );
      },
    );
  }

  Widget get _tagPanel4 {
    return TDTagPanel(
      key: _tagPanelKey4,
      heightHorizontalScroll: 60,
      itemCount: _tagTitles4.length,
      itemBuilder: (index) {
        final item = _tagTitles4[index];
        _tagPanelKey4.currentState?.appendATag(item);

        return TDTagItem(
          key: Key(index.toString()),
          index: index,
          title: item,
          style: TagItemStyle.primary,
          size: _tagSizes4[index],
          shape: TagItemShape.round,
          singleSelection: _singleSelection,
          splashColor: Colors.green,
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
        );
      },
    );
  }

  Widget get _tagPanel5 {
    return TDTagPanel(
      key: _tagPanelKey5,
      heightHorizontalScroll: 60,
      itemCount: _tagTitles5.length,
      itemBuilder: (index) {
        final item = _tagTitles5[index];
        _tagPanelKey5.currentState?.appendATag(item);

        bool _clickable = true;
        bool _disable = _tagDisabled5[index];
        if (_disable) {
          _clickable = false;
        }

        return TDTagItem(
          key: Key(index.toString()),
          index: index,
          title: item,
          style: TagItemStyle.natural,
          size: TagItemSize.large,
          singleSelection: _singleSelection,
          splashColor: Colors.green,
          disabled: _disable,
          checked: _tagChecked5[index],
          clickable: _clickable,
          onClick: (item) => print(item),
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
        );
      },
    );
  }

  Widget get _tagPanel6 {
    return TDTagPanel(
      key: _tagPanelKey6,
      heightHorizontalScroll: 60,
      itemCount: _tagTitles5.length,
      itemBuilder: (index) {
        final item = _tagTitles5[index];
        _tagPanelKey6.currentState?.appendATag(item);

        bool _clickable = true;
        bool _disable = _tagDisabled5[index];
        if (_disable) {
          _clickable = false;
        }

        return TDTagItem(
          key: Key(index.toString()),
          index: index,
          title: item,
          style: TagItemStyle.natural,
          size: TagItemSize.small,
          singleSelection: _singleSelection,
          splashColor: Colors.green,
          disabled: _disable,
          checked: _tagChecked5[index],
          clickable: _clickable,
          onClick: (item) => print(item),
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
        );
      },
    );
  }

  Widget get _tagPanel7 {
    return TDTagPanel(
      key: _tagPanelKey7,
      heightHorizontalScroll: 60,
      itemCount: _tagTitles7.length,
      itemBuilder: (index) {
        final item = _tagTitles7[index];
        _tagPanelKey7.currentState?.appendATag(item);

        TagItemStyle _theme = TagItemStyle.primary;
        bool _removable = true;
        bool _disable = _tagDisabled7[index];
        if (_disable) {
          _theme = TagItemStyle.natural;
          _removable = false;
        }

        return TDTagItem(
          key: Key(index.toString()),
          index: index,
          title: item,
          style: _theme,
          size: _tagSizes7[index],
          singleSelection: _singleSelection,
          splashColor: Colors.green,
          disabled: _disable,
          removable: _removable,
          onRemove: () {
            _tagPanelKey7.currentState?.removeATag(index);
            setState(() {
              _tagTitles7.removeAt(index);
              _tagSizes7.removeAt(index);
              _tagDisabled7.removeAt(index);
            });
          },
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
        );
      },
    );
  }
}
