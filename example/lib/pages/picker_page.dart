import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign/tdesign.dart';
import 'package:tdesign/theme/td_text_style.dart';

import '../page_util.dart';

class PickerPage extends StatefulWidget {
  PickerPage({Key? key}) : super(key: key);

  @override
  _PickerPageState createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> {
  String? _city;
  String? _yearAndSeason;
  String? _date;

  String? _linkData1;
  String? _linkData2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      child: _buildContent(context),
      title: 'Picker选择器',
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
        children: [
          _buildSection(title: '基础选择器'),
          _buildRow(
              title: '城市',
              text: _city,
              onClick: () {
                TDPicker.show(
                    context,
                    TDPickerController.pickerData(
                        initSelects: [2],
                        pickerData: kCityData,
                        onConfirm: (controller, _) {
                          setState(() {
                            _city = controller.selectsDescription;
                          });
                        }));
              }),
          _buildRow(
              title: '年份和季节',
              text: _yearAndSeason,
              onClick: () {
                TDPicker.show(
                    context,
                    TDPickerController.pickerData(
                        initSelects: [2],
                        pickerData: kYearAndSeasonData,
                        onConfirm: (controller, _) {
                          setState(() {
                            _yearAndSeason = controller.selectsDescription;
                          });
                        }));
              }),
          _buildRow(
              title: '日期',
              text: _date,
              desc: '仅做展示，年月日关联关系由自己实现',
              onClick: () {
                TDPicker.show(
                    context,
                    TDPickerController.pickerData(
                        pickerData: kDateData,
                        onConfirm: (controller, _) {
                          setState(() {
                            _date = controller.selectsDescription;
                          });
                        }));
              }),
          _buildSection(title: '带标题选择器'),
          _buildRow(
              title: '城市',
              text: _city,
              onClick: () {
                TDPicker.show(
                    context,
                    TDPickerController.pickerData(
                        titleText: '选择城市',
                        pickerData: kCityData,
                        onConfirm: (controller, _) {
                          setState(() {
                            _city = controller.selectsDescription;
                          });
                        }));
              }),
          _buildRow(
              title: '年份和季节',
              text: _yearAndSeason,
              onClick: () {
                TDPicker.show(
                    context,
                    TDPickerController.pickerData(
                        titleText: '选择年份和季节',
                        pickerData: kYearAndSeasonData,
                        onConfirm: (controller, _) {
                          setState(() {
                            _yearAndSeason = controller.selectsDescription;
                          });
                        }));
              }),
          _buildRow(
              title: '日期',
              text: _date,
              desc: '仅做展示，年月日关联关系由自己实现',
              onClick: () {
                TDPicker.show(
                    context,
                    TDPickerController.pickerData(
                        titleText: '选择日期',
                        pickerData: kDateData,
                        onConfirm: (controller, _) {
                          setState(() {
                            _date = controller.selectsDescription;
                          });
                        }));
              }),
          _buildSection(title: '联动选择'),
          _buildRow(
              title: '动态数据',
              text: _linkData1,
              onClick: () {
                TDPicker.show(
                    context,
                    TDPickerController.builder(
                        titleText: '第二列数据联动',
                        columnCount: 3,
                        itemCountBuilder: (column, _) => 100,
                        changeToFirst: true,
                        isLinkageData: true,
                        itemBuilder: (column, row, selects) {
                          var sep = '_';
                          if (selects!.first % 2 == 0 && column == 1) {
                            sep = '@';
                          }
                          return 'a' + column.toString() + sep + row.toString();
                        },
                        onConfirm: (controller, _) {
                          setState(() {
                            _linkData1 = controller.selectsDescription;
                          });
                        }));
              }),
          _buildRow(
              title: '固定数据',
              text: _linkData2,
              onClick: () {
                TDPicker.show(
                    context,
                    TDPickerController.pickerData(
                        titleText: '联动数据',
                        pickerData: kPickerDictionaryData,
                        onConfirm: (controller, _) {
                          setState(() {
                            _linkData2 = controller.selectsDescription;
                          });
                        }));
              }),
          _buildSection(title: '设置项'),
          _buildUISetting(
              title: '居中弹框', position: TDPickerPosition.center, pickerController: TDPickerController(children: [])),
          _buildUISetting(title: '循环滚动', pickerController: TDPickerController(looping: true, children: [])),
          _buildUISetting(
              title: '自定义标题(文本)',
              pickerController: TDPickerController(
                  titleText: '我是自定义标题我是自定义标题我是自定义标题我是自定义标题我是自定义标题我是自定义标题我是自定义标题我是自定义标题我是自定义标题', children: [])),
          _buildUISetting(
              title: '自定义标题(Widget)', pickerController: TDPickerController(title: Text('Center Widget'), children: [])),
          _buildUISetting(
              title: '自定义按钮(文本)',
              pickerController: TDPickerController(cancelText: '取消按钮', confirmText: '确认按钮', children: [])),
          _buildUISetting(
              title: '自定义按钮(Widget)',
              pickerController: TDPickerController(
                  cancel: Text(
                    '取消Widget',
                    style: TextStyle(color: Colors.red),
                  ),
                  confirm: Text('确认Widget'),
                  children: [])),
          _buildUISetting(
              title: '自定义Header',
              pickerController: TDPickerController(
                  header: Container(
                    color: Colors.red,
                    height: 50,
                    child: Center(child: Text('标题')),
                  ),
                  children: [])),
          _buildUISetting(
            title: '自定义Header Footer',
            pickerController: TDPickerController(
                header: Container(
                  color: Colors.red,
                  height: 50,
                  child: Center(child: Text('Header')),
                ),
                footer: Container(
                  color: Colors.blue,
                  height: 50,
                  child: Center(child: Text('Footer')),
                ),
                children: []),
            position: TDPickerPosition.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUISetting({
    required String title,
    required TDPickerController pickerController,
    TDPickerPosition position = TDPickerPosition.bottom,
  }) {
    return _buildRow(
        title: title,
        text: _yearAndSeason,
        onClick: () {
          TDPicker.show(
              context,
              TDPickerController.pickerData(
                  looping: pickerController.looping,
                  title: pickerController.title,
                  cancel: pickerController.cancel,
                  confirm: pickerController.confirm,
                  titleText: pickerController.titleText ?? title,
                  cancelText: pickerController.cancelText,
                  confirmText: pickerController.confirmText,
                  header: pickerController.header,
                  footer: pickerController.footer,
                  pickerData: kYearAndSeasonData,
                  onConfirm: (controller, _) {
                    setState(() {
                      _yearAndSeason = controller.selectsDescription;
                      TDToast.toast('当前选择的: ' + _yearAndSeason!);
                    });
                  }),
              position: position);
        });
  }

  Widget _buildSection({required String title}) {
    return PageUtil.buildSubTitle(title);
  }

  Widget _buildRow({required String title, String? text, String? desc, required VoidCallback onClick}) {
    var textStyle = tdTextStyle.r16Text(context, textLevel: 1);
    var placeStyle = tdTextStyle.r16Text(context, textLevel: 3);
    return GestureDetector(
      onTap: onClick,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(children: [
              SizedBox(
                  width: 100,
                  child: Text(
                    title,
                    style: textStyle,
                  )),
              text?.isNotEmpty == true
                  ? Text(
                      text ?? '',
                      style: textStyle,
                    )
                  : Text(
                      '选择' + title,
                      style: placeStyle,
                    )
            ]),
            Visibility(
                visible: desc?.isNotEmpty == true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.only(top: 5)),
                    Divider(
                      height: 1,
                    ),
                    Padding(padding: const EdgeInsets.only(top: 5)),
                    Text(
                      desc ?? '',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

const kCityData = [
  ['广州市', '韶关市', '深圳市', '珠海市', '汕头市']
];

const kYearAndSeasonData = [
  ['2021年', '2020年', '2019年', '2018年', '2017年', '2016年', '2015年'],
  ['春', '夏', '秋', '冬']
];
const kDateData = [
  ['2021年', '2020年', '2019年', '2018年', '2017年', '2016年', '2015年'],
  [
    '1月',
    '2月',
    '3月',
    '4月',
    '5月',
    '6月',
    '7月',
    '8月',
    '9月',
    '10月',
    '11月',
    '12月',
  ],
  [
    '1日',
    '2日',
    '3日',
    '4日',
    '5日',
    '6日',
    '7日',
    '8日',
    '9日',
    '10日',
    '11日',
    '12日',
    '13日',
    '14日',
    '15日',
    '16日',
    '17日',
    '18日',
    '19日',
    '20日',
    '21日',
    '22日',
    '23日',
    '24日',
    '25日',
    '26日',
    '27日',
    '28日',
    '29日',
    '30日',
    '31日',
  ]
];

final kPickerDictionaryData = JsonDecoder().convert('''
[
    {
        "a": [
            {
                "a1": [
                    1,
                    2,
                    3,
                    4
                ]
            },
            {
                "a2": [
                    5,
                    6,
                    7,
                    8
                ]
            },
            {
                "a3": [
                    9,
                    10,
                    11,
                    12
                ]
            }
        ]
    },
    {
        "b": [
            {
                "b1": [
                    11,
                    22,
                    33,
                    44
                ]
            },
            {
                "b2": [
                    55,
                    66,
                    77,
                    88
                ]
            },
            {
                "b3": [
                    99,
                    1010,
                    1111,
                    1212
                ]
            }
        ]
    },
    {
        "c": [
            {
                "c1": [
                    "a",
                    "b",
                    "c"
                ]
            },
            {
                "c2": [
                    "aa",
                    "bb",
                    "cc"
                ]
            },
            {
                "c3": [
                    "aaa",
                    "bbb",
                    "ccc"
                ]
            }
        ]
    }
]
    ''');
