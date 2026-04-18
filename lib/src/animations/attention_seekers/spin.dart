import 'dart:math' show pi;

import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 1000);
const Curve _defaultCurve = Curves.linear;
const double _defaultSpins = 1;

/// Rotates the [child] [spins] full turns.
class Spin extends AnimateDoBaseWidget {
  const Spin({
    super.key,
    required super.child,
    super.duration = _defaultDuration,
    super.delay,
    super.curve = _defaultCurve,
    super.animate,
    super.infinite,
    super.manualTrigger,
    super.loopDelay,
    super.controller,
    super.onFinish,
    super.onLoop,
    this.spins = _defaultSpins,
  }) : assert(spins > 0, 'The number of spins must be greater than 0');

  final double spins;

  @override
  State<Spin> createState() => SpinState();
}

class SpinState extends AnimateDoBaseState<Spin> {
  late Animation<double> _spin;

  @override
  void createTweens() {
    _spin = Tween<double>(begin: 0, end: widget.spins).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.rotate(
      angle: _spin.value * 2 * pi,
      child: child,
    );
  }
}

extension SpinExtension on Widget {
  Widget spin({
    Key? key,
    Duration duration = _defaultDuration,
    Duration delay = Duration.zero,
    Curve curve = _defaultCurve,
    bool animate = true,
    bool infinite = false,
    bool manualTrigger = false,
    Duration loopDelay = Duration.zero,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    AnimateDoLoopCallback? onLoop,
    double spins = _defaultSpins,
  }) {
    return Spin(
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
      spins: spins,
      child: this,
    );
  }
}
