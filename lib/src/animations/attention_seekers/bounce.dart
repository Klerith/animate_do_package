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
/// [from]: starting point for the animation
class Bounce extends StatefulWidget {
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

  Bounce(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1300),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 50,
      this.onFinish,
      this.curve = Curves.bounceOut})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  BounceState createState() => BounceState();
}

/// State class, where the magic happens
class BounceState extends State<Bounce>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> animationBounce;
  late Animation<double> animationUp;

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

    animationUp = Tween<double>(begin: 0, end: widget.from * -1).animate(
        CurvedAnimation(
            curve: const Interval(0, 0.35, curve: Curves.easeInOut),
            parent: controller));

    animationBounce = Tween<double>(begin: widget.from * -1, end: 0.0).animate(
        CurvedAnimation(
            curve: Interval(0.35, 1, curve: widget.curve), parent: controller));

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
          return Transform.translate(
              offset: Offset(
                  0,
                  (animationUp.value == (widget.from * -1))
                      ? animationBounce.value
                      : animationUp.value),
              child: widget.child);
        });
  }
}

extension BounceExtension on Widget {
  /// Applies a bounce animation with customizable options
  Widget bounce({
    Duration duration = const Duration(milliseconds: 1300),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.bounceOut,
    double from = 50,
  }) {
    return Bounce(
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
