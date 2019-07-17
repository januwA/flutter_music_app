import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_music/src/pages/home_page/home_page.dart';
import 'package:flutter_music/src/store/main/main.store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        theme: mainStore.themeService.theme,
        home: HomePage(),
      ),
    );
  }
}
