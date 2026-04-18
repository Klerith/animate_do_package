import 'package:flutter/widgets.dart';

import '../animations/attention_seekers/index.dart';
import '../types/animate_do_types.dart';

// The following classes need to be reset to the original state
// after the animation is finished
final List<Type> resetAnimationClasses = [
  RubberBand,
  BounceState,
  HeartBeatState,
  Swing,
  Wobble,
  Jello,
];

mixin AnimateDoState {
  late AnimationController controller;
  bool disposed = false;
  bool isFirstTime = true;

  /// True while waiting between loop iterations (loopDelay pause).
  bool _loopTimerActive = false;

  void configAnimation({
    required Duration delay,
    required bool animate,
    required bool manualTrigger,
    required bool infinite,
    Duration loopDelay = Duration.zero,
    Function? onFinish,
    Function? onLoop,
    Function(AnimationController controller)? controllerCallback,
  }) {
    final bool hasLoopDelay = infinite && loopDelay > Duration.zero;

    if (onFinish != null || hasLoopDelay) {
      controller.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          onFinish?.call(AnimateDoDirection.forward);
          if (hasLoopDelay) {
            _loopTimerActive = true;
            onLoop?.call();
            Future.delayed(loopDelay, () {
              _loopTimerActive = false;
              if (disposed) return;
              controller.forward(from: 0);
            });
          }
        } else if (status == AnimationStatus.dismissed) {
          onFinish?.call(AnimateDoDirection.backward);
        }
      });
    }

    if (!manualTrigger && animate) {
      Future.delayed(delay, () {
        if (disposed) return;
        (infinite && loopDelay == Duration.zero)
            ? controller.repeat()
            : controller.forward();
      });
    }

    if (controllerCallback != null) {
      controllerCallback(controller);
    }
  }

  void buildAnimation({
    required Duration delay,
    required bool animate,
    required bool manualTrigger,
    required bool infinite,
    Duration loopDelay = Duration.zero,
    Function? onFinish,
    Function? onLoop,
    Function(AnimationController controller)? controllerCallback,
  }) {
    if (animate && !manualTrigger) {
      Future.delayed(delay, () {
        if (disposed) return;
        if (infinite) {
          if (loopDelay == Duration.zero) {
            controller.repeat();
          } else if (!_loopTimerActive) {
            controller.forward();
          }
          return;
        }
        (animate) ? controller.forward() : controller.reverse();
      });
    }

    if (!animate) {
      if (disposed) return;
      if (infinite) {
        _loopTimerActive = false;
        controller.stop();
        return;
      }

      if (resetAnimationClasses.contains(runtimeType) && !isFirstTime) {
        controller.value = 0;
        return;
      }

      controller.animateBack(0);
      isFirstTime = false;
    }
  }
}
