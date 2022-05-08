import 'package:audio_player/core/global_widgets/custom_app_bar_widget.dart';
import 'package:audio_player/screens/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(controller.title, showSettings: false),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Text(controller.title),
      ),
    );
  }
}
