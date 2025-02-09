import 'package:flutter/material.dart';

import '../../types/animate_do_mixins.dart';
import '../../types/animate_do_types.dart';

// Tada
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
class Tada extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  Tada(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
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
  TadaState createState() => TadaState();
}

/// State class, where the magic happens
class TadaState extends State<Tada>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> scale;
  late Animation<double> rotation;

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
    scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.9), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.1), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.1), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    rotation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -0.0523599),
          weight: 10), // 0 to -3 degrees
      TweenSequenceItem(
          tween: Tween(begin: -0.0523599, end: 0.0523599),
          weight: 15), // -3 to 3 degrees
      TweenSequenceItem(
          tween: Tween(begin: 0.0523599, end: -0.0523599),
          weight: 15), // 3 to -3 degrees
      TweenSequenceItem(
          tween: Tween(begin: -0.0523599, end: 0.0523599),
          weight: 15), // -3 to 3 degrees
      TweenSequenceItem(
          tween: Tween(begin: 0.0523599, end: -0.0523599),
          weight: 15), // 3 to -3 degrees
      TweenSequenceItem(
          tween: Tween(begin: -0.0523599, end: 0.0523599),
          weight: 15), // -3 to 3 degrees
      TweenSequenceItem(
          tween: Tween(begin: 0.0523599, end: 0.0),
          weight: 15), // 3 to 0 degrees
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));

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
          transform: Matrix4.identity()
            ..scale(scale.value)
            ..rotateZ(rotation.value),
          alignment: Alignment.center,
          child: widget.child,
        );
      },
    );
  }
}

extension TadaExtension on Widget {
  /// Aplica una animación de tada con opciones personalizables
  Widget tada({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    bool infinite = false,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.easeOut,
  }) {
    return Tada(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      infinite: infinite,
      onFinish: onFinish,
      curve: curve,
      child: this,
    );
  }
}
