import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

import 'dialog_util.dart';

class TDialogBody extends StatelessWidget {
  final String? describe;
  final String title;
  final bool? hasDivider;

  TDialogBody({this.describe, required this.title, this.hasDivider});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: 32.0,
              left: 24.0,
              right: 24.0,
              bottom: (describe?.isNotEmpty == true) ? 8.0 : 32.0),
          child: Text(
            title,
            style: tdDialogBase.dialogTitle,
          ),
        ),
        Visibility(
          visible: (describe?.isNotEmpty == true),
          //超过200有滚动条 高度为
          child: (describe?.length ?? 0) > 200
              ? Scrollbar(
                  child: SizedBox(
                    height: 312,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 24.0, right: 24.0, bottom: 32.0),
                        child: Text(
                          describe ?? '',
                          style: tdDialogBase.dialogDescribe,
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(
                      top: 8.0, left: 24.0, right: 24.0, bottom: 32.0),
                  child: Text(
                    describe ?? '',
                    style: tdDialogBase.dialogDescribe,
                  ),
                ),
        ),
        hasDivider ?? true
            ? Divider(
                height: 1,
                color: TDTheme.divideColor,
              )
            : Container(),
      ],
    );
  }
}
