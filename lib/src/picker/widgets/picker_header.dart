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
                  _buildButton(context: context, isConfirm: false),
                  Expanded(child: _buildTitle(context), flex: 1),
                  _buildButton(context: context, isConfirm: true),
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
    var style = tdTextStyle.r16Text(context);
    var child = title;
    if (title == null) {
      child = Text(titleText ?? '');
    }

    return DefaultTextStyle(
        style: style, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2, child: child!);
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

    var text = isConfirm ? confirmText : cancelText;
    if (text?.isNotEmpty != true) {
      widget = Container();
    } else {
      widget = Container(
        // constraints: BoxConstraints(minWidth: 75, maxWidth: 150),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TDTextButton(text: text, textStyle: textStyle, onClick: onClick),
      );
    }

    return widget;
  }
}
