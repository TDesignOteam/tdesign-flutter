import 'package:example/page_util.dart';
import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class RatePage extends StatefulWidget {
  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = 2;
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(child: _widget(), title: 'Rating',);
  }

  Widget _widget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        _titleWith('默认Rate组件'),
        _defaultIconRate(),
        _space,
        _titleWith('使用itemBuilder构建的组件'),
        _rateByItemBuilder(),
        _space,
        _titleWith('使用ratingIcons自定义图标'),
        _rateByConfig(),
        _space,
        _titleWith('完整使用'),
        _fullUseRate(),
        Text(
          '当前分值为：$_rating',
          style: TextStyle(fontSize: 20, color: Colors.lightBlue),
        ),
      ],
    );
  }

  Widget _defaultIconRate() {
    return Rate(value: 2, count: 5);
  }

  Widget _rateByItemBuilder() {
    return Rate(
      value: 2.5,
      count: 5,
      allowHalf: true,
      itemBuilder: (context, _) => Icon(
        TDIcons.starFilled,
        color: TDColors.blue[3],
      ),
    );
  }

  Widget _rateByConfig() {
    return Rate(
      value: 3,
      allowHalf: true,
      count: 5,
      ratingIcons: RatingIconConfig(
        full: Icon(
          TDIcons.usergroup,
          color: Colors.amber,
        ),
        half: Icon(TDIcons.userAvatar, color: Colors.amber),
        empty: Icon(TDIcons.user, color: Colors.amber),
      ),
    );
  }

  Widget _fullUseRate() {
    return Rate(
      value: 2,
      count: 5,
      allowHalf: false,
      showText: true,
      textSize: 20,
      texts: ['差评', '差评', '一般', '一般', '好评', '好评'],
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: TDColors.blue[5],
      ),
      onRatingUpdate: (value) {
        _rating = value;
        setState(() {});
      },
    );
  }

  Widget _titleWith(String txt) {
    return Text(
      txt,
      style: TextStyle(fontSize: 20),
    );
  }

  Widget get _space => SizedBox(height: 35);
}
