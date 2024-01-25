import 'package:flutter/widgets.dart';

import '../types/animate_do_types.dart';

/// Provides a common interface for [AnimateDoState]
mixin AnimateDoState {

  /// All the animations are controlled by a [AnimationController]
  /// The controller is created in the [initState] method of the parent AnimatedWidget
  /// This method controls the flow of the animation
  
  void configAnimation({
    required AnimationController controller,
    required bool disposed,
    required bool animate,
    required bool manualTrigger,
    required Function? onFinish,
    required Duration delay,
    required Function(AnimationController controller)? controllerCallback,
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
        if (!disposed) {
          controller.forward();
        }
      });
    }

    /// Returns the controller if the user requires it
    if (controllerCallback != null) {
      controllerCallback(controller);
    }
  }


  void buildAnimation({
    required AnimationController controller,
    required bool disposed,
    required bool animate,
    required Duration delay,
    required bool manualTrigger,
  }) {
     /// Launch the animation ASAP or wait until needed
    if (animate && !manualTrigger) {
      Future.delayed(delay, () {
        if (!disposed ) {
          ( animate ) 
            ? controller.forward()
            : controller.animateBack(0);
        }
      });
    }

    /// If the animation already happen, we can animate it back
    if (!animate) {
      controller.animateBack(0);
    }
  }
}


