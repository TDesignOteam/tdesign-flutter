import 'package:flutter/cupertino.dart';
import 'package:tdesign/src/button/button_base.dart';
import 'package:tdesign/src/button/text_button.dart';
import 'package:tdesign/src/dialog/dialog_util.dart';
import 'package:tdesign/theme/td_text_style.dart';

import '../../tdesign.dart';
import 'dialog_body.dart';

typedef OnWhetherClick = void Function(bool yes, String? payload);

class TDWhetherDialog extends StatelessWidget {
  final String? confirm;
  final String? cancel;
  final String title;
  final String? describe;
  final bool? primary;
  final OnWhetherClick? onWhetherClick;

  TDWhetherDialog(
      {this.confirm,
      required this.title,
      this.cancel,
      this.primary,
      this.describe,
      this.onWhetherClick,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TDialogBody(title: title, describe: describe),
          Row(
            children: [
              //取消按钮
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: TDTheme.divideColor,
                              width: 1,
                              style: BorderStyle.solid))),
                  child: TTextButton(
                    size: TButtonSize.large,
                    onClick: () {
                      if (onWhetherClick != null) {
                        onWhetherClick!(false, null);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    text: cancel ?? '取消',
                    textStyle: tdDialogBase.dialogTitle,
                  ),
                ),
              ),
              Expanded(
                child: TTextButton(
                    size: TButtonSize.large,
                    onClick: () {
                      if (onWhetherClick != null) {
                        onWhetherClick!(true, null);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    text: confirm ?? '确认',
                    textStyle: primary ?? true
                        ? tdTextStyle.m16Primary
                        : tdTextStyle.m16Error),
              ),
              //确认
            ],
          )
        ],
      ),
    );
  }
}
