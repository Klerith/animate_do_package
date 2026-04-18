import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 1000);
const Curve _defaultCurve = Curves.linearToEaseOut;

/// Quickly fades the [child] in and out twice, mimicking the `flash`
/// animation from Animate.css.
class Flash extends AnimateDoBaseWidget {
  const Flash({
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
  State<Flash> createState() => FlashState();
}

class FlashState extends AnimateDoBaseState<Flash> {
  late Animation<double> _opacity;

  @override
  void createTweens() {
    _opacity = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1, end: 0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1, end: 0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 25),
    ]).animate(CurvedAnimation(parent: controller, curve: widget.curve));
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Opacity(opacity: _opacity.value, child: child);
  }
}

extension FlashExtension on Widget {
  Widget flash({
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
    return Flash(
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
