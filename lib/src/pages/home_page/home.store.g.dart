// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$_prefsAtom = Atom(name: '_HomeStore._prefs');

  @override
  SharedPreferences get _prefs {
    _$_prefsAtom.reportRead();
    return super._prefs;
  }

  @override
  set _prefs(SharedPreferences value) {
    _$_prefsAtom.reportWrite(value, super._prefs, () {
      super._prefs = value;
    });
  }

  final _$isGridAtom = Atom(name: '_HomeStore.isGrid');

  @override
  bool get isGrid {
    _$isGridAtom.reportRead();
    return super.isGrid;
  }

  @override
  set isGrid(bool value) {
    _$isGridAtom.reportWrite(value, super.isGrid, () {
      super.isGrid = value;
    });
  }

  final _$_initAsyncAction = AsyncAction('_HomeStore._init');

  @override
  Future<void> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void setLayout() {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.setLayout');
    try {
      return super.setLayout();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isGrid: ${isGrid}
    ''';
  }
}
