import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/src/shared/stores/song_store.dart';
import 'package:flutter_music/src/shared/widgets/overflow_text.dart';
import 'package:flutter_music/src/shared/widgets/song_title.dart';

class SongGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      sliver: SliverGrid.count(
        crossAxisSpacing: 4.0,
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        children: <Widget>[
          for (Song song in songStore.songs) _SongGridItem(song),
        ],
      ),
    );
  }
}

class _SongGridItem extends StatelessWidget {
  _SongGridItem(this.song);
  final Song song;
  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(song.id),
      child: InkWell(
        onTap: () => songStore.itemSongTap(song),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: SongTitle.grid(
                song,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 95,
              ),
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
