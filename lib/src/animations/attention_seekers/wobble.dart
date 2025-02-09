import 'package:flutter/material.dart';

import '../../types/animate_do_mixins.dart';
import '../../types/animate_do_types.dart';

class Wobble extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  Wobble(
      {Key? key,
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
  WobbleState createState() => WobbleState();
}

class WobbleState extends State<Wobble>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> translateX;
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
    translateX = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -0.15), weight: 15), // -15%
      TweenSequenceItem(
          tween: Tween(begin: -0.15, end: 0.12), weight: 15), // 12%
      TweenSequenceItem(
          tween: Tween(begin: 0.12, end: -0.09), weight: 15), // -9%
      TweenSequenceItem(
          tween: Tween(begin: -0.09, end: 0.06), weight: 15), // 6%
      TweenSequenceItem(
          tween: Tween(begin: 0.06, end: -0.03), weight: 15), // -3%
      TweenSequenceItem(tween: Tween(begin: -0.03, end: 0.0), weight: 25), // 0%
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    rotation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -0.0872665), weight: 15), // -5 deg
      TweenSequenceItem(
          tween: Tween(begin: -0.0872665, end: 0.0523599), weight: 15), // 3 deg
      TweenSequenceItem(
          tween: Tween(begin: 0.0523599, end: -0.0523599),
          weight: 15), // -3 deg
      TweenSequenceItem(
          tween: Tween(begin: -0.0523599, end: 0.0349066), weight: 15), // 2 deg
      TweenSequenceItem(
          tween: Tween(begin: 0.0349066, end: -0.0174533),
          weight: 15), // -1 deg
      TweenSequenceItem(
          tween: Tween(begin: -0.0174533, end: 0.0), weight: 25), // 0 deg
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
            ..translate(translateX.value * MediaQuery.of(context).size.width)
            ..rotateZ(rotation.value),
          alignment: Alignment.center,
          child: widget.child,
        );
      },
    );
  }
}

extension WobbleExtension on Widget {
  /// Aplica una animación de tambaleo con opciones personalizables
  Widget wobble({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    bool infinite = false,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.easeOut,
  }) {
    return Wobble(
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
