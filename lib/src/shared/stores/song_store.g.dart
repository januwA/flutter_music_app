// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$SongStore on _SongStore, Store {
  Computed<bool> _$isPlayingComputed;

  @override
  bool get isPlaying =>
      (_$isPlayingComputed ??= Computed<bool>(() => super.isPlaying)).value;
  Computed<int> _$songLengthComputed;

  @override
  int get songLength =>
      (_$songLengthComputed ??= Computed<int>(() => super.songLength)).value;

  final _$isLoadingAtom = Atom(name: '_SongStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context
        .checkIfStateModificationsAreAllowed(_$isLoadingAtom);
    super.isLoading = value;
    _$isLoadingAtom.reportChanged();
  }

  final _$songsAtom = Atom(name: '_SongStore.songs');

  @override
  List<Song> get songs {
    _$songsAtom.reportObserved();
    return super.songs;
  }

  @override
  set songs(List<Song> value) {
    _$songsAtom.context.checkIfStateModificationsAreAllowed(_$songsAtom);
    super.songs = value;
    _$songsAtom.reportChanged();
  }

  final _$currentIndexAtom = Atom(name: '_SongStore.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportObserved();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.context
        .checkIfStateModificationsAreAllowed(_$currentIndexAtom);
    super.currentIndex = value;
    _$currentIndexAtom.reportChanged();
  }

  final _$playingSongAtom = Atom(name: '_SongStore.playingSong');

  @override
  Song get playingSong {
    _$playingSongAtom.reportObserved();
    return super.playingSong;
  }

  @override
  set playingSong(Song value) {
    _$playingSongAtom.context
        .checkIfStateModificationsAreAllowed(_$playingSongAtom);
    super.playingSong = value;
    _$playingSongAtom.reportChanged();
  }

  final _$playerStateAtom = Atom(name: '_SongStore.playerState');

  @override
  PlayerState get playerState {
    _$playerStateAtom.reportObserved();
    return super.playerState;
  }

  @override
  set playerState(PlayerState value) {
    _$playerStateAtom.context
        .checkIfStateModificationsAreAllowed(_$playerStateAtom);
    super.playerState = value;
    _$playerStateAtom.reportChanged();
  }

  final _$audioPlayerAtom = Atom(name: '_SongStore.audioPlayer');

  @override
  MusicFinder get audioPlayer {
    _$audioPlayerAtom.reportObserved();
    return super.audioPlayer;
  }

  @override
  set audioPlayer(MusicFinder value) {
    _$audioPlayerAtom.context
        .checkIfStateModificationsAreAllowed(_$audioPlayerAtom);
    super.audioPlayer = value;
    _$audioPlayerAtom.reportChanged();
  }

  final _$durationAtom = Atom(name: '_SongStore.duration');

  @override
  Duration get duration {
    _$durationAtom.reportObserved();
    return super.duration;
  }

  @override
  set duration(Duration value) {
    _$durationAtom.context.checkIfStateModificationsAreAllowed(_$durationAtom);
    super.duration = value;
    _$durationAtom.reportChanged();
  }

  final _$positionAtom = Atom(name: '_SongStore.position');

  @override
  Duration get position {
    _$positionAtom.reportObserved();
    return super.position;
  }

  @override
  set position(Duration value) {
    _$positionAtom.context.checkIfStateModificationsAreAllowed(_$positionAtom);
    super.position = value;
    _$positionAtom.reportChanged();
  }

  final _$_initPlayerAsyncAction = AsyncAction('_initPlayer');

  @override
  Future<void> _initPlayer() {
    return _$_initPlayerAsyncAction.run(() => super._initPlayer());
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

  final _$_SongStoreActionController = ActionController(name: '_SongStore');

  @override
  Song nextSong() {
    final _$actionInfo = _$_SongStoreActionController.startAction();
    try {
      return super.nextSong();
    } finally {
      _$_SongStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setDurationHandler(Duration d) {
    final _$actionInfo = _$_SongStoreActionController.startAction();
    try {
      return super._setDurationHandler(d);
    } finally {
      _$_SongStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setPositionHandler(Duration p) {
    final _$actionInfo = _$_SongStoreActionController.startAction();
    try {
      return super._setPositionHandler(p);
    } finally {
      _$_SongStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setCompletionHandler() {
    final _$actionInfo = _$_SongStoreActionController.startAction();
    try {
      return super._setCompletionHandler();
    } finally {
      _$_SongStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setErrorHandler(String msg) {
    final _$actionInfo = _$_SongStoreActionController.startAction();
    try {
      return super._setErrorHandler(msg);
    } finally {
      _$_SongStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onComplete() {
    final _$actionInfo = _$_SongStoreActionController.startAction();
    try {
      return super.onComplete();
    } finally {
      _$_SongStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void seek(double v) {
    final _$actionInfo = _$_SongStoreActionController.startAction();
    try {
      return super.seek(v);
    } finally {
      _$_SongStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void switchMusic(Song clickedSong) {
    final _$actionInfo = _$_SongStoreActionController.startAction();
    try {
      return super.switchMusic(clickedSong);
    } finally {
      _$_SongStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic itemSongTap(Song tapSong) {
    final _$actionInfo = _$_SongStoreActionController.startAction();
    try {
      return super.itemSongTap(tapSong);
    } finally {
      _$_SongStoreActionController.endAction(_$actionInfo);
    }
  }
}
