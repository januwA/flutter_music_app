import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flute_music_player/flute_music_player.dart';

/// 音乐播放状态
enum PlayerState {
  playing,
  paused,
  stopped,
}

class SongService {
  Stream<List<Song>> get songs$ => _songsSubject.stream;
  final _songsSubject = BehaviorSubject<List<Song>>();

  /// 本地歌曲列表
  List<Song> _songs = List<Song>();

  /// 正在播放音乐的index
  int currentIndex = -1;

  /// 正在播放的音乐
  Song playingSong;

  /// 播放状态
  PlayerState playerState;

  /// 控制器
  MusicFinder audioPlayer;

  /// 总时长
  Duration duration = Duration(seconds: 0);

  /// 当前播放位置
  Duration position = Duration(seconds: 0);

  bool get isPlaying => playerState == PlayerState.playing;
  int get songLength => _songs.length;

  SongService() {
    _initPlayer().then((_) {
      _songsSubject.add(_songs);
    });
  }

  void dispose() {
    _songsSubject.close();
  }

  /// 初始化获取用户本地的音乐列表
  Future<Null> _initPlayer() async {
    _songs = await MusicFinder.allSongs();
    audioPlayer ??= new MusicFinder();

    // 播放总时长
    audioPlayer.setDurationHandler((Duration d) {
      duration = d;
      _songsSubject.add(_songs);
    });

    // listen 播放位置变化
    audioPlayer.setPositionHandler((Duration p) {
      position = p;
      _songsSubject.add(_songs);
    });

    // 完成时
    audioPlayer.setCompletionHandler(() {
      onComplete();
      position = duration;
      _songsSubject.add(_songs);
    });

    // 错误时
    audioPlayer.setErrorHandler((msg) {
      playerState = PlayerState.stopped;
      duration = new Duration(seconds: 0);
      position = new Duration(seconds: 0);
      _songsSubject.add(_songs);
    });
  }

  /// 下一首歌
  Song get nextSong {
    currentIndex++;
    playingSong = _songs[currentIndex];
    return _songs[currentIndex % _songs.length];
  }

  /// 完成一首后，进入下一首
  void onComplete() {
    playerState = PlayerState.stopped;
    play(nextSong.uri);
    _songsSubject.add(_songs);
  }

  /// 播放
  play(songUrl) async {
    final result = await audioPlayer.play(songUrl);
    if (result == 1) playerState = PlayerState.playing;
    _songsSubject.add(_songs);
  }

  /// 播放
  playLocal(songUrl) async {
    final result = await audioPlayer.play(songUrl);
    if (result == 1) playerState = PlayerState.playing;
    _songsSubject.add(_songs);
  }

  /// 暂停音乐
  pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) playerState = PlayerState.paused;
    _songsSubject.add(_songs);
  }

  /// 结束音乐
  stop() async {
    final result = await audioPlayer.stop();
    if (result == 1) playerState = PlayerState.stopped;
    _songsSubject.add(_songs);
  }

  void seek(double v) {
    audioPlayer.seek(v);
    _songsSubject.add(_songs);
  }

  /// 切换播放歌曲
  void switchMusic(Song clickedSong) async {
    playingSong = clickedSong;
    await stop();
    await play(playingSong.uri);
  }

  /// 每个song item被点击时事件处理
  itemSongTap(Song tapSong, int index) {
    return () async {
      currentIndex = index;
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
          await pause();
        } else {
          switchMusic(tapSong);
        }
      } else {
        // 播放
        if (playingSong == null) {
          // 第一次进入直接播放点击歌曲
          playingSong = tapSong;
          await play(playingSong.uri);
        } else if (tapSong != playingSong) {
          // 在列表中点击了其他歌曲
          switchMusic(tapSong);
        } else if (tapSong == playingSong) {
          // 点击了同一首歌曲
          await playLocal(playingSong.uri);
        }
      }

      _songsSubject.add(_songs);
    };
  }
}

SongService songService = SongService();
