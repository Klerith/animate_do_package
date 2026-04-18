import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Flips the [child] around the X axis while fading it in, mimicking the
/// `flipInX` animation from Animate.css.
class FlipInX extends AnimateDoBaseWidget {
  const FlipInX({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 800),
    super.delay,
    super.curve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
  });

  @override
  State<FlipInX> createState() => FlipInXState();
}

class FlipInXState extends AnimateDoBaseState<FlipInX> {
  late Animation<double> _rotation;
  late Animation<double> _opacity;

  @override
  void createTweens() {
    _rotation = Tween<double>(begin: 1.5, end: 0).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, 0.65)),
    );
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()..rotateX(_rotation.value),
      child: Opacity(opacity: _opacity.value, child: child),
    );
  }
}

extension FlipInXExtension on Widget {
  Widget flipInX({
    Key? key,
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
  }) {
    return FlipInX(
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
