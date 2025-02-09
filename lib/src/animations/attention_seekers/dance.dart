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
class Dance extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  Dance(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
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
  DanceState createState() => DanceState();
}

/// State class, where the magic happens
class DanceState extends State<Dance>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> step1;
  late Animation<double> step2;
  late Animation<double> step3;

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

    step1 = Tween<double>(begin: 0, end: -0.2).animate(CurvedAnimation(
        parent: controller, curve: Interval(0, 0.3333, curve: widget.curve)));

    step2 = Tween<double>(begin: -0.2, end: 0.2).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.3333, 0.6666, curve: widget.curve)));

    step3 = Tween<double>(begin: 0.2, end: 0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.6666, 1, curve: widget.curve)));

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
          final animation = (step1.value != -0.2)
              ? step1.value
              : (step2.value != 0.2)
                  ? step2.value
                  : step3.value;

          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.skew(0, animation),
              child: widget.child);
        });
  }
}
