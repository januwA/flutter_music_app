import 'package:mobx/mobx.dart';
import 'package:flute_music_player/flute_music_player.dart';

part 'song_store.g.dart';

/// 音乐播放状态
enum PlayerState {
  playing,
  paused,
  stopped,
}

class SongStore = _SongStore with _$SongStore;

abstract class _SongStore with Store {
  _SongStore() {
    _initPlayer();
  }

  /// 加载本地音乐状态
  @observable
  bool isLoading = false;

  /// 本地歌曲列表
  @observable
  List<Song> songs = List<Song>();

  /// 正在播放音乐的index
  @observable
  int currentIndex = -1;

  /// 正在播放的音乐
  @observable
  Song playingSong;

  /// 播放状态
  @observable
  PlayerState playerState;

  /// 控制器
  @observable
  MusicFinder audioPlayer;

  /// 总时长
  @observable
  Duration duration = Duration(seconds: 0);

  /// 当前播放位置
  @observable
  Duration position = Duration(seconds: 0);

  @computed
  bool get isPlaying => playerState == PlayerState.playing;

  @computed
  int get songLength => songs.length;

  /// 下一首歌
  @action
  Song nextSong() {
    currentIndex++;
    playingSong = songs[currentIndex];
    return songs[currentIndex % songLength];
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
  void _setCompletionHandler() {
    onComplete();
    position = duration;
  }

  @action
  void _setErrorHandler(String msg) {
    playerState = PlayerState.stopped;
    duration = new Duration(seconds: 0);
    position = new Duration(seconds: 0);
  }

  @action
  Future<void> _initPlayer() async {
    isLoading = true;
    songs = await MusicFinder.allSongs();
    audioPlayer ??= new MusicFinder();
    isLoading = false;
    // 总时长
    audioPlayer.setDurationHandler(_setDurationHandler);

    // 播放位置变化
    audioPlayer.setPositionHandler(_setPositionHandler);

    // 完成时
    audioPlayer.setCompletionHandler(_setCompletionHandler);

    // 错误时
    audioPlayer.setErrorHandler(_setErrorHandler);
  }

  /// 完成一首后，进入下一首
  @action
  void onComplete() {
    playerState = PlayerState.stopped;
    play(nextSong().uri);
  }

  /// 播放
  @action
  Future<void> play(String songUrl) async {
    final result = await audioPlayer.play(songUrl);
    if (result == 1) playerState = PlayerState.playing;
  }

  /// 播放
  @action
  Future<void> playLocal(String songUrl) async {
    final result = await audioPlayer.play(songUrl);
    if (result == 1) playerState = PlayerState.playing;
  }

  /// 暂停音乐
  @action
  Future<void> pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) playerState = PlayerState.paused;
  }

  /// 结束音乐
  @action
  Future<void> stop() async {
    final result = await audioPlayer.stop();
    if (result == 1) playerState = PlayerState.stopped;
  }

  @action
  void seek(double v) {
    audioPlayer.seek(v);
  }

  /// 切换播放歌曲
  @action
  void switchMusic(Song clickedSong) {
    playingSong = clickedSong;
    stop().then((_) {
      play(playingSong.uri);
    });
  }

  /// 每个song item被点击时事件处理
  @action
  itemSongTap(Song tapSong) {
    currentIndex = songs.indexOf(tapSong);
    // print(s.id); // 23117
    // print(s.album); // ジョジョの奇妙な冒険 O.S.T Battle Tendency [Leicht Verwendbar]
    // print(s.albumArt); // /storage/emulated/0/Android/data/com.android.providers.media/albumthumbs/1556812126330
    // print(s.albumId); // 7
    // print(s.artist);//岩崎琢
    // print(s.duration);//201638
    // print(s.title);//Awake
    // print(s.uri);// /storage/emulated/0/netease/cloudmusic/Music/岩崎琢 - Awake.mp3

    if (isPlaying) {
      // 暂停
      // 在列表上点击你应该使用"stop()"而不是"pause()",因为stop会让song真正的结束。
      if (tapSong == playingSong) {
        pause();
      } else {
        switchMusic(tapSong);
      }
    } else {
      // 播放
      if (playingSong == null) {
        // 第一次进入直接播放点击歌曲
        playingSong = tapSong;
        play(playingSong.uri);
      } else if (tapSong != playingSong) {
        // 在列表中点击了其他歌曲
        switchMusic(tapSong);
      } else if (tapSong == playingSong) {
        // 点击了同一首歌曲
        playLocal(playingSong.uri);
      }
    }
  }
}

final songStore = SongStore();
