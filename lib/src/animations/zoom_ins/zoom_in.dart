import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 800);
const Curve _defaultCurve = Curves.easeInOutCubicEmphasized;
const double _defaultFrom = 1.0;

/// Scales the [child] from 0 to [from] while fading it in.
class ZoomIn extends AnimateDoBaseWidget {
  const ZoomIn({
    super.key,
    required super.child,
    super.duration = _defaultDuration,
    super.delay,
    super.curve = _defaultCurve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
    this.from = _defaultFrom,
  });

  final double from;

  @override
  State<ZoomIn> createState() => ZoomInState();
}

class ZoomInState extends AnimateDoBaseState<ZoomIn> {
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void createTweens() {
    _scale = Tween<double>(begin: 0, end: widget.from).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, 0.25)),
    );
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.scale(
      scale: _scale.value,
      child: Opacity(opacity: _opacity.value, child: child),
    );
  }
}

extension ZoomInExtension on Widget {
  Widget zoomIn({
    Key? key,
    Duration duration = _defaultDuration,
    Duration delay = Duration.zero,
    Curve curve = _defaultCurve,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = _defaultFrom,
  }) {
    return ZoomIn(
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
