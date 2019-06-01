import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/pages/home_page/home.service.dart';
import 'package:flutter_music/pages/home_page/home_drawer.dart';
import 'package:flutter_music/pages/home_page/serarch_page.dart';
import 'package:flutter_music/shared/widgets/empty_songs.dart';
import 'package:flutter_music/shared/widgets/song_title.dart';
import 'package:flutter_music/shared/widgets/page_loading.dart';
import 'package:flutter_music/shared/widgets/playing_song.dart';
import 'package:flutter_music/shared/widgets/overflow_text.dart';
import 'package:flutter_music/shared/widgets/song_slider.dart';
import 'package:flutter_music/shared/song.service.dart';

const int yoff = 3;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _animation;
  AnimationController _animationCtrl;

  @override
  void initState() {
    _animationCtrl = new AnimationController(
      duration: const Duration(
        milliseconds: 200,
      ),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 1), // y轴偏移量+height
    ).animate(_animationCtrl);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 隐藏页面底部正在播放歌曲面板
  void _hide() {
    _animationCtrl.forward();
  }

  /// 显示页面底部正在播放歌曲面板
  void _show() {
    _animationCtrl.reverse();
  }

  /// 监听ListView滚动事件
  bool _onNotification(Notification notification) {
    if (notification is ScrollUpdateNotification &&
        notification.depth == 0 &&
        songService.playingSong != null) {
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
      return true;
    }
    return false;
  }

  /// Grid布局的每个item
  Widget _gridItemSong(Song song, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: songService.itemSongTap(song, index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SongTitle.grid(
              song,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 95,
            ),
            ListTile(
              title: OverflowText(song.title),
              subtitle: OverflowText(song.album),
            )
          ],
        ),
      ),
    );
  }

  Widget _homeGridView(List<Song> songs) {
    return GridView.count(
      crossAxisSpacing: 10.0,
      crossAxisCount: 2,
      children: <Widget>[
        for (Song song in songs) _gridItemSong(song, songs.indexOf(song)),
      ],
    );
  }

  Widget _homeListView(List<Song> songs) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(
            indent: 8.0,
          ),
      itemCount: songs.length,
      itemBuilder: (context, int index) {
        Song tapSong = songs[index];
        return new ListTile(
          dense: true,
          leading: SongTitle(tapSong),
          title: OverflowText(tapSong.title),
          subtitle: OverflowText(tapSong.album),
          onTap: songService.itemSongTap(tapSong, index),
        );
      },
    );
  }

  /// 返回头部的actions
  List<Widget> _appbarActions() {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch<String>(
            context: context,
            delegate: SearchPage(songService.songs$, songService.itemSongTap),
          );
        },
      ),
    ];
  }

  Widget _loadingSongs() {
    return PageLoading(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text('加载本地歌曲信息中...'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Song>>(
      stream: songService.songs$,
      builder: (context, r) {
        if (r.connectionState == ConnectionState.waiting || !r.hasData) {
          return _loadingSongs();
        }
        List<Song> songs = r.data;
        String title =
            'Music [${songService.currentIndex + 1}/${songService.songLength}]';
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: _appbarActions(),
          ),
          drawer: HomeDrawer(),
          body: songs.isEmpty
              ? EmptySongs()
              : Stack(
                  children: <Widget>[
                    StreamBuilder<HomeConfig>(
                      stream: homeService.config$,
                      builder: (context, rr) {
                        if (rr.connectionState == ConnectionState.waiting ||
                            !rr.hasData) {
                          return Container();
                        }
                        return NotificationListener(
                          onNotification: _onNotification,
                          child: rr.data.layout == HomeLayoutState.grid
                              ? _homeGridView(songs)
                              : _homeListView(songs),
                        );
                      },
                    ),
                    PlayingSongView(
                      playingSong: songService.playingSong,
                      playerState: songService.playerState,
                      currentTime: songService.position,
                      position: _animation,
                      pause: songService.pause,
                      playLocal: songService.playLocal,
                      slider: SongSlider(
                        value: songService.position,
                        max: songService.duration,
                        onChangeEnd: songService.seek,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
