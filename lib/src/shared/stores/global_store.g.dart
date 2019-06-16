// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$GlobalStore on _GlobalStore, Store {
  final _$isDarkAtom = Atom(name: '_GlobalStore.isDark');

  @override
  bool get isDark {
    _$isDarkAtom.reportObserved();
    return super.isDark;
  }

  @override
  set isDark(bool value) {
    _$isDarkAtom.context.checkIfStateModificationsAreAllowed(_$isDarkAtom);
    super.isDark = value;
    _$isDarkAtom.reportChanged();
  }

  final _$_prefsAtom = Atom(name: '_GlobalStore._prefs');

  @override
  SharedPreferences get _prefs {
    _$_prefsAtom.reportObserved();
    return super._prefs;
  }

  @override
  set _prefs(SharedPreferences value) {
    _$_prefsAtom.context.checkIfStateModificationsAreAllowed(_$_prefsAtom);
    super._prefs = value;
    _$_prefsAtom.reportChanged();
  }

  final _$_initAsyncAction = AsyncAction('_init');

  @override
  Future<void> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  final _$_GlobalStoreActionController = ActionController(name: '_GlobalStore');

  @override
  dynamic setTheme(bool v) {
    final _$actionInfo = _$_GlobalStoreActionController.startAction();
    try {
      return super.setTheme(v);
    } finally {
      _$_GlobalStoreActionController.endAction(_$actionInfo);
    }
  }
}
