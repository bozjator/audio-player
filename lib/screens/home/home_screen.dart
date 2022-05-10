import 'package:audio_player/core/global_widgets/custom_app_bar_widget.dart';
import 'package:audio_player/core/services/app_audio_handler.dart';
import 'package:audio_player/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

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
              onPressed: () {
                AppAudioHandler().play();
              },
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
