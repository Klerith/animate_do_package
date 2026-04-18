import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 800);
const double _defaultFrom = 100;

/// Fades the [child] in while sliding it downward.
class FadeInDown extends AnimateDoBaseWidget {
  const FadeInDown({
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

  /// Vertical offset (in logical pixels) the child starts from. The value is
  /// negated internally so the animation visually slides downward.
  final double from;

  @override
  State<FadeInDown> createState() => FadeInDownState();
}

class FadeInDownState extends AnimateDoBaseState<FadeInDown> {
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
      offset: Offset(0, _translate.value),
      child: Opacity(opacity: _opacity.value, child: child),
    );
  }
}

extension FadeInDownExtension on Widget {
  Widget fadeInDown({
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
    return FadeInDown(
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
