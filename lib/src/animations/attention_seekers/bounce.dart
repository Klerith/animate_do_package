import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_reset_marker.dart';
import '../../types/animate_do_typedefs.dart';

/// Slides the [child] up by [from] pixels and then bounces it back into place,
/// mimicking the `bounce` animation from Animate.css.
class Bounce extends AnimateDoBaseWidget {
  const Bounce({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 1300),
    super.delay,
    super.curve = Curves.bounceOut,
    super.animate,
    super.infinite,
    super.manualTrigger,
    super.loopDelay,
    super.controller,
    super.onFinish,
    super.onLoop,
    this.from = 50,
  });

  final double from;

  @override
  State<Bounce> createState() => BounceState();
}

class BounceState extends AnimateDoBaseState<Bounce>
    with ResetOnReverseAnimation {
  late Animation<double> _up;
  late Animation<double> _bounce;

  @override
  void createTweens() {
    _up = Tween<double>(begin: 0, end: widget.from * -1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.35, curve: Curves.easeInOut),
      ),
    );
    _bounce = Tween<double>(begin: widget.from * -1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.35, 1, curve: widget.curve),
      ),
    );
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    final double offsetY =
        _up.value == widget.from * -1 ? _bounce.value : _up.value;
    return Transform.translate(
      offset: Offset(0, offsetY),
      child: child,
    );
  }
}

extension BounceExtension on Widget {
  Widget bounce({
    Key? key,
    Duration duration = const Duration(milliseconds: 1300),
    Duration delay = Duration.zero,
    Curve curve = Curves.bounceOut,
    bool animate = true,
    bool infinite = false,
    bool manualTrigger = false,
    Duration loopDelay = Duration.zero,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    AnimateDoLoopCallback? onLoop,
    double from = 50,
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
