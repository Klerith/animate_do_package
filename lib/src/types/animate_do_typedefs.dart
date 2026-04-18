import 'package:flutter/widgets.dart';

import 'animate_do_types.dart';

/// Callback fired when an animation finishes a forward or backward run.
typedef AnimateDoFinishCallback = void Function(AnimateDoDirection direction);

/// Callback that exposes the internal [AnimationController] to the caller.
///
/// Useful when [AnimateDoBaseWidget.manualTrigger] is `true` and the consumer
/// needs to control the animation manually.
typedef AnimateDoControllerCallback = void Function(
  AnimationController controller,
);

/// Callback fired on every loop iteration when an animation runs in
/// `infinite: true` mode with a non-zero `loopDelay`.
typedef AnimateDoLoopCallback = void Function();
