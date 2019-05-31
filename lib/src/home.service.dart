/// 只用来控制homePage

import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeConfig {
  HomeConfig({
    this.isGrid = false,
  });
  bool isGrid;
}

class HomeService {
  Stream<HomeConfig> get config => _configSubject.stream;
  final _configSubject = BehaviorSubject<HomeConfig>();
  var _config = HomeConfig();
  SharedPreferences _prefs;

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
    _config..isGrid = isGrid;
  }

  /// 设置页面布局
  ///
  /// trues是Grid,false是List
  setLayout() {
    _prefs.setBool('isGrid', !isGrid);
    _config.isGrid = !isGrid;
    _configSubject.add(_config);
  }
}
