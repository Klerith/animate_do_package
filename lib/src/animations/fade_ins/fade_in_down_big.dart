import 'package:flutter/widgets.dart';

import '../../types/animate_do_typedefs.dart';
import 'fade_in_down.dart';

const Duration _defaultDuration = Duration(milliseconds: 1300);
const Curve _defaultCurve = Curves.easeOut;
const double _defaultFrom = 600;

/// Like [FadeInDown] but with a longer default duration and offset, useful
/// for large entrance animations.
class FadeInDownBig extends StatelessWidget {
  const FadeInDownBig({
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
  Widget build(BuildContext context) => FadeInDown(
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

extension FadeInDownBigExtension on Widget {
  Widget fadeInDownBig({
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
    return FadeInDownBig(
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
