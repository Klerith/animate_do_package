import 'package:flutter/widgets.dart';

import '../../types/animate_do_typedefs.dart';
import 'fade_out_left.dart';

class FadeOutLeftBig extends StatelessWidget {
  const FadeOutLeftBig({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1300),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.animate = true,
    this.manualTrigger = false,
    this.controller,
    this.onFinish,
    this.from = 600,
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
  Widget build(BuildContext context) => FadeOutLeft(
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

extension FadeOutLeftBigExtension on Widget {
  Widget fadeOutLeftBig({
    Key? key,
    Duration duration = const Duration(milliseconds: 1300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = 600,
  }) {
    return FadeOutLeftBig(
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
