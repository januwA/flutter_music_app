import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/shared/song.service.dart' show PlayerState;
import 'package:flutter_music/shared/widgets/song_title.dart';
import 'package:flutter_music/shared/widgets/overflow_text.dart';

class PlayingSongView extends StatelessWidget {
  const PlayingSongView({
    Key key,
    this.position,
    this.playingSong,
    this.playerState,
    this.pause,
    this.playLocal,
    this.currentTime,
    this.slider,
  }) : super(key: key);

  final Duration currentTime; // 当前歌曲播放到哪(毫秒)
  int get currentTimeMilliseconds =>
      currentTime == null ? 0 : currentTime.inMilliseconds;

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
  final Widget slider;

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
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: <Widget>[
                    slider == null ? Container() : slider,
                    ListTile(
                      dense: true, // 稍微小点
                      leading: SongTitle(
                        playingSong,
                        borderRadius: 30.0,
                      ),
                      title: Tooltip(
                        message: playingSong.title,
                        child: OverflowText(playingSong.title),
                      ),
                      subtitle: Tooltip(
                        message: playingSong.album,
                        child: OverflowText(playingSong.artist),
                      ),
                      trailing: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                            backgroundColor:
                                Theme.of(context).primaryColorLight,
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColorDark),
                            strokeWidth: 2.0,
                            value: _ourMap(currentTimeMilliseconds, 0,
                                playingSong.duration, 0, 1),
                            // value: 0.3,
                          ),
                          IconButton(
                            icon: Icon(
                              playerState != PlayerState.playing
                                  ? Icons.play_arrow
                                  : Icons.pause,
                              color: Theme.of(context).primaryColorLight,
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
                    )
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
