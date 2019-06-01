import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeState {
  Dark,
  Light,
}

class AppConfig {
  AppConfig({
    this.isDark = AppThemeState.Dark,
  });
  AppThemeState isDark;
}

class AppService {
  Stream<AppConfig> get appConfig$ => _configSubject.stream;
  SharedPreferences _prefs;
  var _configSubject = BehaviorSubject<AppConfig>();
  var _config = AppConfig();
  bool get isDark => _config.isDark == AppThemeState.Dark;

  AppService() {
    _initConfig().then((_) {
      _configSubject.add(_config);
    });
  }

  void dispose() {
    _configSubject.close();
  }

  /// 初始化config
  Future<Null> _initConfig() async {
    _prefs = await SharedPreferences.getInstance();
    bool isDark = _prefs.getBool('isDark') ?? _config.isDark;
    _config..isDark = isDark ? AppThemeState.Dark : AppThemeState.Light;
  }

  /// 设置主题
  setTheme(AppThemeState v) {
    _prefs.setBool('isDark', v == AppThemeState.Dark);
    _config..isDark = v;
    _configSubject.add(_config);
  }
}

AppService appService = AppService();
