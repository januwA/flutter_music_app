// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SongService on _SongService, Store {
  late final _$isLoadingAtom =
      Atom(name: '_SongService.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$songsAtom = Atom(name: '_SongService.songs', context: context);

  @override
  List<SongModel> get songs {
    _$songsAtom.reportRead();
    return super.songs;
  }

  @override
  set songs(List<SongModel> value) {
    _$songsAtom.reportWrite(value, super.songs, () {
      super.songs = value;
    });
  }

  late final _$isPlayingAtom =
      Atom(name: '_SongService.isPlaying', context: context);

  @override
  bool get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  late final _$playingSongAtom =
      Atom(name: '_SongService.playingSong', context: context);

  @override
  SongModel? get playingSong {
    _$playingSongAtom.reportRead();
    return super.playingSong;
  }

  @override
  set playingSong(SongModel? value) {
    _$playingSongAtom.reportWrite(value, super.playingSong, () {
      super.playingSong = value;
    });
  }

  late final _$durationAtom =
      Atom(name: '_SongService.duration', context: context);

  @override
  Duration get duration {
    _$durationAtom.reportRead();
    return super.duration;
  }

  @override
  set duration(Duration value) {
    _$durationAtom.reportWrite(value, super.duration, () {
      super.duration = value;
    });
  }

  late final _$positionAtom =
      Atom(name: '_SongService.position', context: context);

  @override
  Duration get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(Duration value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$_initAsyncAction =
      AsyncAction('_SongService._init', context: context);

  @override
  Future<void> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  late final _$itemSongTapAsyncAction =
      AsyncAction('_SongService.itemSongTap', context: context);

  @override
  Future itemSongTap(SongModel it) {
    return _$itemSongTapAsyncAction.run(() => super.itemSongTap(it));
  }

  late final _$playAsyncAction =
      AsyncAction('_SongService.play', context: context);

  @override
  Future<void> play() {
    return _$playAsyncAction.run(() => super.play());
  }

  late final _$pauseAsyncAction =
      AsyncAction('_SongService.pause', context: context);

  @override
  Future<void> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  late final _$_SongServiceActionController =
      ActionController(name: '_SongService', context: context);

  @override
  void _setDurationHandler(Duration d) {
    final _$actionInfo = _$_SongServiceActionController.startAction(
        name: '_SongService._setDurationHandler');
    try {
      return super._setDurationHandler(d);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setPositionHandler(Duration p) {
    final _$actionInfo = _$_SongServiceActionController.startAction(
        name: '_SongService._setPositionHandler');
    try {
      return super._setPositionHandler(p);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  @override
  void seek(Duration v) {
    final _$actionInfo =
        _$_SongServiceActionController.startAction(name: '_SongService.seek');
    try {
      return super.seek(v);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
songs: ${songs},
isPlaying: ${isPlaying},
playingSong: ${playingSong},
duration: ${duration},
position: ${position}
    ''';
  }
}
