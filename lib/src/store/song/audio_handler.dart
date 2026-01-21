import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class MusicAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _player = AudioPlayer();

  MusicAudioHandler() {
    _init();
  }

  Future<void> _init() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
    }

    _notifyAudioHandlerAboutPlaybackEvents();

    _player.currentIndexStream.listen((index) {
      final q = queue.value;
      if (index != null && index >= 0 && index < q.length) {
        mediaItem.add(q[index]);
      }
    });

    _player.durationStream.listen((duration) {
      final item = mediaItem.value;
      if (item == null) return;
      mediaItem.add(item.copyWith(duration: duration));
    });

    // 显式监听播放状态切换
    _player.playingStream.listen((playing) {
      _updatePlaybackState();
    });

    // 显式监听处理状态切换 (loading, ready, buffering, completed)
    _player.processingStateStream.listen((state) {
      _updatePlaybackState();
    });

    _player.positionStream.listen((pos) {
      _updatePlaybackState();
    });
  }

  void _updatePlaybackState() {
    final playing = _player.playing;
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          playing ? MediaControl.pause : MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: _transformProcessingState(_player.processingState),
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: _player.currentIndex,
      ),
    );
  }

  Future<void> setQueue(
    List<MediaItem> items,
    List<AudioSource> sources,
  ) async {
    debugPrint("Setting queue with ${items.length} items");
    queue.add(items);
    try {
      await _player.setAudioSource(
        ConcatenatingAudioSource(children: sources),
      );
    } catch (e) {
      debugPrint("Error setting audio source: $e");
    }
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    return super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> skipToQueueItem(int index) async {
    debugPrint("skipToQueueItem called for index: $index");
    if (index < 0 || index >= queue.value.length) {
      debugPrint("Index out of bounds for queue");
      return;
    }
    try {
      await _player.seek(Duration.zero, index: index);
      debugPrint("Player seeked, starting playback...");
      await _player.play();
    } catch (e) {
      debugPrint("Error during playback: $e");
    }
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    _player.playbackEventStream.listen((event) {
      debugPrint("Player event: playing=${_player.playing}, state=${_player.processingState}, position=${_player.position}");
      _updatePlaybackState();
    });
  }

  AudioProcessingState _transformProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }
}
