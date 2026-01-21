import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'dart:io';
import 'package:flutter_music/src/store/main/main.store.dart';

class SongTitle extends StatelessWidget {
  static const BoxFit _fit = BoxFit.cover;
  static const double _borderRadius = 4.0;
  final SongModel song;
  final BoxFit fit;
  final double borderRadius;
  final bool grid;
  final double? width;
  final double? height;

  SongTitle(
    this.song, {
    Key? key,
    this.fit = _fit,
    this.borderRadius = _borderRadius,
    this.grid = false,
    this.width,
    this.height,
  }) : super(key: key);

  SongTitle.grid(
    song, {
    Key? key,
    BoxFit fit = _fit,
    double borderRadius = _borderRadius,
    double? height,
    double? width,
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
    var theme = Theme.of(context);
    final title = song.title;
    final titleChar = title.isNotEmpty ? title[0] : '?';
    final bool isWindows = !kIsWeb && Platform.isWindows;
    
    final artwork = isWindows || song.id == 0 // 处理伪造 ID 或 Windows
        ? (grid
            ? Image.asset(
                'assets/i.jpg',
                fit: fit,
                height: height,
                width: width,
              )
            : Container(
                width: width ?? 50,
                height: height ?? 50,
                alignment: Alignment.center,
                child: Text(titleChar),
              ))
        : QueryArtworkWidget(
            id: song.id,
            type: ArtworkType.AUDIO,
            artworkFit: fit,
            artworkBorder: BorderRadius.circular(borderRadius),
            artworkWidth: width ?? 50,
            artworkHeight: height ?? 50,
            nullArtworkWidget: grid
                ? Image.asset(
                    'assets/i.jpg',
                    fit: fit,
                    height: height,
                    width: width,
                  )
                : Text(titleChar),
          );

    if (grid) {
      return artwork;
    }

    return CircleAvatar(
      backgroundColor:
          mainStore.themeService.isDark ? Colors.white : theme.primaryColor,
      child: artwork,
    );
  }
}
