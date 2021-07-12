import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/src/picker/widgets/picker_controller.dart';

import '../../../tdesign.dart';

///picker
class TDPickersWidget extends StatefulWidget {
  TDPickersWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TDPickerController controller;

  @override
  State<StatefulWidget> createState() => _TDPickersWidgetState();
}

class _TDPickersWidgetState extends State<TDPickersWidget> {
  // final _selectionOverlay = CupertinoPickerDefaultSelectionOverlay(
  //     capLeftEdge: false, capRightEdge: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var columns = _buildPickers(context);

    return SizedBox(
        height: widget.controller.height,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: columns));
  }

  ///动态数据
  List<Widget> _buildPickers(BuildContext context) {
    var columns = <Widget>[];

    var childDelegate = widget.controller.childDelegate;

    var selects = widget.controller.selects;
    // for (var controller in childDelegate.columnControllerList) {
    //   selects.add(controller.initialItem);
    // }
    for (var column = 0; column < childDelegate.columnCount; ++column) {
      var group = CupertinoPicker.builder(
          diameterRatio: widget.controller.diameterRatio,
          itemExtent: widget.controller.itemExtent,
          offAxisFraction: widget.controller.offAxisFraction,
          // useMagnifier: true,
          // magnification: 2.35 / 2.1, //UI确认不需要放大器
          squeeze: 1.0,
          //_selectionOverlay
          selectionOverlay: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Divider(height: 1, color: tdDialogBase.divideColor(context)),
              Divider(height: 1, color: tdDialogBase.divideColor(context)),
            ],
          ),
          scrollController: childDelegate.columnControllerList[column],
          onSelectedItemChanged: (rowIndex) {
            onSelectedItemChanged(column, rowIndex);
          },
          childCount: childDelegate.rowCount(selects.sublist(0, column)),
          itemBuilder: (context, row) {
            var tmpSelects = selects.sublist(0, column);
            tmpSelects.add(row);
            return childDelegate.itemWidget(context, tmpSelects);
          });
      columns.add(Expanded(child: group));
    }
    return columns;
  }

  ///选中回调
  void onSelectedItemChanged(int column, int row) {
    var childDelegate = widget.controller.childDelegate;
    if (widget.controller.isLinkageData == true &&
        column != childDelegate.columnCount - 1) {
      setState(() {});
    }

    if (widget.controller.changeToFirst == true) {
      for (var index = column + 1; index < childDelegate.columnCount; ++index) {
        var ctrl = childDelegate.columnControllerList[index];
        // ctrl.jumpToItem(0);
        ctrl.animateToItem(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    }
  }
}
