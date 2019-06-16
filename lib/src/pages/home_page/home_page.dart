import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_music/src/pages/home_page/home_store.dart';
import 'package:flutter_music/src/pages/home_page/serarch_page.dart';
import 'package:flutter_music/src/pages/home_page/song_grid.dart';
import 'package:flutter_music/src/pages/home_page/song_list.dart';
import 'package:flutter_music/src/shared/stores/global_store.dart';
import 'package:flutter_music/src/shared/stores/song_store.dart';
import 'package:flutter_music/src/shared/widgets/empty_songs.dart';
import 'package:flutter_music/src/shared/widgets/playing_song.dart';

const int yoff = 3;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final homeStore = HomeStore();
  Animation<Offset> _position;
  AnimationController _positionC;

  @override
  void initState() {
    super.initState();
    _positionC = new AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _position = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 1), // y轴偏移量+height
    ).animate(_positionC);
  }

  @override
  void dispose() {
    _positionC?.dispose();
    super.dispose();
  }

  /// 隐藏页面底部正在播放歌曲面板
  void _hide() {
    _positionC.forward();
  }

  /// 显示页面底部正在播放歌曲面板
  void _show() {
    _positionC.reverse();
  }

  /// 监听ListView滚动事件
  bool _onNotification(Notification notification) {
    if (notification is ScrollUpdateNotification &&
        notification.depth == 0 &&
        songStore.playingSong != null) {
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

  /// 返回头部的actions
  List<Widget> _appbarActions() {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch<String>(
            context: context,
            delegate: SearchPage(),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (songStore.isLoading) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Loading...'),
              ),
              body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          drawer: _buildDrawer(),
          body: Stack(
            children: <Widget>[
              NotificationListener(
                onNotification: _onNotification,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text(homeStore.homeTitle),
                      actions: _appbarActions(),
                      floating: true,
                    ),
                    songStore.songs.isEmpty
                        ? SliverToBoxAdapter(
                            child: EmptySongs(),
                          )
                        : homeStore.isGrid ? SongGrid() : SongList(),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SlideTransition(
                  position: _position,
                  child: PlayingSongView(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 70,
            child: DrawerHeader(
              child: Center(child: Text('设置列表')),
            ),
          ),
          ListTile(
            leading: Text(globalStore.isDark ? 'dark theme' : "light theme"),
            trailing: Switch(
              value: globalStore.isDark,
              onChanged: globalStore.setTheme,
            ),
          ),
          Divider(),
          ListTile(
            leading: Text(homeStore.isGrid ? 'grid layout' : 'list layout'),
            trailing: IconButton(
              onPressed: homeStore.setLayout,
              icon: Icon(homeStore.isGrid ? Icons.grid_on : Icons.view_list),
            ),
          ),
        ],
      ),
    );
  }
}
