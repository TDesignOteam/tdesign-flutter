import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/src/button/button_base.dart';
import 'package:tdesign/src/button/text_button.dart';
import 'package:tdesign/src/dialog/dialog_util.dart';
import 'package:tdesign/src/dialog/whether_dialog.dart';
import 'package:tdesign/tdesign.dart';
import 'package:tdesign/theme/td_text_style.dart';

import 'dialog_body.dart';

class TDEditDialog extends StatelessWidget {
  final String? confirm;
  final String? cancel;
  final String title;
  final String? describe;
  final OnWhetherClick? onWhetherClick;
  final TextEditingController _controller = TextEditingController();

  TDEditDialog(
      {this.confirm,
      required this.title,
      this.cancel,
      this.describe,
      this.onWhetherClick,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TDialogDefaultTextField textField = TDialogDefaultTextField(
      controller: _controller,
    );
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TDialogBody(title: title, describe: describe, hasDivider: false),
          //编辑框
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 32),
                  child: textField,
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
            color: TDTheme.divideColor,
          ),
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
                        onWhetherClick!(false, _controller.text);
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
                        onWhetherClick!(true, _controller.text);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    text: confirm ?? '确认',
                    textStyle: tdTextStyle.m16Primary),
              ),
              //确认
            ],
          )
        ],
      ),
    );
  }
}

class TDialogDefaultTextField extends StatelessWidget {
  final TextEditingController controller;

  TDialogDefaultTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: '输入文案',
            border: InputBorder.none,
            fillColor: TDTheme.editBackground,
            filled: true,
            hintStyle: tdDialogBase.dialogHint));
  }
}
