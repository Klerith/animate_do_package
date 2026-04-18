import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Scales the [child] in with an elastic curve while fading it in.
class ElasticIn extends AnimateDoBaseWidget {
  const ElasticIn({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 1500),
    super.delay,
    super.curve = Curves.elasticOut,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
  });

  @override
  State<ElasticIn> createState() => ElasticInState();
}

class ElasticInState extends AnimateDoBaseState<ElasticIn> {
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void createTweens() {
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, 0.45)),
    );
    _scale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
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

extension ElasticInExtension on Widget {
  Widget elasticIn({
    Key? key,
    Duration duration = const Duration(milliseconds: 1500),
    Duration delay = Duration.zero,
    Curve curve = Curves.elasticOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
  }) {
    return ElasticIn(
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
