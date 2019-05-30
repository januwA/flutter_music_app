import 'package:flutter/material.dart';
import 'package:flutter_music/pages/home-page.dart';
import 'package:flutter_music/shared/widgets/page_loading.dart';
import 'package:flutter_music/src/song.service.dart';
import 'package:flutter_music/src/home.service.dart';

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

  Widget appLoading() {
    return MaterialApp(
      home: PageLoading(
        body: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomeConfig>(
      stream: homeService.config,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return appLoading();
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
