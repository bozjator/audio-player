import 'package:audio_player/core/services/app_audio_handler.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';

class HomeController extends GetxController {
  final title = "Home";

  void startDemoPlay() {
    final audioUri = Uri.parse(
        "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3");
    final mediaItem = MediaItem(
      id: 'unique-id-1',
      album: "Science Friday",
      title: "From Cat Rheology To Operatic Incompetence",
      artUri: Uri.parse(
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
    );
    AppAudioHandler().setAudioSource(mediaItem, audioUri);
    AppAudioHandler().play();
  }
}
