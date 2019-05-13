import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flute_music_player/flute_music_player.dart';

void main() => runApp(MyApp());
MusicFinder audioPlayer;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  List<Song> _songs = <Song>[]; // 本地音乐列表
  PlayerState playerState; // 播放状态
  Song playingSong; // 正在播放的音乐
  int currentSongIndex; // 正在播放音乐的index

  // 下一首歌
  Song get nextSong {
    currentSongIndex++;
    playingSong = _songs[currentSongIndex];
    Song ns = _songs[currentSongIndex % _songs.length];
    return ns;
  }

  bool _isLoading = true; // 是否在加载(songs)状态
  Duration duration;
  Duration position;
  Animation<Offset> bottomViewAnimation;
  AnimationController bottomViewAnimationCtrl;

  @override
  void initState() {
    super.initState();
    _initPlayer();
    _initBottomViewAnimation();
  }

  @override
  void dispose() {
    bottomViewAnimationCtrl.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    _initPlayer();
    _initBottomViewAnimation();
    super.reassemble();
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
              : Stack(
                  children: <Widget>[
                    NotificationListener(
                      onNotification: (notification) {
                        if (notification is ScrollUpdateNotification &&
                            notification.depth == 0) {
                          var d = notification.dragDetails;
                          if (d != null && d.delta != null) {
                            int yoff = 3;
                            var dy = d.delta.dy;
                            if (dy > yoff) {
                              // 向下滑动
                              bottomViewAnimationCtrl.reverse();
                            } else if (dy < -yoff) {
                              // 向上滑动
                              bottomViewAnimationCtrl.forward();
                            }
                          }
                        }
                      },
                      child: ListView.builder(
                        itemCount: _songs.length,
                        itemBuilder: (context, int index) {
                          Song tapSong = _songs[index];
                          return new ListTile(
                            leading: fileImage(
                              tapSong.albumArt == null
                                  ? Text(tapSong.title[0])
                                  : tapSong.albumArt,
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
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: playingSong != null
                          ? SlideTransition(
                              position: bottomViewAnimation,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: ListTile(
                                  dense: true, // 稍微小点
                                  leading: fileImage(
                                    playingSong.albumArt == null
                                        ? Text(playingSong.title[0])
                                        : playingSong.albumArt,
                                  ),
                                  title: Text(
                                    playingSong.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    playingSong.album,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      playerState != PlayerState.playing
                                          ? Icons.play_arrow
                                          : Icons.pause,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () async {
                                      if (playerState == PlayerState.playing) {
                                        await pause();
                                      } else {
                                        await playLocal(playingSong.uri);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ],
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

    var show = true;
    return new MaterialApp(
      home: home(),
      // home: Scaffold(
      //   body: ListView(
      //     children: <Widget>[
      //       FlatButton(
      //         onPressed: () {
      //           show = !show;
      //           if (show) {
      //             controller.reverse();
      //           } else {
      //             controller.forward();
      //           }
      //         },
      //         child: Text('click'),
      //       ),
      //       SlideTransition(
      //         position: Tween<Offset>(
      //           begin: Offset(0, 1),
      //           end: Offset(0, 2),
      //         ).animate(controller),
      //         child: Container(
      //           height: 200,
      //           decoration: BoxDecoration(
      //             color: Colors.green,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

// 音乐播放状态
enum PlayerState {
  playing,
  paused,
  stopped,
}

// 返回一个本地的image
fileImage(
  path, {
  BoxFit fit = BoxFit.cover,
  FilterQuality filterQuality: FilterQuality.low,
}) {
  return CircleAvatar(
    child: path is Widget
        ? path
        : new Image.file(
            new File.fromUri(
              Uri.parse(path),
            ),
            fit: fit,
            filterQuality: filterQuality,
          ),
  );
}
