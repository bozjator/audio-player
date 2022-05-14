import 'package:audio_player/core/global_widgets/custom_app_bar_widget.dart';
import 'package:audio_player/core/services/app_audio_handler.dart';
import 'package:audio_player/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(controller.title),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(controller.title),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: startDemoPlay,
              child: const Text('Play'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () {
                AppAudioHandler().stop();
              },
              child: const Text('Stop'),
            )
          ],
        ),
      ),
    );
  }
}
