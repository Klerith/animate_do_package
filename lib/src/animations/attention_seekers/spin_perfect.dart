import 'package:flutter/widgets.dart';

import '../../types/animate_do_typedefs.dart';
import 'spin.dart';

/// Convenience wrapper around [Spin] using `Curves.linear` for a constant
/// rotation speed.
class SpinPerfect extends StatelessWidget {
  const SpinPerfect({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.curve = Curves.linear,
    this.animate = true,
    this.infinite = false,
    this.manualTrigger = false,
    this.loopDelay = Duration.zero,
    this.controller,
    this.onFinish,
    this.onLoop,
    this.spins = 1,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final bool animate;
  final bool infinite;
  final bool manualTrigger;
  final Duration loopDelay;
  final AnimateDoControllerCallback? controller;
  final AnimateDoFinishCallback? onFinish;
  final AnimateDoLoopCallback? onLoop;
  final double spins;

  @override
  Widget build(BuildContext context) => Spin(
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
        spins: spins,
        child: child,
      );
}

extension SpinPerfectExtension on Widget {
  Widget spinPerfect({
    Key? key,
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = Duration.zero,
    Curve curve = Curves.linear,
    bool animate = true,
    bool infinite = false,
    bool manualTrigger = false,
    Duration loopDelay = Duration.zero,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    AnimateDoLoopCallback? onLoop,
    double spins = 1,
  }) {
    return SpinPerfect(
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
      spins: spins,
      child: this,
    );
  }
}
