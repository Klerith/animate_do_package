import 'package:flutter/material.dart';

import '../types/animate_do_mixins.dart';
import '../types/animate_do_types.dart';

/// Class [ZoomIn]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
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
  late AnimationController controller;
  bool disposed = false;
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
      controller: controller,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      delay: widget.delay,
      disposed: disposed,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Provided by the mixing [AnimateDoState] class
    buildAnimation(
      controller: controller,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      delay: widget.delay,
      disposed: disposed,
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

/// Class [ZoomOut]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
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
  late AnimationController controller;
  bool disposed = false;
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
      controller: controller,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      delay: widget.delay,
      disposed: disposed,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Provided by the mixing [AnimateDoState] class
    buildAnimation(
      controller: controller,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      delay: widget.delay,
      disposed: disposed,
    );

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(scale: zoom.value, child: widget.child);
        });
  }
}
