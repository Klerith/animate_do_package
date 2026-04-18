import 'package:flutter/widgets.dart';

import '../../types/animate_do_typedefs.dart';
import '../fade_ins/fade_in_right.dart';

/// Convenience wrapper around [FadeInRight] with an `elasticOut` curve and a
/// long slide distance.
class ElasticInRight extends StatelessWidget {
  const ElasticInRight({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.delay = Duration.zero,
    this.curve = Curves.elasticOut,
    this.animate = true,
    this.manualTrigger = false,
    this.controller,
    this.onFinish,
    this.from = 200,
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
  Widget build(BuildContext context) => FadeInRight(
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

extension ElasticInRightExtension on Widget {
  Widget elasticInRight({
    Key? key,
    Duration duration = const Duration(milliseconds: 1500),
    Duration delay = Duration.zero,
    Curve curve = Curves.elasticOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = 200,
  }) {
    return ElasticInRight(
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
