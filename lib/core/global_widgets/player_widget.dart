import 'package:audio_player/core/global_widgets/player/player_max_widget.dart';
import 'package:audio_player/core/global_widgets/player/player_min_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:miniplayer/miniplayer.dart';

class Player extends StatelessWidget {
  static const double minHeight = 70;
  static const double maxHeight = 500;
  static const double minMaxSwitchPercentages = 0.2;

  final MediaItem mediaItem;

  const Player({Key? key, required this.mediaItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mediaItem.id.isEmpty) {
      return const SizedBox.shrink();
    }

    return Miniplayer(
      minHeight: Player.minHeight,
      maxHeight: Player.maxHeight,
      elevation: 20,
      builder: (height, percentage) {
        final showMinPlayer = percentage < Player.minMaxSwitchPercentages;
        final width = MediaQuery.of(context).size.width;
        final maxImgSize = width * 0.7;

        final img = Image.network(mediaItem.artUri.toString());

        if (showMinPlayer) {
          return PlayerMin(mediaItem, height, maxImgSize, img).buildWidget();
        } else {
          return PlayerMax(mediaItem, height, width, maxImgSize, img)
              .buildWidget();
        }
      },
    );
  }
}
