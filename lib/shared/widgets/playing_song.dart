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
    this.currentTime,
  }) : super(key: key);

  final int currentTime; // 当前歌曲播放到哪(毫秒)

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

  double _ourMap(num v, num start1, num stop1, num start2, num stop2) {
    return (v - start1) / (stop1 - start1) * (stop2 - start2) + start2;
  }

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
                  trailing: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Colors.grey[200],
                        strokeWidth: 2.0,
                        value:
                            _ourMap(currentTime, 0, playingSong.duration, 0, 1),
                        // value: 0.3,
                      ),
                      IconButton(
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
                      )
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
