// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SongService on _SongService, Store {
  final _$isLoadingAtom = Atom(name: '_SongService.isLoading');

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

  final _$songsAtom = Atom(name: '_SongService.songs');

  @override
  List<SongInfo> get songs {
    _$songsAtom.reportRead();
    return super.songs;
  }

  @override
  set songs(List<SongInfo> value) {
    _$songsAtom.reportWrite(value, super.songs, () {
      super.songs = value;
    });
  }

  final _$artistsAtom = Atom(name: '_SongService.artists');

  @override
  List<ArtistInfo> get artists {
    _$artistsAtom.reportRead();
    return super.artists;
  }

  @override
  set artists(List<ArtistInfo> value) {
    _$artistsAtom.reportWrite(value, super.artists, () {
      super.artists = value;
    });
  }

  final _$stateAtom = Atom(name: '_SongService.state');

  @override
  AudioPlayerState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AudioPlayerState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$playingSongAtom = Atom(name: '_SongService.playingSong');

  @override
  SongInfo get playingSong {
    _$playingSongAtom.reportRead();
    return super.playingSong;
  }

  @override
  set playingSong(SongInfo value) {
    _$playingSongAtom.reportWrite(value, super.playingSong, () {
      super.playingSong = value;
    });
  }

  final _$audioPlayerAtom = Atom(name: '_SongService.audioPlayer');

  @override
  AudioPlayer get audioPlayer {
    _$audioPlayerAtom.reportRead();
    return super.audioPlayer;
  }

  @override
  set audioPlayer(AudioPlayer value) {
    _$audioPlayerAtom.reportWrite(value, super.audioPlayer, () {
      super.audioPlayer = value;
    });
  }

  final _$durationAtom = Atom(name: '_SongService.duration');

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

  final _$positionAtom = Atom(name: '_SongService.position');

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

  final _$_initAsyncAction = AsyncAction('_SongService._init');

  @override
  Future<void> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  final _$itemSongTapAsyncAction = AsyncAction('_SongService.itemSongTap');

  @override
  Future itemSongTap(SongInfo it) {
    return _$itemSongTapAsyncAction.run(() => super.itemSongTap(it));
  }

  final _$_SongServiceActionController = ActionController(name: '_SongService');

  @override
  void setState() {
    final _$actionInfo = _$_SongServiceActionController.startAction(
        name: '_SongService.setState');
    try {
      return super.setState();
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

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
  void _setCompletionHandler(dynamic _) {
    final _$actionInfo = _$_SongServiceActionController.startAction(
        name: '_SongService._setCompletionHandler');
    try {
      return super._setCompletionHandler(_);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setErrorHandler(String msg) {
    final _$actionInfo = _$_SongServiceActionController.startAction(
        name: '_SongService._setErrorHandler');
    try {
      return super._setErrorHandler(msg);
    } finally {
      _$_SongServiceActionController.endAction(_$actionInfo);
    }
  }

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
artists: ${artists},
state: ${state},
playingSong: ${playingSong},
audioPlayer: ${audioPlayer},
duration: ${duration},
position: ${position}
    ''';
  }
}
