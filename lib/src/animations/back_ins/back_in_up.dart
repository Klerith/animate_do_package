import 'package:flutter/material.dart';

import '../../types/animate_do_mixins.dart';
import '../../types/animate_do_types.dart';

class BackInUp extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  BackInUp({
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
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'You must provide the controller property, which is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  BackInUpState createState() => BackInUpState();
}

class BackInUpState extends State<BackInUp>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> opacity;
  late Animation<double> scale;
  late Animation<double> translateY;

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
      TweenSequenceItem(tween: Tween(begin: 0, end: 0.7), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 0.7), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0), weight: 20),
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 0.7), weight: 80),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0), weight: 20),
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    translateY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: widget.from, end: 0.0), weight: 80),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 20),
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
          offset: Offset(0, translateY.value),
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

extension BackInUpExtension on Widget {
  Widget backInUp({
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
    return BackInUp(
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
