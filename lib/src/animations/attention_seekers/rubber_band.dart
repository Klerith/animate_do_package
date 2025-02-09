import 'package:flutter/material.dart';

import '../../types/animate_do_mixins.dart';
import '../../types/animate_do_types.dart';

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
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 1.25), weight: 30),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.25, end: 0.75), weight: 10),
        TweenSequenceItem(
            tween: Tween<double>(begin: 0.75, end: 1.15), weight: 10),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.15, end: 0.95), weight: 15),
        TweenSequenceItem(
            tween: Tween<double>(begin: 0.95, end: 1.05), weight: 10),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.05, end: 1.0), weight: 25),
      ],
    ).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    _scaleY = TweenSequence<double>(
      [
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 0.75), weight: 30),
        TweenSequenceItem(
            tween: Tween<double>(begin: 0.75, end: 1.25), weight: 10),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.25, end: 0.85), weight: 10),
        TweenSequenceItem(
            tween: Tween<double>(begin: 0.85, end: 1.05), weight: 15),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.05, end: 0.95), weight: 10),
        TweenSequenceItem(
            tween: Tween<double>(begin: 0.95, end: 1.0), weight: 25),
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

extension RubberBandExtension on Widget {
  /// Aplica una animación de banda elástica con opciones personalizables
  Widget rubberBand({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    bool infinite = false,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.easeOut,
  }) {
    return RubberBand(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      onFinish: onFinish,
      curve: curve,
      child: this,
    );
  }
}
