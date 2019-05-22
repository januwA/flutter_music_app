import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flute_music_player/flute_music_player.dart';

class SongTitle extends StatelessWidget {
  final Song song;
  final BoxFit fit;
  final double borderRadius;
  final bool grid;
  final double width;
  final double height;

  SongTitle(
    this.song, {
    Key key,
    this.fit = BoxFit.fill,
    this.borderRadius = 4.0,
    this.grid = false,
    this.width,
    this.height,
  }) : super(key: key);

  SongTitle.grid(
    song, {
    Key key,
    BoxFit fit = BoxFit.fill,
    double borderRadius = 4.0,
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
    if (grid) {
      return ClipRRect(
        borderRadius: imageBorderRadius,
        child: song.albumArt == null
            ? CachedNetworkImage(
                imageUrl: "https://s2.ax1x.com/2019/05/22/V9fCKH.jpg",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                fit: fit,
                height: height,
                width: width,
              )
            : Image.file(
                new File.fromUri(
                  Uri.parse(song.albumArt),
                ),
                fit: fit,
                height: height,
                width: width,
              ),
      );
    }
    return CircleAvatar(
      child: song.albumArt == null
          ? Text(song.title[0])
          : ClipRRect(
              borderRadius: imageBorderRadius,
              child: new Image.file(
                new File.fromUri(
                  Uri.parse(song.albumArt),
                ),
                fit: fit,
                height: height,
                width: width,
              ),
            ),
    );
  }
}
