import 'package:flutter/widgets.dart';

import '../../types/animate_do_typedefs.dart';
import '../fade_ins/fade_in_left.dart';

/// Convenience wrapper around [FadeInLeft] with a `bounceOut` curve and a
/// short slide distance.
class BounceInLeft extends StatelessWidget {
  const BounceInLeft({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.curve = Curves.bounceOut,
    this.animate = true,
    this.manualTrigger = false,
    this.controller,
    this.onFinish,
    this.from = 75,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final bool animate;
  final bool manualTrigger;
  final AnimateDoControllerCallback? controller;
  final AnimateDoFinishCallback? onFinish;
  final double from;

  @override
  Widget build(BuildContext context) => FadeInLeft(
        duration: duration,
        delay: delay,
        curve: curve,
        animate: animate,
        manualTrigger: manualTrigger,
        controller: controller,
        onFinish: onFinish,
        from: from,
        child: child,
      );
}

extension BounceInLeftExtension on Widget {
  Widget bounceInLeft({
    Key? key,
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = Duration.zero,
    Curve curve = Curves.bounceOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = 75,
  }) {
    return BounceInLeft(
      key: key,
      duration: duration,
      delay: delay,
      curve: curve,
      animate: animate,
      manualTrigger: manualTrigger,
      controller: controller,
      onFinish: onFinish,
      from: from,
      child: this,
    );
  }
}
