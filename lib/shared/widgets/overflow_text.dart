import 'package:flutter/material.dart';

class OverflowText extends Text {
  const OverflowText(
    this.data, {
    Key key,
    this.maxLines = 1,
  }) : super(data);

  final String data;
  final TextOverflow overflow = TextOverflow.ellipsis;
  final int maxLines;
}
