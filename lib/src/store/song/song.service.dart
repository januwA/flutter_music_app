import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:mobx/mobx.dart';

part 'song.service.g.dart';

class SongService = _SongService with _$SongService;

abstract class _SongService with Store {
  _SongService() {
    _init();
  }

  /// 加载本地音乐状态
  @observable
  bool isLoading = false;

  FlutterAudioQuery audioQuery;

  /// 本地歌曲列表
  @observable
  List<SongInfo> songs = List<SongInfo>();
  @observable
  List<ArtistInfo> artists = List<ArtistInfo>();
  @observable
  AudioPlayerState state = AudioPlayerState.STOPPED;

  /// 正在播放的音乐
  @observable
  SongInfo playingSong;

  /// 控制器
  @observable
  AudioPlayer audioPlayer;

  /// 总时长
  @observable
  Duration duration = Duration(seconds: 1);

  /// 当前播放位置
  @observable
  Duration position = Duration(seconds: 0);

  @action
  void setState() {
    state = audioPlayer.state;
  }

  @action
  void _setDurationHandler(Duration d) {
    duration = d;
  }

  @action
  void _setPositionHandler(Duration p) {
    position = p;
  }

  @action
  void _setCompletionHandler(_) {
    int index = songs.indexOf(playingSong);
    int nextIndex = (index + 1) % songs.length;
    itemSongTap(songs[nextIndex]);
  }

  @action
  void _setErrorHandler(String msg) {
    duration = new Duration(seconds: 0);
    position = new Duration(seconds: 0);
  }

  @action
  Future<void> _init() async {
    isLoading = true;
    audioQuery ??= FlutterAudioQuery();
    songs = await audioQuery.getSongs();
    artists = await audioQuery.getArtists();
    audioPlayer ??= AudioPlayer();
    AudioPlayer.logEnabled = false;
    isLoading = false;

    // 总时长
    audioPlayer.onDurationChanged.listen(_setDurationHandler);

    // 播放位置变化
    audioPlayer.onAudioPositionChanged.listen(_setPositionHandler);

    // 完成时
    audioPlayer.onPlayerCompletion.listen(_setCompletionHandler);

    // 错误时
    audioPlayer.onPlayerError.listen(_setErrorHandler);
  }

  dispose() {
    audioPlayer?.stop();
    audioPlayer?.dispose();
  }

  @action
  void seek(Duration v) {
    audioPlayer.seek(v);
  }

  String getArtistArtPath(String artistId) {
    try {
      return artists
              .firstWhere((i) => i.id.contains(artistId))
              ?.artistArtPath
              ?.trim() ??
          "";
    } catch (e) {
      return "";
    }
  }

  /// 每个song item被点击时事件处理
  @action
  itemSongTap(SongInfo it) async {
    if (audioPlayer.state == AudioPlayerState.PLAYING) {
      if (it == playingSong)
        await audioPlayer.pause();
      else
        await audioPlayer.play(it.filePath);
    } else {
      await audioPlayer.play(it.filePath);
    }
    setState();
    playingSong = it;
  }
}
