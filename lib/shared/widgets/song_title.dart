import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

class SongTitle extends StatelessWidget {
  final Song song;
  final BoxFit fit;
  final double borderRadius;

  SongTitle(
    this.song, {
    Key key,
    this.fit = BoxFit.fill,
    this.borderRadius = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: song.albumArt == null
          ? Text(song.title[0])
          : ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: new Image.file(
                new File.fromUri(
                  Uri.parse(song.albumArt),
                ),
                fit: fit,
              ),
            ),
    );
  }
}
