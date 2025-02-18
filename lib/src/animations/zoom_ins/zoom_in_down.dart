import 'package:flutter/material.dart';

import '../../types/animate_do_mixins.dart';
import '../../types/animate_do_types.dart';

class ZoomInDown extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final Function(AnimateDoDirection direction)? onFinish;

  ZoomInDown({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1200),
    this.delay = Duration.zero,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.from = -1000,
    this.onFinish,
  }) : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'You must provide the controller property, which is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  ZoomInDownState createState() => ZoomInDownState();
}

class ZoomInDownState extends State<ZoomInDown>
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
      TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1, end: 1), weight: 40),
    ]).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0, 0.6, curve: Curves.easeInOut),
    ));

    scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.1, end: 0.475), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.475, end: 1.0), weight: 40),
    ]).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0,
        1,
        curve: Cubic(0.175, 0.885, 0.32, 1),
      ),
    ));

    translateY = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: widget.from, end: 60), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 60, end: 0), weight: 40),
    ]).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0,
        1,
        curve: Cubic(0.175, 0.885, 0.32, 1),
      ),
    ));

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

extension ZoomInDownExtension on Widget {
  Widget zoomInDown({
    Key? key,
    Duration duration = const Duration(milliseconds: 1200),
    Duration delay = Duration.zero,
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    double from = -1000,
    Function(AnimateDoDirection direction)? onFinish,
  }) {
    return ZoomInDown(
      key: key,
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from,
      onFinish: onFinish,
      child: this,
    );
  }
}
