import 'package:audio_player/core/common_utils.dart';
import 'package:audio_player/core/global_widgets/player_widget.dart';
import 'package:audio_player/core/services/app_audio_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';

/// Minimized player
class PlayerMin {
  MediaItem mediaItem;

  late final Image image;
  final double maxImgSize;
  late final double elementOpacity;
  late final double progressIndicatorHeight;

  final progressIndicator = const LinearProgressIndicator(value: 0.3);

  final IconButton buttonSkipForward = IconButton(
    icon: const Icon(Icons.forward_5),
    onPressed: () => AppAudioHandler().skipForward(),
  );
  final IconButton buttonSkipBackwards = IconButton(
    icon: const Icon(Icons.replay_5),
    onPressed: () => AppAudioHandler().skipBackward(),
  );
  final buttonPlay = IconButton(
    icon: const Icon(Icons.pause),
    onPressed: () => AppAudioHandler().pause(),
  );

  PlayerMin(this.mediaItem, double height, this.maxImgSize, this.image) {
    final percentageMiniplayer = CommonUtils.percentageFromValueInRange(
        min: Player.minHeight,
        max: Player.maxHeight * Player.minMaxSwitchPercentages +
            Player.minHeight,
        value: height);

    elementOpacity = 1 - 1 * percentageMiniplayer;
    progressIndicatorHeight = 4 - 4 * percentageMiniplayer;
  }

  buildWidget() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxImgSize),
                child: image,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Opacity(
                    opacity: elementOpacity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(mediaItem.title,
                            style: Get.theme.textTheme.bodyText2!
                                .copyWith(fontSize: 16)),
                        Text(
                          mediaItem.displaySubtitle ?? mediaItem.album ?? "",
                          style: Get.theme.textTheme.bodyText2!.copyWith(
                            color: Get.theme.textTheme.bodyText2!.color!
                                .withOpacity(0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              buttonSkipBackwards,
              buttonPlay,
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: Opacity(
                  opacity: elementOpacity,
                  child: buttonSkipForward,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: progressIndicatorHeight,
          child: Opacity(
            opacity: elementOpacity,
            child: progressIndicator,
          ),
        ),
      ],
    );
  }
}
