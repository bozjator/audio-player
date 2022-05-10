import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';

class AppAudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler // mix in default seek callback implementations
{
  static final AppAudioHandler _singleton = AppAudioHandler._internal();

  factory AppAudioHandler() {
    return _singleton;
  }

  AppAudioHandler._internal();

  late AppAudioHandler appAudioHandler;

  void init() async {
    appAudioHandler = await AudioService.init(
      builder: () => AppAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId:
            'com.bozjatorium.audioplayer.channel.audio',
        androidNotificationChannelName: 'Music playback',
      ),
    );
  }

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Future<void> play() async {
    // All 'play' requests from all origins route to here. Implement this
    // callback to start playing audio appropriate to your app. e.g. music.
    int result =
        await audioPlayer.play("https://it-dk.com/media-demo/demo-1.mp3");
    if (result == 1) {
      print("result success");
    }
  }

  @override
  Future<void> pause() async {}

  @override
  Future<void> stop() async {
    int result = await audioPlayer.stop();
  }

  @override
  Future<void> seek(Duration position) async {}

  @override
  Future<void> skipToQueueItem(int i) async {}
}
