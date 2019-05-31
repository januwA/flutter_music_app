/// 这个service文件，用来控制整个app的状态，ui控制


import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  AppConfig({
    this.isDark = false,
  });
  bool isDark;
}

class AppService {
  Stream<AppConfig> get config => _configSubject.stream;
  final _configSubject = BehaviorSubject<AppConfig>();
  var _config = AppConfig();
  SharedPreferences _prefs;

  bool get isDark => _config.isDark;

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
    _config..isDark = isDark;
  }

  /// 设置主题
  ///
  /// true为dark,false为loght
  setTheme(bool v) {
    _prefs.setBool('isDark', v);
    _config.isDark = v;
    _configSubject.add(_config);
  }
}
