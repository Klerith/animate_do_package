import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_reset_marker.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 2000);
const Curve _defaultCurve = Curves.easeOut;

/// Stretches the [child] horizontally and vertically with decaying amplitude,
/// mimicking the `rubberBand` animation from Animate.css.
class RubberBand extends AnimateDoBaseWidget {
  const RubberBand({
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
  State<RubberBand> createState() => RubberBandState();
}

class RubberBandState extends AnimateDoBaseState<RubberBand>
    with ResetOnReverseAnimation {
  late Animation<double> _scaleX;
  late Animation<double> _scaleY;

  @override
  void createTweens() {
    final CurvedAnimation curved =
        CurvedAnimation(parent: controller, curve: widget.curve);

    _scaleX = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.25), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.25, end: 0.75), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.75, end: 1.15), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 0.95), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.05), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 25),
    ]).animate(curved);

    _scaleY = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.75), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.75, end: 1.25), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 1.25, end: 0.85), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.05), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 0.95), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 25),
    ]).animate(curved);
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.scale(
      scaleX: _scaleX.value,
      scaleY: _scaleY.value,
      child: child,
    );
  }
}

extension RubberBandExtension on Widget {
  Widget rubberBand({
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
    return RubberBand(
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
