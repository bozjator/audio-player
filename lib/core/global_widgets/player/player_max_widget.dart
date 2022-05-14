import 'package:audio_player/core/global_widgets/player_widget.dart';
import 'package:audio_player/core/services/app_audio_handler.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../common_utils.dart';

/// Maximized player
class PlayerMax {
  MediaItem mediaItem;

  late double percentageExpandedPlayer;
  late final double paddingVertical;
  late final double heightWithoutPadding;
  late final double imageSize;
  late final double paddingLeft;
  late final Image image;

  final IconButton buttonSkipForward = IconButton(
    icon: const Icon(Icons.forward_5),
    iconSize: 33,
    onPressed: () => AppAudioHandler().skipForward(),
  );
  final IconButton buttonSkipBackwards = IconButton(
    icon: const Icon(Icons.replay_5),
    iconSize: 33,
    onPressed: () => AppAudioHandler().skipBackward(),
  );
  final IconButton buttonPause = IconButton(
    icon: const Icon(Icons.pause_circle_filled),
    iconSize: 50,
    onPressed: () => AppAudioHandler().pause(),
  );

  final progressIndicator = const LinearProgressIndicator(value: 0.3);

  PlayerMax(this.mediaItem, double height, double width, double maxImgSize,
      this.image) {
    percentageExpandedPlayer = CommonUtils.percentageFromValueInRange(
        min: Player.maxHeight * Player.minMaxSwitchPercentages +
            Player.minHeight,
        max: Player.maxHeight,
        value: height);
    if (percentageExpandedPlayer < 0) percentageExpandedPlayer = 0;
    paddingVertical = CommonUtils.valueFromPercentageInRange(
        min: 0, max: 10, percentage: percentageExpandedPlayer);
    heightWithoutPadding = height - paddingVertical * 2;
    imageSize =
        heightWithoutPadding > maxImgSize ? maxImgSize : heightWithoutPadding;
    paddingLeft = CommonUtils.valueFromPercentageInRange(
          min: 0,
          max: width - imageSize,
          percentage: percentageExpandedPlayer,
        ) /
        2;
  }

  buildWidget() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: paddingLeft,
                top: paddingVertical,
                bottom: paddingVertical),
            child: SizedBox(
              height: imageSize,
              child: image,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Opacity(
              opacity: percentageExpandedPlayer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: Text(mediaItem.title)),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buttonSkipBackwards,
                        buttonPause,
                        buttonSkipForward
                      ],
                    ),
                  ),
                  Flexible(child: progressIndicator),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
