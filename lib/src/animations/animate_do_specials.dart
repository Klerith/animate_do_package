import 'package:flutter/material.dart';

import '../types/animate_do_mixins.dart';
import '../types/animate_do_types.dart';

/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// [manualTrigger]: boolean that indicates if you want to trigger the animation manually with the controller
/// [animate]: For a State controller property, if you re-render changing it from false to true, the animation will be fired immediately
/// [onFinish]: callback that returns the direction of the animation, [AnimateDoDirection.forward] or [AnimateDoDirection.backward]
/// [curve]: curve for the animation
/// [from]: starting point for the animation
class JelloIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  JelloIn(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 800),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
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
  JelloInState createState() => JelloInState();
}

/// State class, where the magic happens
class JelloInState extends State<JelloIn>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> rotation;
  late Animation<double> opacity;

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

    rotation = Tween<double>(begin: 1.5, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: widget.curve));

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.65)));

    /// Provided by the mixing [AnimateDoState] class
    configAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      infinite: false,
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
      infinite: false,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
    );

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(0, 0, rotation.value + 1)
                ..rotateX(rotation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}


/// RubberBand
class RubberBand extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  RubberBand({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 2000),
    this.delay = Duration.zero,
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
  RubberBandState createState() => RubberBandState();
}

class RubberBandState extends State<RubberBand>
    with SingleTickerProviderStateMixin, AnimateDoState {
  
  late Animation<double> _scaleX;
  late Animation<double> _scaleY;

  @override
  void dispose() {
    disposed = true;
    controller.dispose(); // Usar _controller
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    // Definir las animaciones para scaleX y scaleY
    _scaleX = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.25), weight: 30),
        TweenSequenceItem(tween: Tween<double>(begin: 1.25, end: 0.75), weight: 10),
        TweenSequenceItem(tween: Tween<double>(begin: 0.75, end: 1.15), weight: 10),
        TweenSequenceItem(tween: Tween<double>(begin: 1.15, end: 0.95), weight: 15),
        TweenSequenceItem(tween: Tween<double>(begin: 0.95, end: 1.05), weight: 10),
        TweenSequenceItem(tween: Tween<double>(begin: 1.05, end: 1.0), weight: 25),
      ],
    ).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    _scaleY = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.75), weight: 30),
        TweenSequenceItem(tween: Tween<double>(begin: 0.75, end: 1.25), weight: 10),
        TweenSequenceItem(tween: Tween<double>(begin: 1.25, end: 0.85), weight: 10),
        TweenSequenceItem(tween: Tween<double>(begin: 0.85, end: 1.05), weight: 15),
        TweenSequenceItem(tween: Tween<double>(begin: 1.05, end: 0.95), weight: 10),
        TweenSequenceItem(tween: Tween<double>(begin: 0.95, end: 1.0), weight: 25),
      ],
    ).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    /// Configura la animación
    configAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      infinite: false,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Construye la animación
    buildAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      infinite: false,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scaleX: _scaleX.value,
          scaleY: _scaleY.value,
          child: widget.child,
        );
      },
    );
  }
}