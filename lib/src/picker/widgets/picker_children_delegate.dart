import 'package:flutter/cupertino.dart';
import 'package:tdesign/src/picker/widgets/picker_item.dart';
import 'package:tdesign/theme/td_text_style.dart';

///picker数据项回调(String or Widget)
///column = selects.length - 1
///row = selects.last
typedef TDPickerItemBuilder = dynamic Function(
    int column, int row, List<int>? selects);

///picker区域回调
///column = selects.length
typedef TDPickerItemCountBuilder = int Function(int column, List<int>? selects);

class PickerChildrenDelegate {
  ///picker列数
  late final int columnCount; //

  ///Picker显示数据回调
  final TDPickerItemBuilder? itemBuilder;

  ///每列Picker显示行数回调
  final TDPickerItemCountBuilder? itemCountBuilder;

  ///子项
  late TDPickerRootItem? data;

  ///列控制数据
  final List<FixedExtentScrollController> columnControllerList =
      <FixedExtentScrollController>[];

  PickerChildrenDelegate.builder(
      {required this.columnCount,
      required this.itemBuilder,
      required this.itemCountBuilder})
      : data = null;

  PickerChildrenDelegate.children(
      {required List<TDPickerItem>? children, int? estimateColumnCount})
      : data = TDPickerRootItem(children: children),
        itemBuilder = null,
        itemCountBuilder = null {
    //获取最大级联
    if (estimateColumnCount == null) {
      columnCount = data!.maxLevel;
    } else {
      columnCount = estimateColumnCount;
    }
  }

  PickerChildrenDelegate.pickerData({required List pickerData})
      : data = TDPickerRootItem.parsePickerData(pickerData),
        itemBuilder = null,
        itemCountBuilder = null {
    //获取最大级联
    columnCount = data!.maxLevel;
  }

  void doInit({List<int>? initSelects}) {
    for (var index = 0; index < columnCount; ++index) {
      var initialItem;
      if (initSelects != null && index < initSelects.length) {
        initialItem = initSelects[index];
      }
      var controller =
          FixedExtentScrollController(initialItem: initialItem ?? 0);
      columnControllerList.add(controller);
    }
  }

  int rowCount(List<int>? selects) {
    var count = 0;
    selects ??= <int>[];
    if (data != null) {
      count = _itemCountAtSelects(selects);
    } else if (itemCountBuilder != null) {
      count = itemCountBuilder!(selects.length, selects);
    }
    return count;
  }

  TDPickerItem pickerItemAtSelects(List<int>? selects) {
    var pickerItem;
    selects ??= [];
    if (data != null) {
      pickerItem = _itemAtSelects(selects);
    } else if (itemBuilder != null) {
      var item = itemBuilder!(selects.length - 1, selects.last, selects);
      pickerItem = TDPickerItem(item: item);
    }
    return pickerItem ?? TDPickerItem();
  }

  Widget itemWidget(BuildContext context, List<int>? selects) {
    var item;
    selects ??= [];
    if (data != null) {
      item = _itemAtSelects(selects)?.item;
    } else if (itemBuilder != null) {
      item = itemBuilder!(selects.length - 1, selects.last, selects);
    }

    if (item == null) {
      return Container();
    }

    if (item is Widget) {
      return item;
    }

    if (!(item is String)) {
      item = ''; //默认当做字符串
    }

    return Container(
      alignment: Alignment.center,
      child: Text(
        item,
        style: tdTextStyle.r16Text(context, textLevel: 1),
      ),
    );
  }

  int _itemCountAtSelects(List<int>? selects) {
    var itemCount;
    if (data == null) {
      return 0;
    }

    if (data!.isArray) {
      itemCount = data!.children![selects!.length].children?.length;
    } else {
      if (selects?.isNotEmpty == true) {
        itemCount = _itemAtSelects(selects)?.children?.length;
      } else {
        itemCount = data?.children?.length;
      }
    }

    return itemCount ?? 0;
  }

  TDPickerItem? _itemAtSelects(List<int>? selects) {
    if (data == null || selects?.isNotEmpty != true) {
      return null;
    }

    if (data!.isArray) {
      var colData = data!.children![selects!.length - 1];
      return colData.children![selects.last];
    }

    var item;
    for (var index in selects!) {
      var children;
      if (item == null) {
        children = data!.children;
      } else {
        children = item.children;
      }

      if (children == null || index >= children!.length) {
        item = null;
        break;
      } else {
        item = children![index];
      }
    }
    return item;
  }
}
