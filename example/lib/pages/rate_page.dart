import 'package:flutter/material.dart';
import 'package:tdesign/tdesign.dart';

class RatePage extends StatefulWidget {
  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  // ignore: unused_field
  double _rating;

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
        RatingBar(
          value: 3,
          allowHalf: true,
          count: 5,
          ratingWidget: RatingWidget(
            full: Icon(Icons.ac_unit),
            half: Icon(Icons.access_alarm),
            empty: Icon(Icons.access_time),
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        )
      ],
    );
  }
}
