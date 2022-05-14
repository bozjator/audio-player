import 'package:audio_player/core/global_widgets/player_widget.dart';
import 'package:audio_player/core/services/app_audio_handler.dart';
import 'package:audio_player/core/theme/dark_theme.dart';
import 'package:audio_player/core/theme/light_theme.dart';
import 'package:audio_player/screens/home/home_controller.dart';
import 'package:audio_player/screens/home/home_screen.dart';
import 'package:audio_player/screens/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  AppAudioHandler().init();
  initControllers();
  runApp(const MyApp());
}

void initControllers() {
  Get.put(HomeController());
  Get.put(SettingsController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Audio player',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            Obx(
              () => Player(mediaItem: AppAudioHandler().currentItem.value),
            )
          ],
        );
      },
    );
  }
}
