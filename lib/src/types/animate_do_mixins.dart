import 'dart:async';

import 'package:flutter/widgets.dart';

import 'animate_do_reset_marker.dart';
import 'animate_do_types.dart';
import 'animate_do_typedefs.dart';

/// Provides the shared animation lifecycle used by every `animate_do` widget.
///
/// Concrete state classes are expected to:
/// - Mix [SingleTickerProviderStateMixin] (or another `Ticker` provider).
/// - Initialize [controller] in `initState` BEFORE calling [configAnimation].
/// - Call [disposeAnimation] from their `dispose` override (the base state
///   in `animate_do_base.dart` already does this).
mixin AnimateDoState {
  late AnimationController controller;

  /// `true` after `dispose` has been called. Used to drop async callbacks
  /// (delay timers, loop timers) that resolve after the widget is gone.
  bool disposed = false;

  /// Tracks whether the animation has played at least once. Used to decide if
  /// a "reset" should be performed when `animate` toggles back to `false` on
  /// animations marked with [ResetOnReverseAnimation].
  bool isFirstTime = true;

  /// `true` while waiting between loop iterations (the `loopDelay` pause).
  bool _loopTimerActive = false;

  /// Pending start timer (for `delay` and `loopDelay`). Cancelled in
  /// [disposeAnimation] to avoid late callbacks firing on a disposed state.
  Timer? _delayTimer;
  Timer? _loopDelayTimer;

  /// Wires up status listeners and triggers the animation, unless
  /// [manualTrigger] is `true`. Should be called once from `initState`.
  void configAnimation({
    required Duration delay,
    required bool animate,
    required bool manualTrigger,
    required bool infinite,
    Duration loopDelay = Duration.zero,
    AnimateDoFinishCallback? onFinish,
    AnimateDoLoopCallback? onLoop,
    AnimateDoControllerCallback? controllerCallback,
  }) {
    final bool hasLoopDelay = infinite && loopDelay > Duration.zero;

    if (onFinish != null || hasLoopDelay) {
      controller.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          onFinish?.call(AnimateDoDirection.forward);
          if (hasLoopDelay) {
            _loopTimerActive = true;
            onLoop?.call();
            _loopDelayTimer?.cancel();
            _loopDelayTimer = Timer(loopDelay, () {
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

    if (controllerCallback != null) {
      controllerCallback(controller);
    }

    if (!manualTrigger && animate) {
      _scheduleStart(delay: delay, infinite: infinite, loopDelay: loopDelay);
    }
  }

  /// Reacts to `animate` toggles after `initState`. Should be called from
  /// `didUpdateWidget` (or any custom flow) when `widget.animate` changes.
  void handleAnimateChange({
    required Duration delay,
    required bool animate,
    required bool manualTrigger,
    required bool infinite,
    Duration loopDelay = Duration.zero,
  }) {
    if (disposed) return;

    if (animate && !manualTrigger) {
      _scheduleStart(delay: delay, infinite: infinite, loopDelay: loopDelay);
      return;
    }

    if (!animate) {
      if (infinite) {
        _loopTimerActive = false;
        _loopDelayTimer?.cancel();
        controller.stop();
        return;
      }

      if (this is ResetOnReverseAnimation && !isFirstTime) {
        controller.value = 0;
        return;
      }

      controller.animateBack(0);
      isFirstTime = false;
    }
  }

  /// Cancels any pending start/loop timers. Called from the base state's
  /// `dispose`.
  void disposeAnimation() {
    disposed = true;
    _delayTimer?.cancel();
    _loopDelayTimer?.cancel();
  }

  void _scheduleStart({
    required Duration delay,
    required bool infinite,
    required Duration loopDelay,
  }) {
    _delayTimer?.cancel();
    if (delay == Duration.zero) {
      _start(infinite: infinite, loopDelay: loopDelay);
      return;
    }
    _delayTimer = Timer(delay, () {
      if (disposed) return;
      _start(infinite: infinite, loopDelay: loopDelay);
    });
  }

  void _start({required bool infinite, required Duration loopDelay}) {
    isFirstTime = false;
    if (infinite) {
      if (loopDelay == Duration.zero) {
        controller.repeat();
      } else if (!_loopTimerActive) {
        controller.forward(from: 0);
      }
      return;
    }
    controller.forward();
  }
}
