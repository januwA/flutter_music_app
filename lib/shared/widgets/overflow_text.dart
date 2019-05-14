import 'package:flutter/material.dart';

class OverflowText extends StatelessWidget {

  const OverflowText(
    this.data, {
    Key key,
    this.maxLines = 1,
  }) : super(key: key);
  
  final String data;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
