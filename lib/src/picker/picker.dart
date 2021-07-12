import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/src/dialog.dart';
import 'package:tdesign/src/picker/widgets/picker_controller.dart';
import 'package:tdesign/src/picker/widgets/picker_footer.dart';
import 'package:tdesign/src/picker/widgets/picker_header.dart';
import 'package:tdesign/src/picker/widgets/pickers_widget.dart';

enum TDPickerPosition {
  bottom,
  center,
}

///picker
class TDPicker extends StatefulWidget {
  ///控制器
  final TDPickerController pickerController;

  ///位置
  final TDPickerPosition position;
  TDPicker({required this.pickerController, required this.position});

  @override
  State<StatefulWidget> createState() => _TDPickerState();

  static void show(
    BuildContext context,
    TDPickerController pickerController, {
    TDPickerPosition position = TDPickerPosition.bottom,
  }) {
    if (position == TDPickerPosition.center) {
      tdDialogBase.showCenterDialog(
          context: context,
          dialog:
              TDPicker(pickerController: pickerController, position: position));
    } else {
      tdDialogBase.showBottomSheet(
          context: context,
          sheet:
              TDPicker(pickerController: pickerController, position: position));
    }
  }
}

class _TDPickerState extends State<TDPicker> {
  @override
  Widget build(BuildContext context) {
    if (widget.position == TDPickerPosition.center) {
      return _buildCenter(context);
    }
    return _buildBottom(context);
  }

  Widget _buildCenter(BuildContext context) {
    var controller = widget.pickerController;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.pickerController.header ??
            PickerHeader(
                title: controller.title, titleText: controller.titleText),
        TDPickersWidget(controller: widget.pickerController),
        widget.pickerController.footer ??
            PickerFooter(
                cancel: controller.cancel,
                cancelText: controller.cancelText,
                confirm: controller.confirm,
                confirmText: controller.confirmText,
                onConfirm: _onConfirm),
      ],
    );
  }

  Widget _buildBottom(BuildContext context) {
    var controller = widget.pickerController;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.pickerController.header ??
              PickerHeader(
                  title: widget.pickerController.title,
                  titleText: controller.titleText,
                  cancel: controller.cancel,
                  cancelText: controller.cancelText ?? '取消',
                  confirm: controller.confirm,
                  confirmText: controller.confirmText ?? '确认',
                  onConfirm: _onConfirm),
          TDPickersWidget(controller: widget.pickerController),
        ],
      ),
    );
  }

  ///确认回调
  void _onConfirm() {
    if (widget.pickerController.onConfirm == null) {
      return;
    }
    widget.pickerController.onConfirm!(
        widget.pickerController, widget.pickerController.selects);
  }
}
