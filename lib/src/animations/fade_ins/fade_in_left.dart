import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 800);
const double _defaultFrom = 100;

/// Fades the [child] in while sliding it from the left.
class FadeInLeft extends AnimateDoBaseWidget {
  const FadeInLeft({
    super.key,
    required super.child,
    super.duration = _defaultDuration,
    super.delay,
    super.curve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
    this.from = _defaultFrom,
  });

  /// Horizontal offset (in logical pixels) the child starts from. The value
  /// is negated internally so the animation slides in from the left.
  final double from;

  @override
  State<FadeInLeft> createState() => FadeInLeftState();
}

class FadeInLeftState extends AnimateDoBaseState<FadeInLeft> {
  late Animation<double> _translate;
  late Animation<double> _opacity;

  @override
  void createTweens() {
    _translate = Tween<double>(begin: -widget.from, end: 0).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, 0.65)),
    );
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.translate(
      offset: Offset(_translate.value, 0),
      child: Opacity(opacity: _opacity.value, child: child),
    );
  }
}

extension FadeInLeftExtension on Widget {
  Widget fadeInLeft({
    Key? key,
    Duration duration = _defaultDuration,
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = _defaultFrom,
  }) {
    return FadeInLeft(
      key: key,
      duration: duration,
      delay: delay,
      curve: curve,
      animate: animate,
      manualTrigger: manualTrigger,
      controller: controller,
      onFinish: onFinish,
      from: from,
      child: this,
    );
  }
}
