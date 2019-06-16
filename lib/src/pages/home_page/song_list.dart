import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/src/shared/stores/song_store.dart';
import 'package:flutter_music/src/shared/widgets/overflow_text.dart';
import 'package:flutter_music/src/shared/widgets/song_title.dart';

class SongList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          Song tapSong = songStore.songs[index];
          return ListTile(
              key: ValueKey(tapSong.id),
              leading: SongTitle(tapSong),
              title: OverflowText(tapSong.title),
              subtitle: OverflowText(tapSong.album),
              onTap: () => songStore.itemSongTap(tapSong));
        },
        childCount: songStore.songLength,
      ),
    );
  }
}
