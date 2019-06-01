import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum HomeLayoutState {
  list,
  grid,
}

class HomeConfig {
  HomeConfig({
    this.layout = HomeLayoutState.list,
  });
  HomeLayoutState layout;
}

class HomeService {
  Stream<HomeConfig> get config$ => _configSubject.stream;
  final _configSubject = BehaviorSubject<HomeConfig>();
  HomeConfig _config = HomeConfig();
  SharedPreferences _prefs;
  bool get isGrid => _config.layout == HomeLayoutState.grid;

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
    bool isGrid = _prefs.getBool('isGrid') ?? false;
    _config.layout = isGrid ? HomeLayoutState.grid : HomeLayoutState.list;
  }

  /// 设置页面布局
  setLayout(HomeLayoutState v) {
    _prefs.setBool('isGrid', v == HomeLayoutState.grid);
    _config.layout = v;
    _configSubject.add(_config);
  }
}

HomeService homeService = HomeService();
