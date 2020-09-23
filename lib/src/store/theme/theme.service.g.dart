// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThemeService on _ThemeService, Store {
  Computed<ThemeData> _$themeComputed;

  @override
  ThemeData get theme => (_$themeComputed ??=
          Computed<ThemeData>(() => super.theme, name: '_ThemeService.theme'))
      .value;

  final _$isDarkAtom = Atom(name: '_ThemeService.isDark');

  @override
  bool get isDark {
    _$isDarkAtom.reportRead();
    return super.isDark;
  }

  @override
  set isDark(bool value) {
    _$isDarkAtom.reportWrite(value, super.isDark, () {
      super.isDark = value;
    });
  }

  final _$_prefsAtom = Atom(name: '_ThemeService._prefs');

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

  final _$_initAsyncAction = AsyncAction('_ThemeService._init');

  @override
  Future<void> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  final _$_ThemeServiceActionController =
      ActionController(name: '_ThemeService');

  @override
  void setTheme(bool v) {
    final _$actionInfo = _$_ThemeServiceActionController.startAction(
        name: '_ThemeService.setTheme');
    try {
      return super.setTheme(v);
    } finally {
      _$_ThemeServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDark: ${isDark},
theme: ${theme}
    ''';
  }
}
