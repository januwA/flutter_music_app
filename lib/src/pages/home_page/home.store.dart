import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'home.store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    _init();
  }
  @observable
  SharedPreferences? _prefs;

  ///
  @observable
  bool isGrid = false;

  @action
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    isGrid = _prefs!.getBool('isGrid') ?? false;
  }

  /// 设置页面布局
  @action
  void setLayout() {
    _prefs?.setBool('isGrid', !isGrid);
    isGrid = !isGrid;
  }
}
