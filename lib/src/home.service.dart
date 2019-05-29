import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeConfig {
  HomeConfig({
    this.isDark = false,
    this.isGrid = false,
  });
  bool isDark;
  bool isGrid;
}

class HomeService {
  Stream<HomeConfig> get config => _configSubject.stream;
  final _configSubject = BehaviorSubject<HomeConfig>();
  var _config = HomeConfig();
  SharedPreferences _prefs;

  bool get isDark => _config.isDark;
  bool get isGrid => _config.isGrid;

  HomeService() {
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
    bool isGrid = _prefs.getBool('isGrid') ?? _config.isGrid;
    bool isDark = _prefs.getBool('isDark') ?? _config.isDark;
    _config
      ..isGrid = isGrid
      ..isDark = isDark;
  }

  /// 设置页面布局
  ///
  /// trues是Grid,false是List
  setLayout() {
    _prefs.setBool('isGrid', !isGrid);
    _config.isGrid = !isGrid;
    _configSubject.add(_config);
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
