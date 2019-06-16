import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/src/shared/stores/song_store.dart';

class SearchPage extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  /// 用户从搜索页面提交搜索后显示的结果
  @override
  Widget buildResults(BuildContext context) {
    var filterSons =
        songStore.songs.where((Song s) => s.title.contains(query.trim()));
    return ListView(
      children: <Widget>[
        for (Song s in filterSons)
          ListTile(
            leading: Icon(
              Icons.music_note,
              color: Colors.red,
            ),
            title: Text(s.title),
            onTap: () {
              songStore.itemSongTap(s);
              close(context, null);
            },
          ),
      ],
    );
  }

  /// 当用户在搜索字段中键入查询时，在搜索页面正文中显示的建议
  @override
  Widget buildSuggestions(BuildContext context) {
    var filterSons =
        songStore.songs.where((Song s) => s.title.contains(query.trim()));
    return ListView(
      children: <Widget>[
        for (Song s in filterSons)
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text(s.title),
            onTap: () {
              songStore.itemSongTap(s);
              close(context, null);
            },
          ),
      ],
    );
  }
}
