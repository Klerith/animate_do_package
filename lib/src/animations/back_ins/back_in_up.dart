import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Combines a small fade-in with a downward slide, mimicking the
/// `backInUp` animation from Animate.css.
class BackInUp extends AnimateDoBaseWidget {
  const BackInUp({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 1200),
    super.delay,
    super.curve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
    this.from = 1000,
  });

  /// Vertical offset (in logical pixels) the child starts from.
  final double from;

  @override
  State<BackInUp> createState() => BackInUpState();
}

class BackInUpState extends AnimateDoBaseState<BackInUp> {
  late Animation<double> _opacity;
  late Animation<double> _scale;
  late Animation<double> _translate;

  @override
  void createTweens() {
    final CurvedAnimation curved =
        CurvedAnimation(parent: controller, curve: widget.curve);

    _opacity = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0, end: 0.7), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 0.7), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0), weight: 20),
    ]).animate(curved);

    _scale = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 0.7), weight: 80),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0), weight: 20),
    ]).animate(curved);

    _translate = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(
        tween: Tween(begin: widget.from, end: 0.0),
        weight: 80,
      ),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 20),
    ]).animate(curved);
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.translate(
      offset: Offset(0, _translate.value),
      child: Transform.scale(
        scale: _scale.value,
        child: Opacity(opacity: _opacity.value, child: child),
      ),
    );
  }
}

extension BackInUpExtension on Widget {
  Widget backInUp({
    Key? key,
    Duration duration = const Duration(milliseconds: 1200),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = 1000,
  }) {
    return BackInUp(
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
