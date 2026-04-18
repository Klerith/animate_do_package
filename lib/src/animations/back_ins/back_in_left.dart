import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Combines a small fade-in with a slide from the left, mimicking the
/// `backInLeft` animation from Animate.css.
class BackInLeft extends AnimateDoBaseWidget {
  const BackInLeft({
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

  /// Horizontal offset (in logical pixels) the child starts from. The value
  /// is negated internally so the widget visually slides in from the left.
  final double from;

  @override
  State<BackInLeft> createState() => BackInLeftState();
}

class BackInLeftState extends AnimateDoBaseState<BackInLeft> {
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
        tween: Tween(begin: -widget.from, end: 0.0),
        weight: 80,
      ),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 20),
    ]).animate(curved);
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.translate(
      offset: Offset(_translate.value, 0),
      child: Transform.scale(
        scale: _scale.value,
        child: Opacity(opacity: _opacity.value, child: child),
      ),
    );
  }
}

extension BackInLeftExtension on Widget {
  Widget backInLeft({
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
    return BackInLeft(
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
