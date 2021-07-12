import 'package:flutter/material.dart';
import 'package:tdesign/src/button/text_button.dart';
import 'package:tdesign/theme/td_text_style.dart';

import '../../../tdesign.dart';

class PickerHeader extends StatelessWidget {
  ///标题 取消按钮 确认按钮
  final Widget? title;
  final Widget? cancel;
  final Widget? confirm;
  final String? titleText;
  final String? cancelText;
  final String? confirmText;
  final VoidCallback? onConfirm;

  const PickerHeader({
    Key? key,
    this.title,
    this.cancel,
    this.confirm,
    this.titleText,
    this.cancelText,
    this.confirmText,
    this.onConfirm,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = 56.0;
    return Visibility(
      visible: titleText?.isNotEmpty == true ||
          cancelText?.isNotEmpty == true ||
          confirmText?.isNotEmpty == true ||
          title != null ||
          cancel != null ||
          confirm != null,
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height - 1,
              child: Row(
                children: [
                  cancel ??
                      _buildButton(
                          context: context, text: cancelText, isConfirm: false),
                  Expanded(child: _buildTitle(context), flex: 1),
                  confirm ??
                      _buildButton(
                          context: context, text: confirmText, isConfirm: true),
                ],
              ),
            ),
            Divider(height: 1, color: tdDialogBase.divideColor(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return title ??
        Center(
          child: Text(
            titleText ?? '',
            style: tdTextStyle.r16Text(context),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        );
  }

  Widget _buildButton(
      {required BuildContext context, String? text, bool isConfirm = false}) {
    var widget;
    if (text?.isNotEmpty != true) {
      widget = Container();
    } else {
      widget = Container(
        // constraints: BoxConstraints(minWidth: 75, maxWidth: 150),
        padding: const EdgeInsets.symmetric(horizontal: 15),
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

    return widget;
  }
}
