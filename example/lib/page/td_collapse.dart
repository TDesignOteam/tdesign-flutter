import 'package:flutter/material.dart';
import 'package:tdesign_flutter/td_export.dart';

import '../annotation/demo.dart';
import '../base/example_widget.dart';

class TDCollapsePage extends StatefulWidget {
  const TDCollapsePage({Key? key}) : super(key: key);

  @override
  TDCollapsePageState createState() => TDCollapsePageState();
}

const String randomString =
    "In the heart of the bustling city, a small park offered a sanctuary of tranquility.Children's laughter echoed from the playground, mingling with the soft rustling of leaves in the gentle breeze.Joggers navigated winding paths, their steady breaths in rhythm with the chirping of the early morning birds.Nearby, an elderly man sat on a bench, engrossed in a book, oblivious to the world around him.The park was a microcosm of life, a testament to the city's vibrant spirit and the enduring allure of nature's simple pleasures.";

class TDCollapsePageState extends State<TDCollapsePage> {
  final List<CollapseDataItem> _blockStyleData = generateItems(5);
  final List<CollapseDataItem> _cardStyleData = generateItems(5);
  final List<CollapseDataItem> _blockStyleWithOpText = generateItems(5);

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
        title: tdTitle(),
        exampleCodeGroup: 'collapse',
        desc: '可以折叠/展开的内容区域。',
        children: [
          ExampleModule(title: '组件类型', children: [
            ExampleItem(desc: '基础折叠面板的通栏样式', builder: _buildBlockCollapse),
            ExampleItem(desc: '基础折叠面板的卡片样式', builder: _buildCardCollapse),
            ExampleItem(
                desc: '带操作说明', builder: _buildCollapseWithOperationText),
          ]),
        ]);
  }

  @Demo(group: 'collapse')
  Widget _buildBlockCollapse(BuildContext context) {
    return TDCollapse(
      style: TDCollapseStyle.block,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _blockStyleData[index].isExpanded = !isExpanded;
        });
      },
      children: _blockStyleData.map((CollapseDataItem item) {
        return TDCollapsePanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Text(item.headerValue);
          },
          isExpanded: item.isExpanded,
          body: const Text(randomString),
        );
      }).toList(),
    );
  }

  @Demo(group: 'collapse')
  Widget _buildCardCollapse(BuildContext context) {
    return TDCollapse(
      style: TDCollapseStyle.card,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _cardStyleData[index].isExpanded = !isExpanded;
        });
      },
      children: _cardStyleData.map((CollapseDataItem item) {
        return TDCollapsePanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Text(item.headerValue);
          },
          isExpanded: item.isExpanded,
          body: const Text(randomString),
        );
      }).toList(),
    );
  }

  @Demo(group: 'collapse')
  Widget _buildCollapseWithOperationText(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return TDCollapse(
      style: TDCollapseStyle.block,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _blockStyleWithOpText[index].isExpanded = !isExpanded;
        });
      },
      children: _blockStyleWithOpText.map((CollapseDataItem item) {
        return TDCollapsePanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Text(item.headerValue);
          },
          expandIconTextBuilder: (BuildContext context, bool isExpanded) {
            return isExpanded
                ? localizations.expandedIconTapHint
                : localizations.collapsedIconTapHint;
          },
          isExpanded: item.isExpanded,
          body: const Text(randomString),
        );
      }).toList(),
    );
  }
}

class CollapseDataItem {
  CollapseDataItem(
      {required this.expandedValue,
      required this.headerValue,
      this.isExpanded = false});

  final String expandedValue;
  final String headerValue;
  bool isExpanded;
}

List<CollapseDataItem> generateItems(int numOfItems) {
  return List.generate(numOfItems, (index) {
    return CollapseDataItem(
      headerValue: '标题 $index',
      expandedValue: '$index',
    );
  });
}
