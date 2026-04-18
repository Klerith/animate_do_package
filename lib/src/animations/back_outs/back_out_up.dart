import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Mirrors [BackInUp]: shrinks the [child] and slides it upward while fading
/// out.
class BackOutUp extends AnimateDoBaseWidget {
  const BackOutUp({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 1200),
    super.delay,
    super.curve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
    this.to = 1000,
  });

  /// Final vertical offset (in logical pixels). The value is negated
  /// internally so the widget visually slides upward.
  final double to;

  @override
  State<BackOutUp> createState() => BackOutUpState();
}

class BackOutUpState extends AnimateDoBaseState<BackOutUp> {
  late Animation<double> _opacity;
  late Animation<double> _scale;
  late Animation<double> _translate;

  @override
  void createTweens() {
    final CurvedAnimation curved =
        CurvedAnimation(parent: controller, curve: widget.curve);

    _opacity = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 0.7), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 0.0), weight: 20),
    ]).animate(curved);

    _scale = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 0.7), weight: 80),
    ]).animate(curved);

    _translate = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -widget.to), weight: 80),
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

extension BackOutUpExtension on Widget {
  Widget backOutUp({
    Key? key,
    Duration duration = const Duration(milliseconds: 1200),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double to = 1000,
  }) {
    return BackOutUp(
      key: key,
      duration: duration,
      delay: delay,
      curve: curve,
      animate: animate,
      manualTrigger: manualTrigger,
      controller: controller,
      onFinish: onFinish,
      to: to,
      child: this,
    );
  }
}
