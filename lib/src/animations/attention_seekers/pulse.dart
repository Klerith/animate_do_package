import 'package:flutter/material.dart';

import '../../types/animate_do_mixins.dart';
import '../../types/animate_do_types.dart';

/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// [manualTrigger]: boolean that indicates if you want to trigger the animation manually with the controller
/// [animate]: For a State controller property, if you re-render changing it from false to true, the animation will be fired immediately
/// [onFinish]: callback that returns the direction of the animation, [AnimateDoDirection.forward] or [AnimateDoDirection.backward]
/// [curve]: curve for the animation
/// [infinite]: loops the animation until the widget is destroyed
class Pulse extends StatefulWidget {
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
  final double to;

  Pulse(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.onFinish,
      this.curve = Curves.easeOut,
      this.from = 1,
      this.to = 1.5})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  PulseState createState() => PulseState();
}

/// State class, where the magic happens
class PulseState extends State<Pulse>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> animationInc;
  late Animation<double> animationDec;
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

    animationInc = Tween<double>(begin: widget.from, end: widget.to).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.5, curve: widget.curve))); // Curves.easeOut

    animationDec = Tween<double>(begin: widget.to, end: widget.from).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1, curve: widget.curve))); // Curves.easeIn

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
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: (controller.value < 0.5)
                ? animationInc.value
                : animationDec.value,
            child: widget.child,
          );
        });
  }
}

extension PulseExtension on Widget {
  /// Applies a pulse animation with customizable options
  Widget pulse({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    bool infinite = false,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.easeOut,
    double from = 1,
    double to = 1.5,
  }) {
    return Pulse(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      infinite: infinite,
      onFinish: onFinish,
      curve: curve,
      from: from,
      to: to,
      child: this,
    );
  }
}
