import 'package:flutter/material.dart';

import '../../types/animate_do_mixins.dart';
import '../../types/animate_do_types.dart';

class BackOutLeft extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  BackOutLeft({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1200),
    this.delay = Duration.zero,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.onFinish,
    this.from = 1000,
    this.curve = Curves.easeOut,
  }) : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('Si quieres usar manualTrigger:true, \n\n'
          'Debes proporcionar la propiedad controller, que es un callback como:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  BackOutLeftState createState() => BackOutLeftState();
}

class BackOutLeftState extends State<BackOutLeft>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> opacity;
  late Animation<double> scale;
  late Animation<double> translateX;

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

    opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 0.7), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 0.0), weight: 20),
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 0.7), weight: 80),
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    translateX = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 20),
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -widget.from), weight: 80),
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    configAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      onFinish: widget.onFinish,
      infinite: false,
      controllerCallback: widget.controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    buildAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      onFinish: widget.onFinish,
      infinite: false,
      controllerCallback: widget.controller,
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(translateX.value, 0),
          child: Transform.scale(
            scale: scale.value,
            child: Opacity(
              opacity: opacity.value,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

extension BackOutLeftExtension on Widget {
  Widget backOutLeft({
    Key? key,
    Duration duration = const Duration(milliseconds: 1200),
    Duration delay = Duration.zero,
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    bool infinite = false,
    double from = 1000,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.easeOut,
  }) {
    return BackOutLeft(
      key: key,
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      onFinish: onFinish,
      from: from,
      curve: curve,
      child: this,
    );
  }
}
