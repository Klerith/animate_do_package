import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Scales the [child] from [from] to [to] and back, mimicking the `pulse`
/// animation from Animate.css.
class Pulse extends AnimateDoBaseWidget {
  const Pulse({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 1000),
    super.delay,
    super.curve,
    super.animate,
    super.infinite,
    super.manualTrigger,
    super.loopDelay,
    super.controller,
    super.onFinish,
    super.onLoop,
    this.from = 1,
    this.to = 1.5,
  });

  final double from;
  final double to;

  @override
  State<Pulse> createState() => PulseState();
}

class PulseState extends AnimateDoBaseState<Pulse> {
  late Animation<double> _scale;

  @override
  void createTweens() {
    _scale = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(
        tween: Tween(begin: widget.from, end: widget.to),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: widget.to, end: widget.from),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.scale(scale: _scale.value, child: child);
  }
}

extension PulseExtension on Widget {
  Widget pulse({
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
    double from = 1,
    double to = 1.5,
  }) {
    return Pulse(
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
      to: to,
      child: this,
    );
  }
}
