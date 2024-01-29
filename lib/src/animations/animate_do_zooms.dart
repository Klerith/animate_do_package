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
class ZoomIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final double from;
  final Curve curve;

  ZoomIn({
    key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = const Duration(milliseconds: 0),
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.from = 1.0,
    this.onFinish,
    this.curve = Curves.easeInOutCubicEmphasized,
  }) : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  ZoomInState createState() => ZoomInState();
}

/// State class, where the magic happens
class ZoomInState extends State<ZoomIn>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> zoom;

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

    zoom = Tween(begin: 0.0, end: widget.from)
        .animate(CurvedAnimation(curve: widget.curve, parent: controller));

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
          return Transform.scale(
            scale: zoom.value,
            child: widget.child,
          );
        });
  }
}

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
class ZoomOut extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final double from;
  final Curve curve;

  ZoomOut({
    key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = const Duration(milliseconds: 0),
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.from = 0.0,
    this.onFinish,
    this.curve = Curves.easeInOutCubicEmphasized,
  }) : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  ZoomOutState createState() => ZoomOutState();
}

/// State class, where the magic happens
class ZoomOutState extends State<ZoomOut>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> zoom;

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

    zoom = Tween(begin: 1.0, end: widget.from)
        .animate(CurvedAnimation(curve: widget.curve, parent: controller));

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
          return Transform.scale(scale: zoom.value, child: widget.child);
        });
  }
}
