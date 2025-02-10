import 'package:flutter/material.dart';

import '../../types/animate_do_types.dart';
import 'fade_out_up.dart';

/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// [manualTrigger]: boolean that indicates if you want to trigger the animation manually with the controller
/// [animate]: For a State controller property, if you re-render changing it from false to true, the animation will be fired immediately
/// [onFinish]: callback that returns the direction of the animation, [AnimateDoDirection.forward] or [AnimateDoDirection.backward]
/// [curve]: curve for the animation
class FadeOutUpBig extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;
  final double from;

  FadeOutUpBig({
    key,
    required this.child,
    this.duration = const Duration(milliseconds: 1300),
    this.delay = const Duration(milliseconds: 0),
    this.controller,
    this.manualTrigger = false,
    this.animate = false,
    this.from = 600,
    this.onFinish,
    this.curve = Curves.easeOut,
  }) : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => FadeOutUp(
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from,
        onFinish: onFinish,
        curve: curve,
        child: child,
      );
}

extension FadeOutUpBigExtension on Widget {
  /// Aplica una animación fade-out-up-big con opciones personalizables
  Widget fadeOutUpBig({
    Duration duration = const Duration(milliseconds: 1300),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = false,
    double from = 600,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.easeOut,
  }) {
    return FadeOutUpBig(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from,
      onFinish: onFinish,
      curve: curve,
      child: this,
    );
  }
}
