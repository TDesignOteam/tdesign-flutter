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
                cancel ??
                    _buildButton(
                        context: context,
                        text: cancelText ?? '取消',
                        isConfirm: false),
                Container(
                  width: 1,
                  height: height,
                  color: tdDialogBase.divideColor(context),
                ),
                confirm ??
                    _buildButton(
                        context: context,
                        text: confirmText ?? '确认',
                        isConfirm: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      {required BuildContext context,
      required String text,
      bool isConfirm = false}) {
    return Expanded(
      child: TTextButton(
          text: text,
          textStyle: isConfirm
              ? tdTextStyle.r16Primary(context)
              : tdTextStyle.r16Text(context, textLevel: 3),
          onClick: () {
            Navigator.pop(context);
            if (isConfirm) {
              if (onConfirm != null) {
                onConfirm!();
              }
            }
          }),
    );
  }
}
