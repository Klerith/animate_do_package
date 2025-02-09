import 'dart:math' show pi, sin;

import 'package:flutter/material.dart';

import '../../types/animate_do_mixins.dart';
import '../../types/animate_do_types.dart';

/// Class [ShakeY]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
/// [from] from where you want to start the animation
/// [infinite] loops the animation until the widget is destroyed
class ShakeY extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;
  final double from;

  ShakeY(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 20,
      this.onFinish,
      this.curve = Curves.easeInOut})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  ShakeYState createState() => ShakeYState();
}

/// State class,
/// Controls the animations flow
class ShakeYState extends State<ShakeY>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> shakeAnimation;

  @override
  void dispose() {
    disposed = true;
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    shakeAnimation = CurvedAnimation(parent: controller, curve: widget.curve);

    /// Provided by the mixing [AnimateDoState] class
    configAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      infinite: widget.infinite,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Provided by the mixing [AnimateDoState] class
    buildAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      infinite: widget.infinite,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
    );

    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, sin(4 * pi * shakeAnimation.value) * widget.from),
            child: widget.child,
          );
        });
  }
}

extension ShakeYExtension on Widget {
  /// Aplica una animación de sacudida vertical con opciones personalizables
  Widget shakeY({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    bool infinite = false,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.easeOut,
    double from = 10,
  }) {
    return ShakeY(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      infinite: infinite,
      onFinish: onFinish,
      curve: curve,
      from: from,
      child: this,
    );
  }
}
