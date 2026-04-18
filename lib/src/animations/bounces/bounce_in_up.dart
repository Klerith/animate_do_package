import 'package:flutter/widgets.dart';

import '../../types/animate_do_typedefs.dart';
import '../fade_ins/fade_in_up.dart';

const Duration _defaultDuration = Duration(milliseconds: 1000);
const Curve _defaultCurve = Curves.bounceOut;
const double _defaultFrom = 75;

/// Convenience wrapper around [FadeInUp] with a `bounceOut` curve and a
/// short slide distance.
class BounceInUp extends StatelessWidget {
  const BounceInUp({
    super.key,
    required this.child,
    this.duration = _defaultDuration,
    this.delay = Duration.zero,
    this.curve = _defaultCurve,
    this.animate = true,
    this.manualTrigger = false,
    this.controller,
    this.onFinish,
    this.from = _defaultFrom,
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
  Widget build(BuildContext context) => FadeInUp(
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

extension BounceInUpExtension on Widget {
  Widget bounceInUp({
    Key? key,
    Duration duration = _defaultDuration,
    Duration delay = Duration.zero,
    Curve curve = _defaultCurve,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = _defaultFrom,
  }) {
    return BounceInUp(
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
