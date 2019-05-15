import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/shared/widgets/song_title.dart';
import 'package:flutter_music/shared/widgets/page_loading.dart';
import 'package:flutter_music/shared/widgets/playing_song.dart';
import 'package:flutter_music/shared/widgets/overflow_text.dart';
import 'package:flutter_music/shared/widgets/empty_songs.dart';
import 'package:flutter_music/shared/widgets/song_slider.dart';

import 'package:flutter_music/shared/player_state.dart';

void main() => runApp(MyApp());
const int yoff = 3;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  MusicFinder audioPlayer;
  List<Song> _songs = <Song>[]; // 本地音乐列表
  PlayerState playerState; // 播放状态
  Song playingSong; // 正在播放的音乐
  int currentSongIndex = -1; // 正在播放音乐的index
  bool _isLoading = true; // 是否在加载(songs)状态
  Duration duration; // 总时长
  Duration position; // 当前播放位置
  Animation<Offset> bottomViewAnimation;
  AnimationController bottomViewAnimationCtrl;
  bool isThemeDataDark = false;

  bool get isPlaying => playerState == PlayerState.playing;
  bool get isPaused => playerState == PlayerState.paused;
  int get songsLen => _songs != null ? _songs.length : 0;

  // 下一首歌
  Song get nextSong {
    currentSongIndex++;
    playingSong = _songs[currentSongIndex];
    return _songs[currentSongIndex % songsLen];
  }

  @override
  void initState() {
    super.initState();
    _initPlayer();
    _initBottomViewAnimation();
  }

  @override
  void dispose() {
    bottomViewAnimationCtrl.dispose();
    audioPlayer.stop();
    super.dispose();
  }

  /**
   * * 初始化获取用户本地的音乐列表
   */
  void _initPlayer() async {
    _isLoading = true;
    var songs = await MusicFinder.allSongs();
    setState(() {
      _songs = songs;
      _isLoading = false;
    });

    audioPlayer ??= new MusicFinder();
    audioPlayer.setDurationHandler((Duration d) {
      setState(() {
        // 持续时间
        duration = d;
      });
    });

    // listen 播放位置变化
    audioPlayer.setPositionHandler((Duration p) {
      setState(() {
        position = p;
      });
    });

    audioPlayer.setCompletionHandler(() {
      // 完成时
      onComplete();
      setState(() {
        position = duration;
      });
    });

    audioPlayer.setErrorHandler((msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  /**
   * * 初始化底部悬浮view的动画
   */
  void _initBottomViewAnimation() {
    bottomViewAnimationCtrl = new AnimationController(
      duration: const Duration(
        milliseconds: 600,
      ),
      vsync: this,
    );
    bottomViewAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 1), // y轴偏移量+height
    ).animate(bottomViewAnimationCtrl);
  }

  // 播放
  play(songUrl) async {
    final result = await audioPlayer.play(songUrl);
    if (result == 1) setState(() => playerState = PlayerState.playing);
  }

  // 播放
  playLocal(songUrl) async {
    final result = await audioPlayer.play(songUrl);
    if (result == 1) setState(() => playerState = PlayerState.playing);
  }

  // 暂停音乐
  pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => playerState = PlayerState.paused);
  }

  // 结束音乐
  stop() async {
    final result = await audioPlayer.stop();
    if (result == 1) setState(() => playerState = PlayerState.stopped);
  }

  // 完成一首后，进入下一首
  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
    playLocal(nextSong.uri);
  }

  // 切换了正在播放的音乐事件
  void _switchMusic(Song clickedSong) async {
    playingSong = clickedSong;
    await stop();
    await playLocal(playingSong.uri);
  }

  void _hide() {
    bottomViewAnimationCtrl.forward();
  }

  void _show() {
    bottomViewAnimationCtrl.reverse();
  }

  // 监听ListView滚动事件
  bool _onNotification(Notification notification) {
    if (notification is ScrollUpdateNotification &&
        notification.depth == 0 &&
        playingSong != null) {
      var d = notification.dragDetails;
      if (d != null && d.delta != null) {
        var dy = d.delta.dy;
        if (dy > yoff) {
          // 手指向下滑动
          _show();
        } else if (dy < -yoff) {
          // 手指向上滑动
          _hide();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget home() {
      if (!_isLoading) {
        return new Scaffold(
          appBar: AppBar(
            title: Text('Music App [$songsLen/${currentSongIndex + 1}]'),
            actions: <Widget>[
              Switch(
                activeColor: Theme.of(context).primaryColorDark,
                activeTrackColor: Theme.of(context).primaryColorLight,
                value: isThemeDataDark,
                onChanged: (bool v) {
                  setState(() {
                    isThemeDataDark = v;
                  });
                },
              ),
            ],
          ),
          body: _songs.isEmpty
              ? EmptySongs()
              : Stack(
                  children: <Widget>[
                    NotificationListener(
                      onNotification: _onNotification,
                      child: ListView.builder(
                        itemCount: songsLen,
                        itemBuilder: (context, int index) {
                          Song tapSong = _songs[index];
                          return new ListTile(
                            leading: SongTitle(tapSong),
                            title: OverflowText(tapSong.title),
                            subtitle: OverflowText(tapSong.album),
                            onTap: () async {
                              currentSongIndex = index;

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
                                print('暂停');
                                // 在列表上点击你应该使用"stop()"而不是"pause()",因为stop会让song真正的结束。
                                if (tapSong == playingSong) {
                                  await pause();
                                } else {
                                  _switchMusic(tapSong);
                                }
                              } else {
                                // 播放
                                print('播放');
                                if (playingSong == null) {
                                  // 第一次进入直接播放点击歌曲
                                  playingSong = tapSong;
                                  await playLocal(playingSong.uri);
                                } else if (tapSong != playingSong) {
                                  // 在列表中点击了其他歌曲
                                  _switchMusic(tapSong);
                                } else if (tapSong == playingSong) {
                                  // 点击了同一首歌曲
                                  await playLocal(playingSong.uri);
                                }
                              }
                            },
                          );
                        },
                      ),
                    ),
                    PlayingSongView(
                      playingSong: playingSong,
                      playerState: playerState,
                      currentTime: position,
                      position: bottomViewAnimation,
                      pause: pause,
                      playLocal: playLocal,
                      slider: SongSlider(
                        value: position,
                        max: duration,
                        onChanged: (v) {},
                        onChangeEnd: (double v) {
                          audioPlayer.seek(v);
                        },
                      ),
                    ),
                  ],
                ),
        );
      } else {
        return PageLoading(
          body: Text('加载中...'),
        );
      }
    }

    return new MaterialApp(
      theme: isThemeDataDark ? ThemeData.dark() : ThemeData.light(),
      // theme: ThemeData(
      //   primaryColor: Colors.pink,
      //   primaryColorDark: Colors.pink[900],
      //   primaryColorLight: Colors.pinkAccent.shade100,
      //   accentColor: Colors.blue,
      // ),
      home: home(),
    );
  }
}
