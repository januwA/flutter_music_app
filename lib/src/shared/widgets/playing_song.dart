import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_music/src/shared/widgets/overflow_text.dart';
import 'package:flutter_music/src/shared/widgets/song_title.dart';
import 'package:flutter_music/src/store/main/main.store.dart';

class PlayingSongView extends StatelessWidget {
  int get currentTimeMilliseconds => mainStore.songService.position == null
      ? 0
      : mainStore.songService.position.inMilliseconds;

  /// 把一个值从一个范围映射到另一个范围
  double _ourMap(num v, num start1, num stop1, num start2, num stop2) {
    return (v - start1) / (stop1 - start1) * (stop2 - start2) + start2;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Observer(
      builder: (_) => mainStore.songService.playingSong == null
          ? SizedBox()
          : Card(
              child: Column(
                children: <Widget>[
                  _SongSlider(),
                  ListTile(
                    dense: true, // 稍微小点
                    leading: SongTitle(
                      mainStore.songService.playingSong,
                      borderRadius: 30.0,
                    ),
                    title: Tooltip(
                      message: mainStore.songService.playingSong.title,
                      child:
                          OverflowText(mainStore.songService.playingSong.title),
                    ),
                    subtitle: Tooltip(
                      message: mainStore.songService.playingSong.album,
                      child: OverflowText(
                          mainStore.songService.playingSong.artist),
                    ),
                    trailing: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          backgroundColor: Colors.grey[300],
                          strokeWidth: 2.0,
                          value: _ourMap(
                            currentTimeMilliseconds,
                            0,
                            mainStore.songService.duration.inMilliseconds,
                            0,
                            1,
                          ),
                        ),
                        IconButton(
                          color: theme.accentColor,
                          icon: Icon(
                            mainStore.songService.state !=
                                    AudioPlayerState.PLAYING
                                ? Icons.play_arrow
                                : Icons.pause,
                          ),
                          onPressed: () async {
                            if (mainStore.songService.state ==
                                AudioPlayerState.PLAYING) {
                              await mainStore.songService.audioPlayer.pause();
                            } else {
                              await mainStore.songService.audioPlayer.play(
                                  mainStore.songService.playingSong.filePath);
                            }
                            mainStore.songService.setState();
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
  double get _valueSeconds => mainStore.songService.position == null
      ? 0
      : mainStore.songService.position.inSeconds.toDouble();
  double get _maxSeconds => mainStore.songService.duration == null
      ? 1
      : mainStore.songService.duration.inSeconds.toDouble();

  String get durationText {
    if (mainStore.songService.duration == null) return '';
    var r = mainStore.songService.duration
        .toString()
        .split('.')
        .first
        .split(':')
          ..removeAt(0);
    return r.join(':');
  }

  String get positionText {
    if (mainStore.songService.position == null) return '';
    var r = mainStore.songService.position
        .toString()
        .split('.')
        .first
        .split(':')
          ..removeAt(0);
    return r.join(':');
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        children: <Widget>[
          Text(positionText),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                sliderTheme: Theme.of(context).sliderTheme.copyWith(
                      trackHeight: 3.0,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 5,
                      ),
                    ),
              ),
              child: Slider(
                activeColor: theme.accentColor,
                inactiveColor: theme.accentColor.withAlpha(100),
                min: 0,
                max: _maxSeconds,
                value: _valueSeconds,
                onChanged: (_) {},
                onChangeEnd: (double v) =>
                    mainStore.songService.seek(Duration(seconds: v.toInt())),
              ),
            ),
          ),
          Text(durationText),
        ],
      ),
    );
  }
}
