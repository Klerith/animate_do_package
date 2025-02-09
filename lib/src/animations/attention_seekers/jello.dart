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
class Jello extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  Jello({
    key,
    required this.child,
    this.duration = const Duration(milliseconds: 1200),
    this.delay = const Duration(milliseconds: 0),
    this.infinite = false,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
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
  JelloState createState() => JelloState();
}

/// State class, where the magic happens
class JelloState extends State<Jello>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> _skewX;
  late Animation<double> _skewY;

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

    _skewX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 0), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: 0, end: -12.5), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: -12.5, end: 6.25), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: 6.25, end: -3.125), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: -3.125, end: 1.5625), weight: 11.1),
      TweenSequenceItem(
          tween: Tween(begin: 1.5625, end: -0.78125), weight: 11.1),
      TweenSequenceItem(
          tween: Tween(begin: -0.78125, end: 0.390625), weight: 11.1),
      TweenSequenceItem(
          tween: Tween(begin: 0.390625, end: -0.1953125), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: -0.1953125, end: 0), weight: 11.2),
    ]).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0, 1, curve: widget.curve),
    ));

    _skewY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 0), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: 0, end: -12.5), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: -12.5, end: 6.25), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: 6.25, end: -3.125), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: -3.125, end: 1.5625), weight: 11.1),
      TweenSequenceItem(
          tween: Tween(begin: 1.5625, end: -0.78125), weight: 11.1),
      TweenSequenceItem(
          tween: Tween(begin: -0.78125, end: 0.390625), weight: 11.1),
      TweenSequenceItem(
          tween: Tween(begin: 0.390625, end: -0.1953125), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: -0.1953125, end: 0), weight: 11.2),
    ]).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0, 1, curve: widget.curve),
    ));

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
        return Transform(
          transform: Matrix4.skew(
            _skewX.value * 0.0174533, // Convert degrees to radians
            _skewY.value * 0.0174533,
          ),
          alignment: Alignment.center,
          child: widget.child,
        );
      },
    );
  }
}
