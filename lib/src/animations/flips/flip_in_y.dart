import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Flips the [child] around the Y axis while fading it in, mimicking the
/// `flipInY` animation from Animate.css.
class FlipInY extends AnimateDoBaseWidget {
  const FlipInY({
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
  State<FlipInY> createState() => FlipInYState();
}

class FlipInYState extends AnimateDoBaseState<FlipInY> {
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
      transform: Matrix4.identity()..rotateY(_rotation.value),
      child: Opacity(opacity: _opacity.value, child: child),
    );
  }
}

extension FlipInYExtension on Widget {
  Widget flipInY({
    Key? key,
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
  }) {
    return FlipInY(
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
