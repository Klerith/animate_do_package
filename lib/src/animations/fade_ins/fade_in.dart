import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Fades the [child] in by animating its opacity from 0 to 1.
class FadeIn extends AnimateDoBaseWidget {
  const FadeIn({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 300),
    super.delay,
    super.curve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
  });

  @override
  State<FadeIn> createState() => FadeInState();
}

class FadeInState extends AnimateDoBaseState<FadeIn> {
  late Animation<double> _opacity;

  @override
  void createTweens() {
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Opacity(opacity: _opacity.value, child: child);
  }
}

extension FadeInExtension on Widget {
  /// Wraps the widget with a [FadeIn] animation.
  Widget fadeIn({
    Key? key,
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
  }) {
    return FadeIn(
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
