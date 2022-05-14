import 'package:audio_player/core/services/app_audio_handler.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final title = "Home";

  @override
  void dispose() {
    AppAudioHandler().dispose();
    super.dispose();
  }
}
