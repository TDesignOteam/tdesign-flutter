import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class ButtonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ButtonPageState();
  }
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  void initState() {
    super.initState();
    // Toast.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(context), title: 'Button');
  }

  // ListView 本身的 padding 无法清除，这里纵向间距给8加上本身margin=8，合成16px的间距。
  Widget _widget(BuildContext context) {
    return ListView(children: [
      PageUtil.buildSubTitle('基础按钮'),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: ElevatedButton(
            child: const Text('强按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(TDColors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: TDColors.fontWhite, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: () {}),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: OutlinedButton(
            child: const Text('弱按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(TDColors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(/*color: TDColors.red,*/ fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: TDColors.blue), // TODO: 无法改变边框颜色
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: () {}),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: OutlinedButton(
            child: const Text('次按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(TDColors.fontBlack),
              textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                  /*color: TDColors.fontBlack, */ fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFDDDDDD)),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: () {}),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: OutlinedButton(
            child: const Text('带图标按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(TDColors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(/*color: TDColors.red,*/ fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: TDColors.blue), // TODO: 无法改变边框颜色
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: () {}),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: ElevatedButton(
            child: const Text('强告警按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(TDColors.red),
              textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                  /*color: TDColors.fontWhite, */ fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: () {}),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: OutlinedButton(
            child: const Text('弱告警按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(/*color: TDColors.red,*/ fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: TDColors.red), // TODO: 无法改变边框颜色
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: () {}),
      ),
      Container(
          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          height: 56,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          color: Colors.black.withOpacity(0.4),
          child: OutlinedButton(
              child: const Text('幽灵按钮'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                    /*color: TDColors.fontWhite, */ fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5)),
                fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white), // TODO: 无法改变边框颜色
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              onPressed: () {})),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: TextButton(
            child: const Text('文字按钮'),
            style: ButtonStyle(
              // backgroundColor: MaterialStateProperty.all<Color>(TDColors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: TDColors.blue, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(38)),
            ),
            onPressed: () {}),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ElevatedButton(
            child: const Text('通栏按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(TDColors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: TDColors.fontWhite, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(44)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            onPressed: () {}),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(children: <Widget>[
          Expanded(
            flex: 1,
            child: OutlinedButton(
                child: const Text('次按钮'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                      /*color: TDColors.fontBlack, */ fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5)),
                  fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(44)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
                onPressed: () {}),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
                child: const Text('主按钮'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(TDColors.blue),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(color: TDColors.fontWhite, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
                  fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(44)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
                onPressed: () {}),
          ),
        ]),
      ),
      PageUtil.buildSubTitle('按钮禁用态'),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: ElevatedButton(
            child: const Text('强按钮'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(TDColors.blue.shade3),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                    /*color: TDColors.fontWhite, */ fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5)),
                fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ))),
            onPressed: null),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: OutlinedButton(
            child: const Text('弱按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(TDColors.blue.shade3),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(/*color: TDColors.blue.shade3,*/ fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: TDColors.blue.shade3), // TODO: 无法改变边框颜色
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: null),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: OutlinedButton(
            child: const Text('次按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.26)),
              textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                  /*color: Colors.black.withOpacity(0.26), */ fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFDCDCDC)),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: null),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: OutlinedButton(
            child: const Text('带图标按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(TDColors.blue.shade3),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(/*color: TDColors.blue.shade3,*/ fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: TDColors.blue.shade3), // TODO: 无法改变边框颜色
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: null),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: ElevatedButton(
            child: const Text('强告警按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(TDColors.red.shade3),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(/*color: TDColors.fontWhite, */ fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: null),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: OutlinedButton(
            child: const Text('弱告警按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(TDColors.red.shade3),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(/*color: TDColors.red.shade3,*/ fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: TDColors.red.shade3), // TODO: 无法改变边框颜色
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: null),
      ),
      Container(
          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          height: 56,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          color: Colors.black.withOpacity(0.4),
          child: OutlinedButton(
              child: const Text('幽灵按钮'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.35)),
                textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                    /*color: Colors.white.withOpacity(0.35) */ fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5)),
                fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white.withOpacity(0.35)), // TODO: 无法改变边框颜色
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              onPressed: null)),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: TextButton(
            child: const Text('文字按钮'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(TDColors.blue.shade3),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(/*color: TDColors.blue.shade3, */ fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(38)),
            ),
            onPressed: null),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ElevatedButton(
            child: const Text('通栏按钮'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(TDColors.blue.shade3),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(/*color: TDColors.fontWhite, */ fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(44)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            onPressed: null),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(children: <Widget>[
          Expanded(
            flex: 1,
            child: OutlinedButton(
                child: const Text('次按钮'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.26)),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                      /*color: Colors.black.withOpacity(0.26), */ fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5)),
                  fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(44)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
                onPressed: null),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
                child: const Text('主按钮'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(TDColors.blue.shade3),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(color: TDColors.fontWhite, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
                  fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(44)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
                onPressed: null),
          ),
        ]),
      ),
      PageUtil.buildSubTitle('文字按钮尺寸'),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: ElevatedButton(
            child: const Text('按钮 44'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(TDColors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: TDColors.fontWhite, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(44)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: () {}),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: ElevatedButton(
            child: const Text('按钮 40'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(TDColors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: TDColors.fontWhite, fontSize: 14, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: () {}),
      ),
      Padding(
        padding: EdgeInsets.only(top: 4.0, left: 16.0, right: (MediaQuery.of(context).size.width - 16 - 90)),
        child: ElevatedButton(
            child: const Text('按钮 36'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(TDColors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: TDColors.fontWhite, fontSize: 14, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size(90, 36)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: () {}),
      ),
      // TODO: 高度无法指定28！？
      Padding(
        padding: EdgeInsets.only(top: 4.0, left: 16.0, right: (MediaQuery.of(context).size.width - 16 - 82)),
        child: ElevatedButton(
            child: const Text('按钮 28'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(TDColors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: TDColors.fontWhite, fontSize: 14, fontWeight: FontWeight.w400, height: 1.5)),
              fixedSize: MaterialStateProperty.all<Size>(Size(82, 28)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            onPressed: () {}),
      ),
    ]);
  }
}
