import 'dart:math' show pi;

import 'package:flutter/material.dart';

import '../../types/animate_do_mixins.dart';
import '../../types/animate_do_types.dart';

/// FlipX
class FlipX extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;
  final double perspective;

  FlipX({
    key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = const Duration(milliseconds: 0),
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.onFinish,
    this.curve = Curves.easeOut,
    this.perspective = 400.0,
  }) : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('Si desea usar manualTrigger:true, \n\n'
          'Debe proporcionar la propiedad controller, que es un callback como:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  FlipXState createState() => FlipXState();
}

/// State class, where the magic happens
class FlipXState extends State<FlipX>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late AnimationController controller;
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

    rotation = Tween<double>(begin: 0.0, end: 2 * pi)
        .animate(CurvedAnimation(parent: controller, curve: widget.curve));

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
          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()..rotateY(rotation.value),
              child: widget.child);
        });
  }
}

extension FlipXExtension on Widget {
  /// Aplica una animación flip-x con opciones personalizables
  Widget flipX({
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.easeOut,
  }) {
    return FlipX(
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
