import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AppAudioHandler {
  static final AppAudioHandler _singleton = AppAudioHandler._internal();

  factory AppAudioHandler() {
    return _singleton;
  }

  AppAudioHandler._internal();

  static MediaItem? currentItem;
  static Duration? currentItemDuration;
  late final AudioPlayer _player;

  void init() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.bozjatorium.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );

    _player = AudioPlayer();

    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      if (kDebugMode) {
        print("---------------------------------------------------");
        print('WE HAVE A STREAM ERROR: $e');
        print("---------------------------------------------------");
      }
    });
    _player.playerStateStream.listen((state) {
      switch (state.processingState) {
        case ProcessingState.idle:
          print("Is idle");
          break;
        case ProcessingState.loading:
          print("Is loading");
          break;
        case ProcessingState.buffering:
          print("Is buffering");
          break;
        case ProcessingState.ready:
          print("Is ready");
          break;
        case ProcessingState.completed:
          print("Is completed");
          break;
      }
    });
  }

  void dispose() {
    currentItem = null;
    currentItemDuration = null;
    _player.dispose();
  }

  void setAudioSource(MediaItem item, Uri sourceUri) async {
    final audioSource = AudioSource.uri(
      sourceUri,
      tag: item,
    );
    currentItem = item;
    currentItemDuration = await _player.setAudioSource(audioSource);
  }

  void play() async {
    await _player.play();
  }

  void stop() async {
    await _player.pause();
    await _player.seek(Duration.zero);
  }

  void pause() async {
    await _player.pause();
  }

  void skipForward() async {
    final currentPosition = _player.position;
    final seekPosition = currentPosition + const Duration(seconds: 5);
    await _player.seek(seekPosition);
  }

  void skipBackward() async {
    final currentPosition = _player.position;
    final seekPosition = currentPosition - const Duration(seconds: 5);
    await _player.seek(seekPosition);
  }
}
