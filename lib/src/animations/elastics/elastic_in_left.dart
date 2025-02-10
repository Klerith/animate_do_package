import 'package:flutter/material.dart';

import '../../types/animate_do_types.dart';
import '../fade_ins/fade_in_left.dart';

/// Class [ElasticInLeft]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class ElasticInLeft extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;
  final double from;
  final double to;

  ElasticInLeft(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1500),
      this.delay = Duration.zero,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 200,
      this.to = 100,
      this.onFinish,
      this.curve = Curves.elasticOut})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => FadeInLeft(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from,
      onFinish: onFinish,
      curve: curve,
      child: child);
}

extension ElasticInLeftExtension on Widget {
  /// Aplica una animación elastic-in-left con opciones personalizables
  Widget elasticInLeft({
    Duration duration = const Duration(milliseconds: 1500),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    double from = 200,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.elasticOut,
  }) {
    return ElasticInLeft(
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
