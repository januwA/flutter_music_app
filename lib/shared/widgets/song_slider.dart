import 'package:flutter/material.dart';

typedef void Change(double v);

class SongSlider extends StatelessWidget {
  SongSlider({
    Key key,
    this.max,
    this.value,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  final Duration value;
  final Duration max;
  final Change onChanged;
  final Change onChangeEnd;

  double get _valueSeconds => value == null ? 0 : value.inSeconds.toDouble();
  double get _maxSeconds => value == null ? 0 : max.inSeconds.toDouble();

  String get durationText {
    if (max == null) return '';
    var r = max.toString().split('.').first.split(':')..removeAt(0);
    return r.join(':');
  }

  String get positionText {
    if (value == null) return '';
    var r = value.toString().split('.').first.split(':')..removeAt(0);
    return r.join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        children: <Widget>[
          Text(positionText),
          Expanded(
            child: Slider(
              activeColor: Theme.of(context).primaryColorDark,
              inactiveColor: Theme.of(context).primaryColorLight,
              min: 0,
              max: _maxSeconds,
              value: _valueSeconds,
              onChanged: onChanged,
              onChangeEnd: onChangeEnd,
            ),
          ),
          Text(durationText),
        ],
      ),
    );
  }
}
