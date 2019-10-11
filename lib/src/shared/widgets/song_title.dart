import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/src/store/main/main.store.dart';

class SongTitle extends StatelessWidget {
  static const BoxFit _fit = BoxFit.cover;
  static const double _borderRadius = 4.0;
  final Song song;
  final BoxFit fit;
  final double borderRadius;
  final bool grid;
  final double width;
  final double height;

  SongTitle(
    this.song, {
    Key key,
    this.fit = _fit,
    this.borderRadius = _borderRadius,
    this.grid = false,
    this.width,
    this.height,
  }) : super(key: key);

  SongTitle.grid(
    song, {
    Key key,
    BoxFit fit = _fit,
    double borderRadius = _borderRadius,
    double height,
    double width,
  }) : this(
          song,
          fit: fit,
          borderRadius: borderRadius,
          grid: true,
          height: height,
          width: width,
        );

  @override
  Widget build(BuildContext context) {
    BorderRadius imageBorderRadius = BorderRadius.circular(borderRadius);
    var theme = Theme.of(context);
    if (grid) {
      return ClipRRect(
        borderRadius: imageBorderRadius,
        child: song.albumArt == null
            ? Image.asset(
                'assets/i.jpg',
                fit: fit,
                height: height,
                width: width,
              )
            : Image.file(
                File(song.albumArt),
                fit: fit,
                height: height,
                width: width,
              ),
      );
    }
    return CircleAvatar(
      backgroundColor:
          mainStore.themeService.isDark ? Colors.white : theme.primaryColor,
      child: song.albumArt == null
          ? Text(song.title[0])
          : ClipRRect(
              borderRadius: imageBorderRadius,
              child: Image.file(
                File(song.albumArt),
                fit: fit,
                height: height,
                width: width,
              ),
            ),
    );
  }
}
