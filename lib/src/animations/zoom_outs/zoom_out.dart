import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Scales the [child] from 1 down to [from] while fading it out.
class ZoomOut extends AnimateDoBaseWidget {
  const ZoomOut({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 800),
    super.delay,
    super.curve = Curves.easeInOutCubicEmphasized,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
    this.from = 0.0,
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
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeInOutCubicEmphasized,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = 0.0,
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
