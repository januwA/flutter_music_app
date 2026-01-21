import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter_music/src/shared/widgets/overflow_text.dart';
import 'package:flutter_music/src/shared/widgets/song_title.dart';
import 'package:flutter_music/src/store/main/main.store.dart';

class SongGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _SongGridItem(mainStore.songService.songs[index]);
          },
          childCount: mainStore.songService.songs.length,
        ),
      ),
    );
  }
}

class _SongGridItem extends StatelessWidget {
  _SongGridItem(this.song);
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => mainStore.songService.itemSongTap(song),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40.0, // 固定两行文字的高度，解决对齐问题
                    alignment: Alignment.centerLeft,
                    child: OverflowText(
                      song.title,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Opacity(
                    opacity: 0.7,
                    child: OverflowText(
                      song.album ?? 'Unknown Album',
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
