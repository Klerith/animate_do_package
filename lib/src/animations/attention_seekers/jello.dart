import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_reset_marker.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 1200);
const Curve _defaultCurve = Curves.easeOut;

/// Skews the [child] in alternating directions with decreasing amplitude,
/// mimicking the `jello` animation from Animate.css.
class Jello extends AnimateDoBaseWidget {
  const Jello({
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
  });

  @override
  State<Jello> createState() => JelloState();
}

class JelloState extends AnimateDoBaseState<Jello>
    with ResetOnReverseAnimation {
  static const double _degreesToRadians = 0.0174533;

  late Animation<double> _skewX;
  late Animation<double> _skewY;

  @override
  void createTweens() {
    final TweenSequence<double> sequence =
        TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -12.5), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: -12.5, end: 6.25), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: 6.25, end: -3.125), weight: 11.1),
      TweenSequenceItem(tween: Tween(begin: -3.125, end: 1.5625), weight: 11.1),
      TweenSequenceItem(
        tween: Tween(begin: 1.5625, end: -0.78125),
        weight: 11.1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.78125, end: 0.390625),
        weight: 11.1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.390625, end: -0.1953125),
        weight: 11.1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.1953125, end: 0.0),
        weight: 11.2,
      ),
    ]);

    final CurvedAnimation curved =
        CurvedAnimation(parent: controller, curve: widget.curve);

    _skewX = sequence.animate(curved);
    _skewY = sequence.animate(curved);
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform(
      transform: Matrix4.skew(
        _skewX.value * _degreesToRadians,
        _skewY.value * _degreesToRadians,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

extension JelloExtension on Widget {
  Widget jello({
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
  }) {
    return Jello(
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
      child: this,
    );
  }
}
