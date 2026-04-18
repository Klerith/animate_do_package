import 'package:flutter/widgets.dart';

import '../../types/animate_do_typedefs.dart';
import 'fade_out_right.dart';

class FadeOutRightBig extends StatelessWidget {
  const FadeOutRightBig({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1200),
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
  Widget build(BuildContext context) => FadeOutRight(
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

extension FadeOutRightBigExtension on Widget {
  Widget fadeOutRightBig({
    Key? key,
    Duration duration = const Duration(milliseconds: 1200),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = 600,
  }) {
    return FadeOutRightBig(
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
