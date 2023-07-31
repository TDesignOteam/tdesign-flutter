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
    '此处可自定义内容此处可自定义内容此处可自定义内容此处可自定义内容此处可自定义内容此处可自定义内容此处可自定义内容此处可自定义内容';

class TDCollapsePageState extends State<TDCollapsePage> {
  final List<CollapseDataItem> _basicData = generateItems(1);
  final List<CollapseDataItem> _blockStyleWithOpText = generateItems(1);
  final List<CollapseDataItem> _accordionData = generateItems(3);
  final List<CollapseDataItem> _cardStyleData = generateItems(3);

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
        title: tdTitle(),
        exampleCodeGroup: 'collapse',
        desc: '可以折叠/展开的内容区域。',
        children: [
          ExampleModule(title: '组件类型', children: [
            ExampleItem(
              desc: '基础折叠面板',
              builder: _buildBasicCollapse,
            ),
            ExampleItem(
              desc: '带操作说明',
              builder: _buildCollapseWithOperationText,
            ),
            ExampleItem(
              desc: '手风琴式',
              builder: _buildAccordionCollapse,
            ),
          ]),
          ExampleModule(title: '组件样式', children: [
            ExampleItem(
              desc: '卡片折叠面板',
              builder: _buildCardCollapse,
            ),
          ]),
        ]);
  }

  @Demo(group: 'collapse')
  Widget _buildBasicCollapse(BuildContext context) {
    return TDCollapse(
      style: TDCollapseStyle.block,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _basicData[index].isExpanded = !isExpanded;
        });
      },
      children: _basicData.map((CollapseDataItem item) {
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
            return isExpanded ? '收起' : '展开';
          },
          isExpanded: item.isExpanded,
          body: const Text(randomString),
        );
      }).toList(),
    );
  }

  @Demo(group: 'collapse')
  Widget _buildAccordionCollapse(BuildContext context) {
    return TDCollapse.accordion(
      style: TDCollapseStyle.block,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _accordionData[index].isExpanded = !isExpanded;
        });
      },
      initialOpenPanelValue: '0',
      children: _accordionData.map((CollapseDataItem item) {
        return TDCollapsePanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Text(item.headerValue);
          },
          isExpanded: item.isExpanded,
          body: const Text(randomString),
          value: item.expandedValue,
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
      headerValue: '折叠面板标题',
      expandedValue: '$index',
      isExpanded: index == 0,
    );
  });
}
