import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Fades the [child] in while sliding it from the right.
class FadeInRight extends AnimateDoBaseWidget {
  const FadeInRight({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 800),
    super.delay,
    super.curve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
    this.from = 100,
  });

  /// Horizontal offset (in logical pixels) the child starts from.
  final double from;

  @override
  State<FadeInRight> createState() => FadeInRightState();
}

class FadeInRightState extends AnimateDoBaseState<FadeInRight> {
  late Animation<double> _translate;
  late Animation<double> _opacity;

  @override
  void createTweens() {
    _translate = Tween<double>(begin: widget.from, end: 0).animate(
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

extension FadeInRightExtension on Widget {
  Widget fadeInRight({
    Key? key,
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = 100,
  }) {
    return FadeInRight(
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
