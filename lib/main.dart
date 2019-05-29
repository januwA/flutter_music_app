import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/shared/widgets/empty_songs.dart';

import 'package:flutter_music/shared/widgets/song_title.dart';
import 'package:flutter_music/shared/widgets/page_loading.dart';
import 'package:flutter_music/shared/widgets/playing_song.dart';
import 'package:flutter_music/shared/widgets/overflow_text.dart';
import 'package:flutter_music/shared/widgets/song_slider.dart';
import 'package:flutter_music/src/song.service.dart';
import 'package:flutter_music/src/home.service.dart';

const int yoff = 3;

void main() {
  var homeService = HomeService();
  var songService = SongService();
  runApp(MyApp(
    homeService: homeService,
    songService: songService,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({
    this.homeService,
    this.songService,
  });
  final HomeService homeService;
  final SongService songService;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomeConfig>(
      stream: homeService.config,
      // initialData: HomeConfig(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return MaterialApp(
            home: PageLoading(
              body: CircularProgressIndicator(),
            ),
          );
        }
        final isDark = snapshot.data.isDark;
        return MaterialApp(
          theme: isDark ? ThemeData.dark() : ThemeData.light(),
          home: HomePage(
            homeService: homeService,
            songService: songService,
          ),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
    this.homeService,
    this.songService,
  }) : super(key: key);

  final SongService songService;
  final HomeService homeService;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<Offset> animation;
  AnimationController animationCtrl;

  @override
  void initState() {
    animationCtrl = new AnimationController(
      duration: const Duration(
        milliseconds: 600,
      ),
      vsync: this,
    );
    animation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 1), // y轴偏移量+height
    ).animate(animationCtrl);
    super.initState();
  }

  @override
  void dispose() {
    animationCtrl.dispose();
    widget.songService.dispose();
    widget.homeService.dispose();
    super.dispose();
  }

  /// 隐藏页面底部正在播放歌曲面板
  void _hide() {
    animationCtrl.forward();
  }

  /// 显示页面底部正在播放歌曲面板
  void _show() {
    animationCtrl.reverse();
  }

  /// 监听ListView滚动事件
  bool _onNotification(Notification notification) {
    if (notification is ScrollUpdateNotification &&
        notification.depth == 0 &&
        widget.songService.playingSong != null) {
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
        onTap: widget.songService.itemSongTap(song, index),
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
          onTap: widget.songService.itemSongTap(tapSong, index),
        );
      },
    );
  }

  /// 返回头部的actions
  List<Widget> appbarActions() {
    return [
      IconButton(
        onPressed: widget.homeService.setLayout,
        icon: Icon(widget.homeService.isGrid ? Icons.view_list : Icons.grid_on),
        color: Theme.of(context).primaryColorLight,
      ),
      Switch(
        activeColor: Theme.of(context).primaryColorDark,
        activeTrackColor: Theme.of(context).primaryColorLight,
        value: widget.homeService.isDark,
        onChanged: widget.homeService.setTheme,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Song>>(
      stream: widget.songService.songs,
      initialData: List<Song>(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return PageLoading(
            body: CircularProgressIndicator(),
          );
        }
        final List<Song> songs = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Music [${widget.songService.currentIndex + 1}/${widget.songService.songLength}]'),
            actions: <Widget>[
              ...appbarActions(),
            ],
          ),
          body: songs.isEmpty
              ? EmptySongs()
              : Stack(
                  children: <Widget>[
                    NotificationListener(
                      onNotification: _onNotification,
                      child: widget.homeService.isGrid
                          ? _homeGridView(songs)
                          : _homeListView(songs),
                      // Error:  Vertical viewport was given unbounded height.
                      // child: AnimatedCrossFade(
                      //   duration: Duration(milliseconds: 600),
                      //   firstChild: _homeGridView(songs),
                      //   secondChild: _homeListView(songs),
                      //   crossFadeState: widget.homeService.isGrid
                      //       ? CrossFadeState.showFirst
                      //       : CrossFadeState.showSecond,
                      // ),
                    ),
                    PlayingSongView(
                      playingSong: widget.songService.playingSong,
                      playerState: widget.songService.playerState,
                      currentTime: widget.songService.position,
                      position: animation,
                      pause: widget.songService.pause,
                      playLocal: widget.songService.playLocal,
                      slider: SongSlider(
                        value: widget.songService.position,
                        max: widget.songService.duration,
                        onChanged: (v) {},
                        onChangeEnd: widget.songService.seek,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
