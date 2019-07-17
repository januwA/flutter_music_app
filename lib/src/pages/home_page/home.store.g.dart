// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$HomeStore on _HomeStore, Store {
  Computed<String> _$homeTitleComputed;

  @override
  String get homeTitle =>
      (_$homeTitleComputed ??= Computed<String>(() => super.homeTitle)).value;

  final _$_prefsAtom = Atom(name: '_HomeStore._prefs');

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

  final _$isGridAtom = Atom(name: '_HomeStore.isGrid');

  @override
  bool get isGrid {
    _$isGridAtom.reportObserved();
    return super.isGrid;
  }

  @override
  set isGrid(bool value) {
    _$isGridAtom.context.checkIfStateModificationsAreAllowed(_$isGridAtom);
    super.isGrid = value;
    _$isGridAtom.reportChanged();
  }

  final _$_initAsyncAction = AsyncAction('_init');

  @override
  Future<void> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void setLayout() {
    final _$actionInfo = _$_HomeStoreActionController.startAction();
    try {
      return super.setLayout();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }
}
