import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class RatePage extends StatefulWidget {
  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  late double _rating;
  final _subTitleHeight = 45.0;
  final _tileHight = 50.0;

  @override
  void initState() {
    super.initState();
    _rating = 2;
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      child: _widget(),
      title: 'Rating',
    );
  }

  Widget _widget() {
    return ListView(
      children: [
        _buildSubTitle('默认Rate组件'),
        _buildTile(_defaultIconRate()),
        _buildSubTitle('允许半星'),
        _buildTile(_allowHalf()),
        _buildSubTitle('使用itemBuilder配置图标'),
        _buildTile(_rateByItemBuilder()),
        _buildSubTitle('大小、总分、初始分'),
        PageUtil.buildTile(context, _differentSize(), height: null),
        _buildSubTitle('自定义辅助文字'),
        _buildTile(_withHelperText()),
        PageUtil.buildTile(
          context,
          Text(
            '回调传入当前分值：$_rating',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          height: 30,
        ),
        Divider(),
        _buildSubTitle('自定义全星、半星、无星图标和颜色'),
        _buildTile(_rateByConfig()),
      ],
    );
  }

  Widget _defaultIconRate() {
    return TDRate(value: 2, count: 5);
  }

  Widget _allowHalf() {
    return TDRate(
      value: 2.5,
      count: 5,
      allowHalf: true,
    );
  }

  Widget _rateByItemBuilder() {
    return TDRate(
      value: 2,
      count: 5,
      itemBuilder: (context, _) => Padding(
        padding: EdgeInsets.all(2),
        child: Icon(
          TDIcons.starFilled,
          color: Color(0xFFF1AD3D),
        ),
      ),
    );
  }

  Widget _differentSize() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TDRate(value: 0, count: 4, size: 30),
        Divider(),
        TDRate(value: 3, count: 8, size: 20),
        Divider(),
        TDRate(value: 4, count: 5, size: 50)
      ]),
    );
  }

  Widget _rateByConfig() {
    return TDRate(
      value: 2.5,
      allowHalf: true,
      count: 5,
      ratingIcons: RatingIconConfig(
        full: Icon(
          Icons.emoji_events,
          color: TDColors.orange,
        ),
        half: Icon(Icons.emoji_emotions, color: TDColors.blue),
        empty: Icon(Icons.circle, color: TDColors.green),
      ),
    );
  }

  Widget _withHelperText() {
    return TDRate(
      value: 2,
      count: 5,
      allowHalf: false,
      showText: true,
      textSize: 20,
      texts: ['差评', '差评', '一般', '一般', '好评', '好评'],
      onRatingUpdate: (value) {
        _rating = value;
        setState(() {});
      },
    );
  }

  Widget _buildTile(Widget child) {
    return PageUtil.buildTile(context, child, height: _tileHight);
  }

  Widget _buildSubTitle(String text) {
    return PageUtil.buildSubTitle(text, height: _subTitleHeight);
  }
}
