import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 1000);
const Curve _defaultCurve = Curves.bounceOut;

/// Skews the [child] from neutral to -0.2, then to +0.2 and back to 0, in
/// three equal time slices.
class Dance extends AnimateDoBaseWidget {
  const Dance({
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
  State<Dance> createState() => DanceState();
}

class DanceState extends AnimateDoBaseState<Dance> {
  late Animation<double> _skewY;

  @override
  void createTweens() {
    _skewY = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.2, end: 0.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.2, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.skew(0, _skewY.value),
      child: child,
    );
  }
}

extension DanceExtension on Widget {
  Widget dance({
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
    return Dance(
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
