import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'global_store.g.dart';

class GlobalStore = _GlobalStore with _$GlobalStore;

abstract class _GlobalStore with Store {
  _GlobalStore() {
    _init();
  }
  @observable
  bool isDark = false;

  @observable
  SharedPreferences _prefs;

  @action
  setTheme(bool v) {
    _prefs.setBool('isDark', v);
    isDark = v;
  }

  @action
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    isDark = _prefs.getBool('isDark') ?? false;
  }
}

final globalStore = GlobalStore();
