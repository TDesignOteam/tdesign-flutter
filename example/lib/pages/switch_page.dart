import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class SwitchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SwitchPageState();
  }
}

class _SwitchPageState extends State<SwitchPage> {
  var _status = <bool>[true, false, true, false, true, false];

  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(), title: 'Switch');
  }

  Widget _widget() {
    return ListView(children: [
      PageUtil.buildSubTitle('基础开关'),
      _buildTile(_buildSwitch(0, SwitchType.normal)),
      Divider(height: 0),
      _buildTile(_buildSwitch(1, SwitchType.disable)),
      Divider(height: 0),
      _buildTile(_buildSwitch(2, SwitchType.loading)),
      Divider(height: 0),
      PageUtil.buildSubTitle('带描述开关'),
      _buildTile(_buildSwitch(3, SwitchType.normal, 'Normal')),
      Divider(height: 0),
      _buildTile(_buildSwitch(4, SwitchType.disable, 'Disable')),
      Divider(height: 0),
      _buildTile(_buildSwitch(5, SwitchType.loading, 'Loading')),
      Divider(height: 0),
    ]);
  }

  Widget _buildTile(List<Widget> list) {
    return PageUtil.buildTile(
      context,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: list,
      ),
      alignment: Alignment.center,
      height: 80,
    );
  }

  List<Widget> _buildSwitch(int index, SwitchType type, [String? text]) {
    return [
      Text('标题'),
      Spacer(),
      TDSwitch(
        value: _status[index],
        type: type,
        onChanged: (val) {
          setState(() {
            _status[index] = val;
          });
        },
        text: text ?? null,
      )
    ];
  }
}
