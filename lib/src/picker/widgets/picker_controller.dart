import 'package:flutter/material.dart';
import 'package:tdesign/src/picker.dart';
import 'package:tdesign/src/picker/widgets/picker_item.dart';

import '../../../tdesign.dart';

///确认按钮回调
typedef TDPickerSelectedCallback = void Function(TDPickerController pickerController, List<int>? selects);

class TDPickerController {
  ///标题 取消按钮 确认按钮
  final Widget? title;
  final Widget? cancel;
  final Widget? confirm;
  final String? titleText;
  final String? cancelText;
  final String? confirmText;
  final Widget? header; //自定义顶部栏
  final Widget? footer; //自定义底部栏

  ///UI控制
  final double height;
  final double diameterRatio;
  final double itemExtent;
  final double offAxisFraction;
  static const double kTDPickerHeight = 228;
  static const double kTDPickerDiameterRatio = 3; //UI要求
  static const double kTDPickerItemExtent = 44;
  static const double kTDPickerOffAxisFraction = 0.0; //(column - columnCount / 2) * 0.5

  ///是否循环滚动
  final bool looping;

  /// 前一级修改, 后面是否变更到第一个
  final changeToFirst;

  /// 是否是级联数据 (切换选中项后 动态变化)
  final isLinkageData;

  ///数据源委托
  final PickerChildrenDelegate childDelegate;

  ///Picker点击确认的事件
  final TDPickerSelectedCallback? onConfirm;

  ///初始化(自定义固化数据)
  TDPickerController({
    int? columnCount, //如果明确已知,建议传下
    required List<TDPickerItem>? children,
    List<int>? initSelects,
    this.title,
    this.cancel,
    this.confirm,
    this.titleText,
    this.cancelText,
    this.confirmText,
    this.header,
    this.footer,
    this.onConfirm,
    this.looping = false,
    this.changeToFirst = false,
    this.isLinkageData = true,
    this.height = kTDPickerHeight,
    this.diameterRatio = kTDPickerDiameterRatio,
    this.itemExtent = kTDPickerItemExtent,
    this.offAxisFraction = kTDPickerOffAxisFraction,
  }) : childDelegate = PickerChildrenDelegate.children(children: children) {
    childDelegate.doInit(initSelects: initSelects);
  }

  ///初始化(固化数据)
  TDPickerController.pickerData({
    required List pickerData, //可以是[[1,1],[2,2,2,2]], [{},{}] 具体看demo数据
    List<int>? initSelects,
    this.title,
    this.cancel,
    this.confirm,
    this.titleText,
    this.cancelText,
    this.confirmText,
    this.header,
    this.footer,
    this.onConfirm,
    this.looping = false,
    this.changeToFirst = false,
    this.height = kTDPickerHeight,
    this.diameterRatio = kTDPickerDiameterRatio,
    this.itemExtent = kTDPickerItemExtent,
    this.offAxisFraction = kTDPickerOffAxisFraction,
  })  : childDelegate = PickerChildrenDelegate.pickerData(pickerData: pickerData),
        isLinkageData = !TDPickerRootItem.isArrayData(pickerData) {
    childDelegate.doInit(initSelects: initSelects);
  }

  ///初始化(动态数据)
  TDPickerController.builder({
    required int columnCount,
    required TDPickerItemBuilder itemBuilder,
    required TDPickerItemCountBuilder itemCountBuilder,
    List<int>? initSelects,
    this.title,
    this.cancel,
    this.confirm,
    this.titleText,
    this.cancelText,
    this.confirmText,
    this.header,
    this.footer,
    this.onConfirm,
    this.looping = false,
    this.changeToFirst = false,
    this.isLinkageData = true,
    this.height = kTDPickerHeight,
    this.diameterRatio = kTDPickerDiameterRatio,
    this.itemExtent = kTDPickerItemExtent,
    this.offAxisFraction = kTDPickerOffAxisFraction,
  }) : childDelegate = PickerChildrenDelegate.builder(
            columnCount: columnCount, itemBuilder: itemBuilder, itemCountBuilder: itemCountBuilder) {
    childDelegate.doInit(initSelects: initSelects);
  }

  ///获取当前选中序号的数组 [1,2,1]
  List<int> get selects {
    var results = <int>[];
    for (int i = 0; i < childDelegate.columnCount; i++) {
      results.add(_getSelectedRow(i, preSelects: results));
    }
    return results;
  }

  ///获取选中的序号 column:哪一列
  int _getSelectedRow(int column, {List<int>? preSelects}) {
    var row;

    if (column < childDelegate.columnControllerList.length) {
      var ctrl = childDelegate.columnControllerList[column];
      if (ctrl.hasClients == true) {
        row = ctrl.selectedItem;
        if (row < 0 && preSelects != null) {
          //loop
          row = row % childDelegate.rowCount(preSelects);
        }
      } else {
        row = 0;
      }
    }

    return row;
  }

  List<TDPickerItem> get selectPickerItems {
    var results = <TDPickerItem>[];
    for (int i = 0; i < childDelegate.columnCount; i++) {
      results.add(_getSelectPickerItem(i, selects: selects));
    }
    return results;
  }

  TDPickerItem _getSelectPickerItem(int column, {List<int>? selects}) {
    selects ??= this.selects;
    var tmpSelects = selects.sublist(0, column + 1);
    return childDelegate.pickerItemAtSelects(tmpSelects);
  }

  String get selectsDescription {
    var desc = '';
    var selects = selectPickerItems;
    for (var item in selects) {
      desc += item.item.toString();
    }
    return desc;
  }
}
