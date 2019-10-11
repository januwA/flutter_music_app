// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SongService on _SongService, Store {
  Computed<bool> _$isPlayingComputed;

  @override
  bool get isPlaying =>
      (_$isPlayingComputed ??= Computed<bool>(() => super.isPlaying)).value;
  Computed<int> _$songLengthComputed;

  @override
  int get songLength =>
      (_$songLengthComputed ??= Computed<int>(() => super.songLength)).value;

  final _$isLoadingAtom = Atom(name: '_SongService.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$songsAtom = Atom(name: '_SongService.songs');

  @override
  List<Song> get songs {
    _$songsAtom.context.enforceReadPolicy(_$songsAtom);
    _$songsAtom.reportObserved();
    return super.songs;
  }

  @override
  set songs(List<Song> value) {
    _$songsAtom.context.conditionallyRunInAction(() {
      super.songs = value;
      _$songsAtom.reportChanged();
    }, _$songsAtom, name: '${_$songsAtom.name}_set');
  }

  final _$currentIndexAtom = Atom(name: '_SongService.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.context.enforceReadPolicy(_$currentIndexAtom);
    _$currentIndexAtom.reportObserved();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.context.conditionallyRunInAction(() {
      super.currentIndex = value;
      _$currentIndexAtom.reportChanged();
    }, _$currentIndexAtom, name: '${_$currentIndexAtom.name}_set');
  }

  final _$playingSongAtom = Atom(name: '_SongService.playingSong');

  @override
  Song get playingSong {
    _$playingSongAtom.context.enforceReadPolicy(_$playingSongAtom);
    _$playingSongAtom.reportObserved();
    return super.playingSong;
  }

  @override
  set playingSong(Song value) {
    _$playingSongAtom.context.conditionallyRunInAction(() {
      super.playingSong = value;
      _$playingSongAtom.reportChanged();
    }, _$playingSongAtom, name: '${_$playingSongAtom.name}_set');
  }

  final _$playerStateAtom = Atom(name: '_SongService.playerState');

  @override
  PlayerState get playerState {
    _$playerStateAtom.context.enforceReadPolicy(_$playerStateAtom);
    _$playerStateAtom.reportObserved();
    return super.playerState;
  }

  @override
  set playerState(PlayerState value) {
    _$playerStateAtom.context.conditionallyRunInAction(() {
      super.playerState = value;
      _$playerStateAtom.reportChanged();
    }, _$playerStateAtom, name: '${_$playerStateAtom.name}_set');
  }

  final _$audioPlayerAtom = Atom(name: '_SongService.audioPlayer');

  @override
  MusicFinder get audioPlayer {
    _$audioPlayerAtom.context.enforceReadPolicy(_$audioPlayerAtom);
    _$audioPlayerAtom.reportObserved();
    return super.audioPlayer;
  }

  @override
  set audioPlayer(MusicFinder value) {
    _$audioPlayerAtom.context.conditionallyRunInAction(() {
      super.audioPlayer = value;
      _$audioPlayerAtom.reportChanged();
    }, _$audioPlayerAtom, name: '${_$audioPlayerAtom.name}_set');
  }

  final _$durationAtom = Atom(name: '_SongService.duration');

  @override
  Duration get duration {
    _$durationAtom.context.enforceReadPolicy(_$durationAtom);
    _$durationAtom.reportObserved();
    return super.duration;
  }

  @override
  set duration(Duration value) {
    _$durationAtom.context.conditionallyRunInAction(() {
      super.duration = value;
      _$durationAtom.reportChanged();
    }, _$durationAtom, name: '${_$durationAtom.name}_set');
  }

  final _$positionAtom = Atom(name: '_SongService.position');

  @override
  Duration get position {
    _$positionAtom.context.enforceReadPolicy(_$positionAtom);
    _$positionAtom.reportObserved();
    return super.position;
  }

  @override
  set position(Duration value) {
    _$positionAtom.context.conditionallyRunInAction(() {
      super.position = value;
      _$positionAtom.reportChanged();
    }, _$positionAtom, name: '${_$positionAtom.name}_set');
  }

  final _$_initAsyncAction = AsyncAction('_init');

  @override
  Future<void> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  final _$playAsyncAction = AsyncAction('play');

  @override
  Future<void> play(String songUrl) {
    return _$playAsyncAction.run(() => super.play(songUrl));
  }

  final _$playLocalAsyncAction = AsyncAction('playLocal');

  @override
  Future<void> playLocal(String songUrl) {
    return _$playLocalAsyncAction.run(() => super.playLocal(songUrl));
  }

  final _$pauseAsyncAction = AsyncAction('pause');

  @override
  Future<void> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  final _$stopAsyncAction = AsyncAction('stop');

  @override
  Future<void> stop() {
    return _$stopAsyncAction.run(() => super.stop());
  }

  final _$_SongServiceActionController = ActionController(name: '_SongService');

  @override
  Song nextSong() {
    final _$actionInfo = _$_SongServiceActionController.startAction();
    try {
      return super.nextSong();
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setDurationHandler(Duration d) {
    final _$actionInfo = _$_SongServiceActionController.startAction();
    try {
      return super._setDurationHandler(d);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setPositionHandler(Duration p) {
    final _$actionInfo = _$_SongServiceActionController.startAction();
    try {
      return super._setPositionHandler(p);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setCompletionHandler() {
    final _$actionInfo = _$_SongServiceActionController.startAction();
    try {
      return super._setCompletionHandler();
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setErrorHandler(String msg) {
    final _$actionInfo = _$_SongServiceActionController.startAction();
    try {
      return super._setErrorHandler(msg);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onComplete() {
    final _$actionInfo = _$_SongServiceActionController.startAction();
    try {
      return super.onComplete();
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  void seek(double v) {
    final _$actionInfo = _$_SongServiceActionController.startAction();
    try {
      return super.seek(v);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  void switchMusic(Song clickedSong) {
    final _$actionInfo = _$_SongServiceActionController.startAction();
    try {
      return super.switchMusic(clickedSong);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCurrentIndex(int v) {
    final _$actionInfo = _$_SongServiceActionController.startAction();
    try {
      return super.setCurrentIndex(v);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic itemSongTap(Song tapSong) {
    final _$actionInfo = _$_SongServiceActionController.startAction();
    try {
      return super.itemSongTap(tapSong);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }
}
