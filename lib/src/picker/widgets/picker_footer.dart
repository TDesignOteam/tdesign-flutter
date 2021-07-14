import 'package:flutter/material.dart';
import 'package:tdesign/src/button/text_button.dart';
import 'package:tdesign/theme/td_text_style.dart';

import '../../../tdesign.dart';

class PickerFooter extends StatelessWidget {
  ///取消按钮 确认按钮
  final Widget? cancel;
  final Widget? confirm;
  final String? cancelText;
  final String? confirmText;
  final VoidCallback? onConfirm;

  const PickerFooter({
    Key? key,
    this.cancel,
    this.confirm,
    this.cancelText,
    this.confirmText,
    this.onConfirm,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = 50.0;
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Divider(height: 1, color: tdDialogBase.divideColor(context)),
          Container(
            height: height - 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(context: context, isConfirm: false),
                Container(
                  width: 1,
                  height: height,
                  color: tdDialogBase.divideColor(context),
                ),
                _buildButton(context: context, isConfirm: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({required BuildContext context, bool isConfirm = false}) {
    var widget = isConfirm ? confirm : cancel;
    var textStyle = isConfirm ? tdTextStyle.r16Primary(context) : tdTextStyle.r16Text(context, textLevel: 3);
    VoidCallback onClick = () {
      Navigator.pop(context);
      if (isConfirm) {
        if (onConfirm != null) {
          onConfirm!();
        }
      }
    };
    if (widget != null) {
      widget = DefaultTextStyle(style: textStyle, child: widget);
      return onConfirm != null
          ? GestureDetector(
              onTap: onClick,
              child: widget,
            )
          : widget;
    }

    var text = isConfirm ? (confirmText ?? '确认') : (cancelText ?? '取消');
    return Expanded(
      child: TDTextButton(text: text, textStyle: textStyle, onClick: onClick),
    );
  }
}
