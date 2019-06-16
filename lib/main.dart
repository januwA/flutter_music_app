import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_music/src/pages/home_page/home_page.dart';
import 'package:flutter_music/src/shared/stores/global_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      key: ValueKey('globalStore'),
      builder: (context) => MaterialApp(
            theme: globalStore.isDark
                ? ThemeData.dark()
                : ThemeData.light()
                    .copyWith(primaryColor: Colors.pinkAccent[400]),
            home: HomePage(),
          ),
    );
  }
}
