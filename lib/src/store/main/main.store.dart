import 'package:flutter_music/src/store/song/song.service.dart';
import 'package:flutter_music/src/store/theme/theme.service.dart';
import 'package:mobx/mobx.dart';

part 'main.store.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  final ThemeService themeService = ThemeService();
  final SongService songService = SongService();
}

MainStore mainStore = MainStore();
