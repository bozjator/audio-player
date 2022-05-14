import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AppAudioHandler {
  static final AppAudioHandler _singleton = AppAudioHandler._internal();

  factory AppAudioHandler() {
    return _singleton;
  }

  AppAudioHandler._internal();

  final _player = AudioPlayer();

  void init() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.bozjatorium.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );

    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      if (kDebugMode) {
        print('A stream error occurred: $e');
      }
    });
  }

  void dispose() {
    _player.dispose();
  }

  void play() {
    final audioSource = AudioSource.uri(
      Uri.parse("https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"),
      tag: MediaItem(
        id: 'unique-id-1',
        album: "Science Friday",
        title: "From Cat Rheology To Operatic Incompetence",
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    );
    _player.setAudioSource(audioSource);

    // option 2
    //var duration = await _player.setUrl('https://foo.com/bar.mp3');

    _player.play();
  }

  void stop() {
    _player.stop();
  }
}
