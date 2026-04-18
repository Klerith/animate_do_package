import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 800);
const Curve _defaultCurve = Curves.easeInOutCubicEmphasized;
const double _defaultFrom = 0.0;

/// Scales the [child] from 1 down to [from] while fading it out.
class ZoomOut extends AnimateDoBaseWidget {
  const ZoomOut({
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
  State<ZoomOut> createState() => ZoomOutState();
}

class ZoomOutState extends AnimateDoBaseState<ZoomOut> {
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void createTweens() {
    _scale = Tween<double>(begin: 1, end: widget.from).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );
    _opacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, 0.85)),
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

extension ZoomOutExtension on Widget {
  Widget zoomOut({
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
    return ZoomOut(
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
