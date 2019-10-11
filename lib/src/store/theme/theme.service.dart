import 'package:flutter/material.dart';
import 'package:flutter_music/src/theme/dark_theme.dart';
import 'package:flutter_music/src/theme/pink_theme.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme.service.g.dart';

class ThemeService = _ThemeService with _$ThemeService;

abstract class _ThemeService with Store {
  _ThemeService() {
    _init();
  }

  @action
  Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
    isDark = _prefs.getBool('isDark') ?? false;
  }

  @observable
  bool isDark = false;

  @computed
  ThemeData get theme => isDark ? darkTheme : pinkTheme;

  @observable
  SharedPreferences _prefs;

  @action
  void setTheme(bool v) {
    isDark = v;
    _prefs.setBool('isDark', isDark);
  }
}
