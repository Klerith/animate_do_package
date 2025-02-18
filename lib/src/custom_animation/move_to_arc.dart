import 'dart:math' show pi, cos;

import 'package:flutter/material.dart';

import '../types/animate_do_mixins.dart';
import '../types/animate_do_types.dart';

class MoveToArc extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  /// Arc movement parameters in pixels
  final double top;
  final double bottom;
  final double left;
  final double right;

  MoveToArc({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = const Duration(milliseconds: 0),
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.onFinish,
    this.curve = Curves.easeOut,
    this.top = 0.0,
    this.bottom = 0.0,
    this.left = 0.0,
    this.right = 0.0,
  }) : super(key: key) {
    // Ensure controller is provided if manualTrigger is enabled
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you use manualTrigger: true, \n\n'
          'you must provide the controller property like this:\n\n'
          ' (controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _MoveToArcState createState() => _MoveToArcState();
}

class _MoveToArcState extends State<MoveToArc>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> animationT;

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

    // Create animation parameter 't' (progress from 0 to 1)
    animationT = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    // Configure animation using AnimateDoState
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
    // Build animation with AnimateDoState
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
        double t = animationT.value;
        double angle = t * pi / 2;

        // Calculate arc movement
        double radius = widget.bottom > 0 ? widget.bottom : widget.top;
        // double x = radius * sin(angle);
        double y = radius * (1 - cos(angle));

        // Apply horizontal movement
        double horizontalMovement = 0;
        if (widget.left > 0) {
          horizontalMovement = -widget.left * t;
        } else if (widget.right > 0) {
          horizontalMovement = widget.right * t;
        }
        
        // Invert vertical direction if moving up
        if (widget.top > 0) {
          y = -y;
        }

        return Transform.translate(
          offset: Offset(horizontalMovement, y),
          child: widget.child,
        );
      },
    );
  }
}

extension MoveArcExtension on Widget {
  Widget moveToArc({
    Key? key,
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    bool infinite = false,
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.easeOut,
  }) {
    return MoveToArc(
      key: key,
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      onFinish: onFinish,
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      curve: curve,
      child: this,
    );
  }
}