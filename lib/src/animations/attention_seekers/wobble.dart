import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_reset_marker.dart';
import '../../types/animate_do_typedefs.dart';

/// Wobbles the [child] horizontally while rotating slightly, mimicking the
/// `wobble` animation from Animate.css. The horizontal amount is a fraction
/// of the available screen width.
class Wobble extends AnimateDoBaseWidget {
  const Wobble({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 1000),
    super.delay,
    super.curve = Curves.easeInOut,
    super.animate,
    super.infinite,
    super.manualTrigger,
    super.loopDelay,
    super.controller,
    super.onFinish,
    super.onLoop,
  });

  @override
  State<Wobble> createState() => WobbleState();
}

class WobbleState extends AnimateDoBaseState<Wobble>
    with ResetOnReverseAnimation {
  late Animation<double> _translateX;
  late Animation<double> _rotation;

  @override
  void createTweens() {
    final CurvedAnimation curved =
        CurvedAnimation(parent: controller, curve: widget.curve);

    _translateX = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.15), weight: 15),
      TweenSequenceItem(tween: Tween(begin: -0.15, end: 0.12), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 0.12, end: -0.09), weight: 15),
      TweenSequenceItem(tween: Tween(begin: -0.09, end: 0.06), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 0.06, end: -0.03), weight: 15),
      TweenSequenceItem(tween: Tween(begin: -0.03, end: 0.0), weight: 25),
    ]).animate(curved);

    _rotation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.0872665), weight: 15),
      TweenSequenceItem(
        tween: Tween(begin: -0.0872665, end: 0.0523599),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.0523599, end: -0.0523599),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.0523599, end: 0.0349066),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.0349066, end: -0.0174533),
        weight: 15,
      ),
      TweenSequenceItem(tween: Tween(begin: -0.0174533, end: 0.0), weight: 25),
    ]).animate(curved);
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    final double width = MediaQuery.of(context).size.width;
    return Transform(
      transform: Matrix4.identity()
        ..translateByDouble(_translateX.value * width, 0, 0, 1)
        ..rotateZ(_rotation.value),
      alignment: Alignment.center,
      child: child,
    );
  }
}

extension WobbleExtension on Widget {
  Widget wobble({
    Key? key,
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool infinite = false,
    bool manualTrigger = false,
    Duration loopDelay = Duration.zero,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    AnimateDoLoopCallback? onLoop,
  }) {
    return Wobble(
      key: key,
      duration: duration,
      delay: delay,
      curve: curve,
      animate: animate,
      infinite: infinite,
      manualTrigger: manualTrigger,
      loopDelay: loopDelay,
      controller: controller,
      onFinish: onFinish,
      onLoop: onLoop,
      child: this,
    );
  }
}
