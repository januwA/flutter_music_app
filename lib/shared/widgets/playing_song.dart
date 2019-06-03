import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/shared/song.service.dart'
    show PlayerState, songService;
import 'package:flutter_music/shared/widgets/song_title.dart';
import 'package:flutter_music/shared/widgets/overflow_text.dart';

class PlayingSongView extends StatelessWidget {
  const PlayingSongView({
    Key key,
  }) : super(key: key);

  int get currentTimeMilliseconds =>
      songService.position == null ? 0 : songService.position.inMilliseconds;

  /// 把一个值从一个范围映射到另一个范围
  double _ourMap(num v, num start1, num stop1, num start2, num stop2) {
    return (v - start1) / (stop1 - start1) * (stop2 - start2) + start2;
  }

  @override
  Widget build(BuildContext context) {
    Song playingSong = songService.playingSong;
    if (null == songService.playingSong) return Container();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: <Widget>[
          _SongSlider(
            value: songService.position,
            max: songService.duration,
            onChangeEnd: songService.seek,
          ),
          ListTile(
            dense: true, // 稍微小点
            leading: SongTitle(
              songService.playingSong,
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
                  backgroundColor: Theme.of(context).primaryColorLight,
                  valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).primaryColorDark),
                  strokeWidth: 2.0,
                  value: _ourMap(
                      currentTimeMilliseconds, 0, playingSong.duration, 0, 1),
                  // value: 0.3,
                ),
                IconButton(
                  icon: Icon(
                    songService.playerState != PlayerState.playing
                        ? Icons.play_arrow
                        : Icons.pause,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () async {
                    if (songService.playerState == PlayerState.playing) {
                      await songService.pause();
                    } else {
                      await songService.playLocal(playingSong.uri);
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
typedef void Change(double v);

class _SongSlider extends StatelessWidget {
  _SongSlider({
    Key key,
    this.max,
    this.value,
    this.onChangeEnd,
  }) : super(key: key);

  final Duration value;
  final Duration max;
  final Change onChangeEnd;

  double get _valueSeconds => value == null ? 0 : value.inSeconds.toDouble();
  double get _maxSeconds => value == null ? 0 : max.inSeconds.toDouble();

  String get durationText {
    if (max == null) return '';
    var r = max.toString().split('.').first.split(':')..removeAt(0);
    return r.join(':');
  }

  String get positionText {
    if (value == null) return '';
    var r = value.toString().split('.').first.split(':')..removeAt(0);
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
              activeColor: Theme.of(context).primaryColorDark,
              inactiveColor: Theme.of(context).primaryColorLight,
              min: 0,
              max: _maxSeconds,
              value: _valueSeconds,
              onChanged: (v) {},
              onChangeEnd: onChangeEnd,
            ),
          ),
          Text(durationText),
        ],
      ),
    );
  }
}

