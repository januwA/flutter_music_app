import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/src/shared/widgets/overflow_text.dart';
import 'package:flutter_music/src/shared/widgets/song_title.dart';
import 'package:flutter_music/src/store/main/main.store.dart';

class SearchPage extends SearchDelegate<String> {

  SearchPage() : super(
    searchFieldLabel: "Enter Song Name."
  );
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
    var filterSons = mainStore.songService.songs
        .where((Song s) => s.title.contains(query.trim()))
        .toList();
    return _buildListView(filterSons, context);
  }

  /// 当用户在搜索字段中键入查询时，在搜索页面正文中显示的建议
  @override
  Widget buildSuggestions(BuildContext context) {
    var filterSons = mainStore.songService.songs
        .where((Song s) => s.title.contains(query.trim()))
        .toList();
    return _buildListView(filterSons, context);
  }

  ListView _buildListView(List<Song> filterSons, BuildContext context) {
    return ListView.builder(
      itemCount: filterSons.length,
      itemBuilder: (context, index) {
        final s = filterSons[index];
        return ListTile(
          leading: SongTitle(s),
          title: OverflowText(s.title),
          subtitle: OverflowText(s.album),
          onTap: () {
            mainStore.songService.itemSongTap(s);
            close(context, null);
          },
        );
      },
    );
  }
}
