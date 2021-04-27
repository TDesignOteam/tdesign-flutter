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
    return Scaffold(appBar: AppBar(title: Text('Rate')), body: SafeArea(bottom: false, child: _widget()));
  }

  Widget _widget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Rate(
          value: 3,
          allowHalf: false,
          count: 5,
          showText: true,
          textSize: 20,
          texts: ['差评', '差评', '一般', '一般', '好评', '好评'],
          ratingIcons: RatingIconConfig(
            full: Icon(Icons.ac_unit),
            half: Icon(Icons.access_alarm),
            empty: Icon(Icons.accessibility_outlined),
          ),
        ),
        SizedBox(height: 20),
        Rate.builder(
          value: 2,
          count: 5,
          allowHalf: true,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.cyan,
          )
        ),
        SizedBox(height: 20),
        Rate.builder(
          value: 2,
          count: 5,
          allowHalf: true,
        )
      ],
    );
  }
}
