import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_music/src/shared/widgets/overflow_text.dart';
import 'package:flutter_music/src/shared/widgets/song_title.dart';
import 'package:flutter_music/src/store/main/main.store.dart';

class PlayingSongView extends StatelessWidget {
  /// 把一个值从一个范围映射到另一个范围
  double _ourMap(num v, num start1, num stop1, num start2, num stop2) {
    return (v - start1) / (stop1 - start1) * (stop2 - start2) + start2;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Observer(
      builder: (_) {
        final song = mainStore.songService.playingSong;
        if (song == null) {
          return SizedBox();
        }

        return Card(
          child: Column(
            children: <Widget>[
              _SongSlider(),
              ListTile(
                dense: true, // 稍微小点
                leading: SongTitle(
                  song,
                  borderRadius: 30.0,
                ),
                title: Tooltip(
                  message: song.title,
                  child: OverflowText(song.title),
                ),
                subtitle: Tooltip(
                  message: song.album ?? '',
                  child: OverflowText(song.artist ?? ''),
                ),
                trailing: _PlaybackControls(
                  mapValue: _ourMap,
                  theme: theme,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _SongSlider extends StatelessWidget {
  double get _valueSeconds =>
      mainStore.songService.position.inSeconds.toDouble();
  double get _maxSeconds => mainStore.songService.duration.inSeconds.toDouble();

  String get durationText {
    var r = mainStore.songService.duration
        .toString()
        .split('.')
        .first
        .split(':')
          ..removeAt(0);
    return r.join(':');
  }

  String get positionText {
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
    return Observer(
      builder: (_) => Container(
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
                  activeColor: theme.colorScheme.secondary,
                  inactiveColor: theme.colorScheme.secondary.withAlpha(100),
                  min: 0,
                  max: _maxSeconds == 0 ? 1 : _maxSeconds,
                  value: _valueSeconds.clamp(
                    0,
                    _maxSeconds == 0 ? 1 : _maxSeconds,
                  ),
                  onChanged: (_) {},
                  onChangeEnd: (double v) =>
                      mainStore.songService.seek(Duration(seconds: v.toInt())),
                ),
              ),
            ),
            Text(durationText),
          ],
        ),
      ),
    );
  }
}

class _PlaybackControls extends StatelessWidget {
  final double Function(num, num, num, num, num) mapValue;
  final ThemeData theme;

  const _PlaybackControls({
    Key? key,
    required this.mapValue,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final currentTimeMilliseconds =
            mainStore.songService.position.inMilliseconds;
        final durationMilliseconds =
            mainStore.songService.duration.inMilliseconds;
        final isPlaying = mainStore.songService.isPlaying;
        return Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.grey[300],
              strokeWidth: 2.0,
              value: mapValue(
                currentTimeMilliseconds,
                0,
                durationMilliseconds,
                0,
                1,
              ),
            ),
            IconButton(
              color: theme.colorScheme.secondary,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () async {
                if (isPlaying) {
                  await mainStore.songService.pause();
                } else {
                  await mainStore.songService.play();
                }
              },
            )
          ],
        );
      },
    );
  }
}
