import 'package:flutter/material.dart';
import 'package:flutter_music/pages/home-page.dart';
import 'package:flutter_music/shared/widgets/page_loading.dart';
import 'package:flutter_music/src/app.service.dart';
import 'package:flutter_music/src/song.service.dart';
import 'package:flutter_music/src/home.service.dart';

void main() {
  var homeService = HomeService();
  var songService = SongService();
  var appService = AppService();
  runApp(MyApp(
    homeService: homeService,
    songService: songService,
    appService: appService,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({
    this.homeService,
    this.songService,
    this.appService,
  });
  final HomeService homeService;
  final SongService songService;
  final AppService appService;

  Widget appLoading() {
    return MaterialApp(
      home: PageLoading(
        body: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppConfig>(
      stream: appService.config,
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
            appService: appService,
          ),
        );
      },
    );
  }
}
