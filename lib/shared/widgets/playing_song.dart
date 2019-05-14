import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/shared/widgets/song_title.dart';
import 'package:flutter_music/shared/widgets/overflow_text.dart';
import 'package:flutter_music/shared/player_state.dart';

class PlayingSongView extends StatelessWidget {
  const PlayingSongView({
    Key key,
    this.position,
    this.playingSong,
    this.playerState,
    this.pause,
    this.playLocal,
  }) : super(key: key);

  // 动画
  final Animation<Offset> position;

  // 正在播放的各歌曲
  final Song playingSong;

  // 播放状态
  final PlayerState playerState;

  // 暂停事件
  final pause;

  // 播放事件
  final playLocal;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: playingSong != null
          ? SlideTransition(
              position: position,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  dense: true, // 稍微小点
                  leading: SongTitle(
                    playingSong.albumArt == null
                        ? Text(playingSong.title[0])
                        : playingSong.albumArt,
                    borderRadius: 30.0,
                  ),
                  title: OverflowText(playingSong.title),
                  subtitle: OverflowText(playingSong.album),
                  trailing: IconButton(
                    icon: Icon(
                      playerState != PlayerState.playing
                          ? Icons.play_arrow
                          : Icons.pause,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () async {
                      if (playerState == PlayerState.playing) {
                        await pause();
                      } else {
                        await playLocal(playingSong.uri);
                      }
                    },
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
