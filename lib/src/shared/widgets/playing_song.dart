import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_music/src/shared/stores/global_store.dart';
import 'package:flutter_music/src/shared/stores/song_store.dart';
import 'package:flutter_music/src/shared/widgets/overflow_text.dart';
import 'package:flutter_music/src/shared/widgets/song_title.dart';

class PlayingSongView extends StatelessWidget {
  int get currentTimeMilliseconds =>
      songStore.position == null ? 0 : songStore.position.inMilliseconds;

  /// 把一个值从一个范围映射到另一个范围
  double _ourMap(num v, num start1, num stop1, num start2, num stop2) {
    return (v - start1) / (stop1 - start1) * (stop2 - start2) + start2;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => songStore.playingSong == null
          ? Container()
          : Container(
              decoration: BoxDecoration(
                color: globalStore.isDark
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  _SongSlider(),
                  ListTile(
                    dense: true, // 稍微小点
                    leading: SongTitle(
                      songStore.playingSong,
                      borderRadius: 30.0,
                    ),
                    title: Tooltip(
                      message: songStore.playingSong.title,
                      child: OverflowText(songStore.playingSong.title),
                    ),
                    subtitle: Tooltip(
                      message: songStore.playingSong.album,
                      child: OverflowText(songStore.playingSong.artist),
                    ),
                    trailing: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation(
                            globalStore.isDark
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                          ),
                          strokeWidth: 2.0,
                          value: _ourMap(currentTimeMilliseconds, 0,
                              songStore.playingSong.duration, 0, 1),
                          // value: 0.3,
                        ),
                        IconButton(
                          icon: Icon(
                            songStore.playerState != PlayerState.playing
                                ? Icons.play_arrow
                                : Icons.pause,
                            color: globalStore.isDark
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                          ),
                          onPressed: () async {
                            if (songStore.playerState == PlayerState.playing) {
                              await songStore.pause();
                            } else {
                              await songStore
                                  .playLocal(songStore.playingSong.uri);
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class _SongSlider extends StatelessWidget {
  double get _valueSeconds =>
      songStore.position == null ? 0 : songStore.position.inSeconds.toDouble();
  double get _maxSeconds =>
      songStore.duration == null ? 0 : songStore.duration.inSeconds.toDouble();

  String get durationText {
    if (songStore.duration == null) return '';
    var r = songStore.duration.toString().split('.').first.split(':')
      ..removeAt(0);
    return r.join(':');
  }

  String get positionText {
    if (songStore.position == null) return '';
    var r = songStore.position.toString().split('.').first.split(':')
      ..removeAt(0);
    return r.join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        children: <Widget>[
          Text(positionText),
          Expanded(
            child: Slider(
              activeColor: globalStore.isDark
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              inactiveColor: Colors.grey[300],
              min: 0,
              max: _maxSeconds,
              value: _valueSeconds,
              onChanged: (_) {},
              onChangeEnd: songStore.seek,
            ),
          ),
          Text(durationText),
        ],
      ),
    );
  }
}
