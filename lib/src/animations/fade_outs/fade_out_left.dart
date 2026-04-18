import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Fades the [child] out while sliding it to the left.
class FadeOutLeft extends AnimateDoBaseWidget {
  const FadeOutLeft({
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

  /// Horizontal offset (in logical pixels) the child ends at. The value is
  /// negated internally so the widget visually slides to the left.
  final double from;

  @override
  State<FadeOutLeft> createState() => FadeOutLeftState();
}

class FadeOutLeftState extends AnimateDoBaseState<FadeOutLeft> {
  late Animation<double> _translate;
  late Animation<double> _opacity;

  @override
  void createTweens() {
    _translate = Tween<double>(begin: 0, end: -widget.from).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );
    _opacity = Tween<double>(begin: 1, end: 0).animate(
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

extension FadeOutLeftExtension on Widget {
  Widget fadeOutLeft({
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
    return FadeOutLeft(
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
