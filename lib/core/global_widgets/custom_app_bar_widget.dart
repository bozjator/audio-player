import 'package:audio_player/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget customAppBar(String title, {bool showSettings = true}) {
  List<Widget> actions = [];

  if (showSettings) {
    actions.add(IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        Get.to(const SettingsScreen());
      },
    ));
  }

  return AppBar(
    title: Text(title),
    actions: actions,
  );
}
