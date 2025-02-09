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
];

/// A mixin that provides animation control functionality for Animate_do widgets.
///
/// This mixin handles the core animation logic including:
/// - Animation controller initialization and disposal
/// - Delayed animation triggering
/// - Manual animation control
/// - Infinite animation loops
/// - Animation completion callbacks
/// - Forward/backward animation direction
mixin AnimateDoState {
  /// The animation controller that drives the animation
  late AnimationController controller;

  /// Whether this animation state has been disposed
  bool disposed = false;
  bool isFirstTime = true;

  /// Configures and starts the animation based on the provided parameters.
  ///
  /// Parameters:
  /// - [delay]: Duration to wait before starting the animation
  /// - [animate]: Whether the animation should start automatically
  /// - [manualTrigger]: Whether animation requires manual triggering
  /// - [infinite]: Whether animation should loop infinitely
  /// - [onFinish]: Callback function when animation completes
  /// - [controllerCallback]: Callback to access the animation controller
  void configAnimation({
    required Duration delay,
    required bool animate,
    required bool manualTrigger,
    required bool infinite,
    Function? onFinish,
    Function(AnimationController controller)? controllerCallback,
  }) {
    /// If the user wants to check if the animation finished, we add a listener
    if (onFinish != null) {
      controller.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          onFinish(AnimateDoDirection.forward);
        } else if (status == AnimationStatus.dismissed) {
          onFinish(AnimateDoDirection.backward);
        }
      });
    }

    /// If the user wants to trigger the animation manually, we expose the controller
    if (!manualTrigger && animate) {
      Future.delayed(delay, () {
        if (disposed) return;
        (infinite) ? controller.repeat() : controller.forward();
      });
    }

    /// Returns the controller if the user requires it
    if (controllerCallback != null) {
      controllerCallback(controller);
    }
  }

  /// Builds and controls the animation based on the provided parameters.
  ///
  /// This method handles:
  /// - Delayed animation start
  /// - Infinite animation loops
  /// - Animation reversal
  /// - Manual animation control
  ///
  /// Parameters:
  /// - [delay]: Duration to wait before starting the animation
  /// - [animate]: Whether the animation should start automatically
  /// - [manualTrigger]: Whether animation requires manual triggering
  /// - [infinite]: Whether animation should loop infinitely
  /// - [onFinish]: Callback function when animation completes
  /// - [controllerCallback]: Callback to access the animation controller
  void buildAnimation({
    required Duration delay,
    required bool animate,
    required bool manualTrigger,
    required bool infinite,
    Function? onFinish,
    Function(AnimationController controller)? controllerCallback,
  }) {
    /// Launch the animation ASAP or wait until needed
    print("animate: $animate");

    if (animate && !manualTrigger) {
      // controller.value = 0;

      Future.delayed(delay, () {
        if (disposed) return;
        if (infinite) {
          controller.repeat();
          return;
        }

        (animate) ? controller.forward() : controller.reverse();
      });
    }

    /// If the animation already happen, we can animate it back
    if (!animate) {
      if (disposed) return;
      if (infinite) {
        controller.stop();
        return;
      }

      // If the animation is finished, we need to reset the animation to the original state
      // after the animation is finished just for the following classes:
      if (resetAnimationClasses.contains(this.runtimeType) && !isFirstTime) {
        controller.value = 0;
        return;
      }

      controller.animateBack(0);
      isFirstTime = false;
    }
  }
}
