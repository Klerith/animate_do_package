import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_reset_marker.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 2500);
const Curve _defaultCurve = Curves.easeOutQuad;

/// Mimics a heartbeat by scaling the [child] up twice, like the `heartBeat`
/// animation from Animate.css.
class HeartBeat extends AnimateDoBaseWidget {
  const HeartBeat({
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
  State<HeartBeat> createState() => HeartBeatState();
}

class HeartBeatState extends AnimateDoBaseState<HeartBeat>
    with ResetOnReverseAnimation {
  late Animation<double> _scale;

  @override
  void createTweens() {
    _scale = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 14),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 14),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 14),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 28),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.scale(scale: _scale.value, child: child);
  }
}

extension HeartBeatExtension on Widget {
  Widget heartBeat({
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
    return HeartBeat(
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
