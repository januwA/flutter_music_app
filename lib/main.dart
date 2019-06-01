import 'package:flutter/material.dart';
import 'package:flutter_music/pages/home_page/home_page.dart';
import 'package:flutter_music/shared/app.service.dart';
import 'package:flutter_music/shared/widgets/page_loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      stream: appService.appConfig$,
      builder: (context, r) {
        if (r.connectionState == ConnectionState.waiting || !r.hasData)
          return appLoading();
        return MaterialApp(
          theme: appService.isDark ? ThemeData.dark() : ThemeData.light(),
          home: HomePage(),
        );
      },
    );
  }
}
