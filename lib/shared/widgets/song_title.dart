import 'dart:io';
import 'package:flutter/material.dart';

class SongTitle extends StatelessWidget {
  final path;
  final BoxFit fit;
  final double borderRadius;

  SongTitle(
    this.path, {
    Key key,
    this.fit = BoxFit.fill,
    this.borderRadius = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: path is Widget
          ? path
          : ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: new Image.file(
                new File.fromUri(
                  Uri.parse(path),
                ),
                fit: fit,
              ),
            ),
    );
  }
}
