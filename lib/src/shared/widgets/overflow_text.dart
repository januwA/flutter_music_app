import 'package:flutter/material.dart';

class OverflowText extends Text {
  const OverflowText(
    this.data, {
    Key? key,
    this.maxLines = 1,
  }) : super(
          data,
          key: key,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
        );

  final String data;
  final int maxLines;
}
