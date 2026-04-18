import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 800);
const Curve _defaultCurve = Curves.bounceOut;

/// Stretches and rotates the [child] into place while fading it in, mimicking
/// the `jelloIn` style entrance from Animate.css.
class JelloIn extends AnimateDoBaseWidget {
  const JelloIn({
    super.key,
    required super.child,
    super.duration = _defaultDuration,
    super.delay,
    super.curve = _defaultCurve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
  });

  @override
  State<JelloIn> createState() => JelloInState();
}

class JelloInState extends AnimateDoBaseState<JelloIn> {
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
      transform: Matrix4.identity()
        ..setEntry(0, 0, _rotation.value + 1)
        ..rotateX(_rotation.value),
      child: Opacity(opacity: _opacity.value, child: child),
    );
  }
}

extension JelloInExtension on Widget {
  Widget jelloIn({
    Key? key,
    Duration duration = _defaultDuration,
    Duration delay = Duration.zero,
    Curve curve = _defaultCurve,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
  }) {
    return JelloIn(
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
