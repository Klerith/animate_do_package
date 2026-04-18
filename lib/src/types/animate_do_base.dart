import 'package:flutter/widgets.dart';

import 'animate_do_mixins.dart';
import 'animate_do_typedefs.dart';

/// Common base for every `animate_do` animation widget.
///
/// Centralizes the public API (`child`, `duration`, `delay`, `curve`,
/// `animate`, `infinite`, `manualTrigger`, `loopDelay`, `controller`,
/// `onFinish`, `onLoop`) so that subclasses only declare the fields that are
/// specific to them (`from`, `to`, `spins`, ...).
///
/// Concrete widgets must extend this class and create a `State` that extends
/// [AnimateDoBaseState].
abstract class AnimateDoBaseWidget extends StatefulWidget {
  const AnimateDoBaseWidget({
    super.key,
    required this.child,
    required this.duration,
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.animate = true,
    this.infinite = false,
    this.manualTrigger = false,
    this.loopDelay = Duration.zero,
    this.controller,
    this.onFinish,
    this.onLoop,
  }) : assert(
          !manualTrigger || controller != null,
          'When manualTrigger is true, the controller callback must be provided '
          'so the consumer can drive the animation manually. Example:\n'
          '  controller: (AnimationController c) => myController = c,',
        );

  /// Widget being animated.
  final Widget child;

  /// Total duration of one animation cycle.
  final Duration duration;

  /// Delay before the animation starts the first time. When [infinite] is
  /// `true` and [loopDelay] is non-zero, this only affects the initial play.
  final Duration delay;

  /// Curve applied to the animation.
  final Curve curve;

  /// Triggers the animation when `true`. Toggling this back to `false` either
  /// reverses the animation or snaps it to its initial value (depending on
  /// the animation type).
  final bool animate;

  /// Repeats the animation indefinitely until the widget is disposed.
  final bool infinite;

  /// When `true`, animation does not start automatically. The consumer must
  /// drive it through the [AnimationController] exposed via [controller].
  final bool manualTrigger;

  /// Pause between iterations when [infinite] is `true`. Defaults to
  /// [Duration.zero] (no pause), which uses [AnimationController.repeat] for
  /// efficiency.
  final Duration loopDelay;

  /// Exposes the internal [AnimationController] when needed.
  final AnimateDoControllerCallback? controller;

  /// Fired when the animation completes a forward or backward run.
  final AnimateDoFinishCallback? onFinish;

  /// Fired on every loop iteration when running in `infinite` mode with a
  /// non-zero [loopDelay].
  final AnimateDoLoopCallback? onLoop;
}

/// Base state class that wires every `animate_do` widget to the shared
/// animation lifecycle ([AnimateDoState]).
///
/// Subclasses must override:
/// - [createTweens]: where every `Animation<...>` should be built.
/// - [buildAnimatedChild]: returns the transformed widget for the current
///   animation tick.
abstract class AnimateDoBaseState<T extends AnimateDoBaseWidget>
    extends State<T>
    with SingleTickerProviderStateMixin, AnimateDoState {
  /// Build the animations driven by `controller`. Called from `initState`
  /// after `controller` has been created.
  @protected
  void createTweens();

  /// Returns the transformed widget for the current animation tick. The
  /// [child] argument is the unchanged `widget.child`, ready to be wrapped
  /// in `Transform`, `Opacity`, etc.
  @protected
  Widget buildAnimatedChild(BuildContext context, Widget child);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    createTweens();
    configAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      infinite: widget.infinite,
      loopDelay: widget.loopDelay,
      onFinish: widget.onFinish,
      onLoop: widget.onLoop,
      controllerCallback: widget.controller,
    );
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      controller.duration = widget.duration;
    }
    if (oldWidget.animate != widget.animate) {
      handleAnimateChange(
        delay: widget.delay,
        animate: widget.animate,
        manualTrigger: widget.manualTrigger,
        infinite: widget.infinite,
        loopDelay: widget.loopDelay,
      );
    }
  }

  @override
  void dispose() {
    disposeAnimation();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) =>
          buildAnimatedChild(context, child!),
    );
  }
}
