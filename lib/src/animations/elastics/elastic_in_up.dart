import 'package:flutter/widgets.dart';

import '../../types/animate_do_typedefs.dart';
import '../fade_ins/fade_in_up.dart';

const Duration _defaultDuration = Duration(milliseconds: 1500);
const Curve _defaultCurve = Curves.elasticOut;
const double _defaultFrom = 200;

/// Convenience wrapper around [FadeInUp] with an `elasticOut` curve and a
/// long slide distance.
class ElasticInUp extends StatelessWidget {
  const ElasticInUp({
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

extension ElasticInUpExtension on Widget {
  Widget elasticInUp({
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
    return ElasticInUp(
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
