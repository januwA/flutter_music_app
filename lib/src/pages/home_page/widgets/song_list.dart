import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music/src/shared/widgets/overflow_text.dart';
import 'package:flutter_music/src/shared/widgets/song_title.dart';
import 'package:flutter_music/src/store/main/main.store.dart';

class SongList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          SongInfo tapSong = mainStore.songService.songs[index];
          return ListTile(
            leading: SongTitle(tapSong),
            title: OverflowText(tapSong.title),
            subtitle: OverflowText(tapSong.album),
            onTap: () => mainStore.songService.itemSongTap(tapSong),
          );
        },
        childCount: mainStore.songService.songs.length,
      ),
    );
  }
}
