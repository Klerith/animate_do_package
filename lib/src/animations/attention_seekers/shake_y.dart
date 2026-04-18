import 'dart:math' show pi, sin;

import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Shakes the [child] vertically with a sine wave, mimicking the `shakeY`
/// animation from Animate.css.
class ShakeY extends AnimateDoBaseWidget {
  const ShakeY({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 1000),
    super.delay,
    super.curve = Curves.easeInOut,
    super.animate,
    super.infinite,
    super.manualTrigger,
    super.loopDelay,
    super.controller,
    super.onFinish,
    super.onLoop,
    this.from = 20,
  });

  final double from;

  @override
  State<ShakeY> createState() => ShakeYState();
}

class ShakeYState extends AnimateDoBaseState<ShakeY> {
  late Animation<double> _shake;

  @override
  void createTweens() {
    _shake = CurvedAnimation(parent: controller, curve: widget.curve);
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.translate(
      offset: Offset(0, sin(4 * pi * _shake.value) * widget.from),
      child: child,
    );
  }
}

extension ShakeYExtension on Widget {
  Widget shakeY({
    Key? key,
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool infinite = false,
    bool manualTrigger = false,
    Duration loopDelay = Duration.zero,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    AnimateDoLoopCallback? onLoop,
    double from = 10,
  }) {
    return ShakeY(
      key: key,
      duration: duration,
      delay: delay,
      curve: curve,
      animate: animate,
      infinite: infinite,
      manualTrigger: manualTrigger,
      loopDelay: loopDelay,
      controller: controller,
      onFinish: onFinish,
      onLoop: onLoop,
      from: from,
      child: this,
    );
  }
}
