import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/shared/song.service.dart';
import 'package:flutter_music/shared/widgets/overflow_text.dart';
import 'package:flutter_music/shared/widgets/song_title.dart';

class SongGrid extends StatelessWidget {
  SongGrid(this.songs);
  final List<Song> songs;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisSpacing: 10.0,
      crossAxisCount: 2,
      children: <Widget>[
        for (Song song in songs) _SongGridItem(song, songs.indexOf(song)),
      ],
    );
  }
}

class _SongGridItem extends StatelessWidget {
  _SongGridItem(this.song, this.index);
  final Song song;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(song.id),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: songService.itemSongTap(song, index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SongTitle.grid(
              song,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 95,
            ),
            ListTile(
              title: OverflowText(song.title),
              subtitle: OverflowText(song.album),
            )
          ],
        ),
      ),
    );
  }
}
