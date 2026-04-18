import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_reset_marker.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 1300);
const Curve _defaultCurve = Curves.bounceOut;
const double _defaultFrom = 50;

/// Slides the [child] up by [from] pixels and then bounces it back into place,
/// mimicking the `bounce` animation from Animate.css.
class Bounce extends AnimateDoBaseWidget {
  const Bounce({
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
    this.from = _defaultFrom,
  });

  final double from;

  @override
  State<Bounce> createState() => BounceState();
}

class BounceState extends AnimateDoBaseState<Bounce>
    with ResetOnReverseAnimation {
  late Animation<double> _offsetY;

  @override
  void createTweens() {
    final double peak = -widget.from;
    _offsetY = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: peak)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 35,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: peak, end: 0)
            .chain(CurveTween(curve: widget.curve)),
        weight: 65,
      ),
    ]).animate(controller);
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.translate(
      offset: Offset(0, _offsetY.value),
      child: child,
    );
  }
}

extension BounceExtension on Widget {
  Widget bounce({
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
    double from = _defaultFrom,
  }) {
    return Bounce(
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
