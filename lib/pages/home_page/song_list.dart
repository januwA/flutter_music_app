import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/shared/song.service.dart';
import 'package:flutter_music/shared/widgets/overflow_text.dart';
import 'package:flutter_music/shared/widgets/song_title.dart';

class SongList extends StatelessWidget {
  SongList(this.songs);
  final List<Song> songs;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          Song tapSong = songs[index];
          return Column(
            children: <Widget>[
              ListTile(
                key: ValueKey(tapSong.id),
                dense: true,
                leading: SongTitle(tapSong),
                title: OverflowText(tapSong.title),
                subtitle: OverflowText(tapSong.album),
                onTap: songService.itemSongTap(tapSong, index),
              ),
              index == songs.length - 1 ? Container() : Divider(),
            ],
          );
        },
        childCount: songs.length,
      ),
    );
  }
}
