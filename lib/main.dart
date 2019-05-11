import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

void main() => runApp(MyApp());
MusicFinder audioPlayer;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Song> _songs = <Song>[]; // 本地音乐列表
  PlayerState playerState; // 播放状态
  Song playingSong; // 正在播放的音乐
  int currentSongIndex; // 正在播放音乐的index

  // 下一首歌
  Song get nextSong {
    currentSongIndex++;
    Song ns = _songs[currentSongIndex % _songs.length];
    return ns;
  }

  bool _isLoading = true; // 是否在加载(songs)状态
  Duration duration;
  Duration position;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    _isLoading = true;
    var songs = await MusicFinder.allSongs();
    setState(() {
      _songs = songs;
      _isLoading = false;
    });

    audioPlayer ??= new MusicFinder();
    audioPlayer.setDurationHandler((Duration d) => setState(() {
          // 持续时间
          duration = d;
        }));

    audioPlayer.setPositionHandler((Duration p) => setState(() {
          // 位置
          position = p;
        }));

    audioPlayer.setCompletionHandler(() {
      // 完成时
      onComplete();
      setState(() {
        position = duration;
      });
    });
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

  @override
  Widget build(BuildContext context) {
    Widget home() {
      if (!_isLoading) {
        return new Scaffold(
          appBar: AppBar(
            title: Text('Music App'),
          ),
          body: _songs.isEmpty
              ? Center(
                  child: Text(
                    '没有找到本地音乐 >_<',
                    style: TextStyle(fontSize: 24),
                  ),
                )
              : ListView.builder(
                  itemCount: _songs.length,
                  itemBuilder: (context, int index) {
                    Song tapSong = _songs[index];
                    return new ListTile(
                      leading: CircleAvatar(
                        // 没有专辑图片就用文字代替
                        child: tapSong.albumArt == null
                            ? Text(tapSong.title[0])
                            : new Image.file(
                                new File.fromUri(
                                  Uri.parse(tapSong.albumArt),
                                ),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low,
                              ),
                      ),
                      title: Text(tapSong.title),
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

                        if (playerState == PlayerState.playing) {
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
        );
      } else {
        return Scaffold(
          body: Center(
            child: Text('loading...'),
          ),
        );
      }
    }

    return new MaterialApp(
      home: home(),
    );
  }
}

enum PlayerState {
  playing,
  paused,
  stopped,
}
