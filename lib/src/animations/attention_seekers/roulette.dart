import 'dart:math' show pi;

import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 3500);
const Curve _defaultCurve = Curves.elasticOut;
const double _defaultSpins = 2;

/// Rotates the [child] [spins] half turns and overshoots/elastic-stops at the
/// end (the default curve is [Curves.elasticOut]).
class Roulette extends AnimateDoBaseWidget {
  const Roulette({
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
  });

  final double spins;

  @override
  State<Roulette> createState() => RouletteState();
}

class RouletteState extends AnimateDoBaseState<Roulette> {
  late Animation<double> _spin;

  @override
  void createTweens() {
    _spin = Tween<double>(begin: 0, end: widget.spins * 2).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.rotate(
      angle: _spin.value * pi,
      child: child,
    );
  }
}

extension RouletteExtension on Widget {
  Widget roulette({
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
    return Roulette(
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
