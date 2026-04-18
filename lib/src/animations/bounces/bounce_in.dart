import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Scales the [child] in with an overshoot/bounce effect, mimicking the
/// `bounceIn` animation from Animate.css.
class BounceIn extends AnimateDoBaseWidget {
  const BounceIn({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 750),
    super.delay,
    super.curve = Curves.easeOutCubic,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
  });

  @override
  State<BounceIn> createState() => BounceInState();
}

class BounceInState extends AnimateDoBaseState<BounceIn> {
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void createTweens() {
    final CurvedAnimation curved =
        CurvedAnimation(parent: controller, curve: widget.curve);

    _scale = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 1.1), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 0.9), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.03), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.03, end: 0.97), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.97, end: 1.0), weight: 20),
    ]).animate(curved);

    _opacity = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 40),
    ]).animate(curved);
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.scale(
      scale: _scale.value,
      alignment: Alignment.center,
      child: Opacity(opacity: _opacity.value, child: child),
    );
  }
}

extension BounceInExtension on Widget {
  Widget bounceIn({
    Key? key,
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = Duration.zero,
    Curve curve = Curves.bounceOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
  }) {
    return BounceIn(
      key: key,
      duration: duration,
      delay: delay,
      curve: curve,
      animate: animate,
      manualTrigger: manualTrigger,
      controller: controller,
      onFinish: onFinish,
      child: this,
    );
  }
}
