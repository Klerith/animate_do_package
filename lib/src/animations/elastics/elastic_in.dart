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
class ElasticIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  ElasticIn(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1500),
      this.delay = Duration.zero,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.onFinish,
      this.curve = Curves.elasticOut})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  ElasticInState createState() => ElasticInState();
}

/// StateClass, where the magic happens
class ElasticInState extends State<ElasticIn>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> bouncing;
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

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.45)));

    bouncing = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: widget.curve));

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
            scale: bouncing.value,
            child: Opacity(
              opacity: opacity.value,
              child: widget.child,
            ),
          );
        });
  }
}

extension ElasticInExtension on Widget {
  /// Aplica una animación elastic-in con opciones personalizables
  Widget elasticIn({
    Duration duration = const Duration(milliseconds: 1500),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.elasticOut,
  }) {
    return ElasticIn(
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
