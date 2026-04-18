import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_reset_marker.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 1000);
const Curve _defaultCurve = Curves.easeOut;

/// Rocks the [child] back and forth from its top edge, mimicking the `swing`
/// animation from Animate.css.
class Swing extends AnimateDoBaseWidget {
  const Swing({
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
  State<Swing> createState() => SwingState();
}

class SwingState extends AnimateDoBaseState<Swing>
    with ResetOnReverseAnimation {
  late Animation<double> _rotation;

  @override
  void createTweens() {
    _rotation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.261799), weight: 20),
      TweenSequenceItem(
        tween: Tween(begin: 0.261799, end: -0.174533),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.174533, end: 0.087266),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.087266, end: -0.087266),
        weight: 20,
      ),
      TweenSequenceItem(tween: Tween(begin: -0.087266, end: 0.0), weight: 20),
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform(
      transform: Matrix4.identity()..rotateZ(_rotation.value),
      alignment: Alignment.topCenter,
      child: child,
    );
  }
}

extension SwingExtension on Widget {
  Widget swing({
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
    return Swing(
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
