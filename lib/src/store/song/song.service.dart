import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'audio_handler.dart';

part 'song.service.g.dart';

class SongService = _SongService with _$SongService;

abstract class _SongService with Store {
  _SongService() {
    _init();
  }

  /// 加载本地音乐状态
  @observable
  bool isLoading = false;

  final OnAudioQuery _audioQuery = OnAudioQuery();

  /// 本地歌曲列表
  @observable
  List<SongModel> songs = <SongModel>[];
  @observable
  bool isPlaying = false;

  /// 正在播放的音乐
  @observable
  SongModel? playingSong;

  MusicAudioHandler? _audioHandler;
  final Map<String, SongModel> _songById = <String, SongModel>{};

  /// 总时长
  @observable
  Duration duration = Duration.zero;

  /// 当前播放位置
  @observable
  Duration position = Duration.zero;

  @action
  void _setDurationHandler(Duration d) {
    duration = d;
  }

  @action
  void _setPositionHandler(Duration p) {
    position = p;
  }

  @action
  Future<void> _init() async {
    isLoading = true;
    final hasPermission = await _audioQuery.permissionsStatus();
    if (!hasPermission) {
      final requested = await _audioQuery.permissionsRequest();
      if (!requested) {
        isLoading = false;
        return;
      }
    }
    songs = await _audioQuery.querySongs();
    _songById
      ..clear()
      ..addEntries(
        songs.map((s) => MapEntry(s.id.toString(), s)),
      );
    isLoading = false;

    _audioHandler ??= await AudioService.init(
      builder: () => MusicAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.ajanuw.flutter_music.channel.audio',
        androidNotificationChannelName: 'Music Playback',
        androidNotificationOngoing: true,
      ),
    );

    final queue = songs.map(_toMediaItem).toList();
    final sources = songs.map(_sourceForSong).toList();
    await _audioHandler!.setQueue(queue, sources);

    _audioHandler!.playbackState.listen((state) {
      isPlaying = state.playing;
    });

    _audioHandler!.mediaItem.listen((item) {
      if (item == null) return;
      playingSong = _songById[item.id];
      duration = item.duration ?? Duration.zero;
    });

    AudioService.position.listen(_setPositionHandler);
  }

  dispose() {
    _audioHandler?.stop();
  }

  @action
  void seek(Duration v) {
    _audioHandler?.seek(v);
  }

  @action
  Future<void> play() async {
    await _audioHandler?.play();
  }

  @action
  Future<void> pause() async {
    await _audioHandler?.pause();
  }

  /// 每个song item被点击时事件处理
  @action
  itemSongTap(SongModel it) async {
    if (_audioHandler == null) return;
    if (isPlaying && it == playingSong) {
      await _audioHandler!.pause();
      return;
    }
    final index = songs.indexOf(it);
    if (index != -1) {
      await _audioHandler!.skipToQueueItem(index);
    }
  }

  MediaItem _toMediaItem(SongModel song) {
    final artUri = song.albumId == null
        ? null
        : Uri.parse("content://media/external/audio/albumart/${song.albumId}");
    return MediaItem(
      id: song.id.toString(),
      title: song.title,
      artist: song.artist,
      album: song.album,
      duration: song.duration == null
          ? null
          : Duration(milliseconds: song.duration!),
      artUri: artUri,
    );
  }

  AudioSource _sourceForSong(SongModel song) {
    final uri = song.uri;
    if (uri != null && uri.isNotEmpty) {
      return AudioSource.uri(Uri.parse(uri));
    }
    return AudioSource.uri(Uri.file(song.data));
  }
}
