import 'dart:ffi';

/// 数据源
class TDPickerItem {
  /// 显示内容(String or Widget)
  final dynamic item;

  /// 子项
  final List<TDPickerItem>? children;

  TDPickerItem({this.item, this.children});
}

class TDPickerRootItem {
  final List<TDPickerItem>? children;

  //是否是数据
  bool _isArray = false;

  //最大层级
  int _maxLevel = -1;

  TDPickerRootItem({this.children});

  static isArrayData(List? pickerData) {
    var firstData = (pickerData ?? []).first;
    return (firstData is List) || (firstData is Array);
  }

  TDPickerRootItem.parsePickerData(List? pickerData)
      : children = <TDPickerItem>[] {
    if (pickerData?.isNotEmpty != true) {
      return;
    }

    _isArray = isArrayData(pickerData) ?? false;
    if (_isArray) {
      _maxLevel = pickerData!.length;
      _parseArrayPickerDataItem(pickerData, children!);
    } else {
      _parsePickerDataItem(pickerData, children!);
    }
  }

  _parseArrayPickerDataItem(List? pickerData, List<TDPickerItem> data) {
    if (pickerData == null) return;
    var len = pickerData.length;
    for (int i = 0; i < len; i++) {
      var v = pickerData[i];

      if (!(v is List)) continue;
      List lv = v;
      if (lv.length == 0) continue;

      TDPickerItem item = TDPickerItem(children: <TDPickerItem>[]);
      data.add(item);

      for (int j = 0; j < lv.length; j++) {
        var o = lv[j];
        item.children!.add(TDPickerItem(item: o.toString()));
      }
    }
  }

  _parsePickerDataItem(List? pickerData, List<TDPickerItem> data) {
    if (pickerData == null) return;
    var len = pickerData.length;
    for (int i = 0; i < len; i++) {
      var item = pickerData[i];
      if (item is String) {
        data.add(new TDPickerItem(item: item));
      } else if (item is Map) {
        final Map map = item;
        if (map.length == 0) continue;

        List _mapList = map.keys.toList().cast();
        for (int j = 0; j < _mapList.length; j++) {
          var _o = map[_mapList[j]];
          if (_o is List && _o.length > 0) {
            List<TDPickerItem> _children = <TDPickerItem>[];
            //print('add: ${data.runtimeType.toString()}');
            data.add(TDPickerItem(item: _mapList[j], children: _children));
            _parsePickerDataItem(_o, _children);
          }
        }
      } else if (!(item is List)) {
        String _v = item.toString();
        //print('add: $_v');
        data.add(TDPickerItem(item: _v));
      }
    }
  }

  bool get isArray => _isArray;

  ///最深层级数量
  int get maxLevel {
    if (_maxLevel == -1) _checkMaxLevel(children, 1);
    return _maxLevel;
  }

  void _checkMaxLevel(List<TDPickerItem>? list, int level) {
    if (list == null) return;
    if (_isArray) {
      _maxLevel = list.length;
      return;
    }
    for (int i = 0; i < list.length; i++) {
      if (list[i].children != null && list[i].children!.length > 0)
        _checkMaxLevel(list[i].children, level + 1);
    }
    if (_maxLevel < level) _maxLevel = level;
  }
}
