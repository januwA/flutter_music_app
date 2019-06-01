
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

class SearchPage extends SearchDelegate<String> {
  Stream<List<Song>> songs;
  String select;
  var onTap;

  SearchPage(this.songs, this.onTap);

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
    return StreamBuilder<List<Song>>(
      stream: songs,
      initialData: List<Song>(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data!'),
          );
        }

        var filterSons =
            snapshot.data.where((Song s) => s.title.contains(query.trim()));
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
                  onTap(s, snapshot.data.indexOf(s))();
                  close(context, null);
                },
              ),
          ],
        );
      },
    );
  }

  /// 当用户在搜索字段中键入查询时，在搜索页面正文中显示的建议
  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Song>>(
      stream: songs,
      initialData: List<Song>(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data!'),
          );
        }

        var filterSons =
            snapshot.data.where((Song s) => s.title.contains(query.trim()));
        return ListView(
          children: <Widget>[
            for (Song s in filterSons)
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text(s.title),
                onTap: () {
                  onTap(s, snapshot.data.indexOf(s))();
                  close(context, null);
                },
              ),
          ],
        );
      },
    );
  }
}