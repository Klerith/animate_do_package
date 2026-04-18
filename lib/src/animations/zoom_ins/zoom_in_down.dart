import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Scales the [child] in while sliding it down from above, mimicking the
/// `zoomInDown` animation from Animate.css.
class ZoomInDown extends AnimateDoBaseWidget {
  const ZoomInDown({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 1200),
    super.delay,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
    this.from = -1000,
  }) : super(curve: Curves.easeInOut);

  final double from;

  @override
  State<ZoomInDown> createState() => ZoomInDownState();
}

class ZoomInDownState extends AnimateDoBaseState<ZoomInDown> {
  static const Cubic _easeOutBack = Cubic(0.175, 0.885, 0.32, 1);

  late Animation<double> _opacity;
  late Animation<double> _scale;
  late Animation<double> _translate;

  @override
  void createTweens() {
    _opacity = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1, end: 1), weight: 40),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _scale = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.1, end: 0.475), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.475, end: 1.0), weight: 40),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1, curve: _easeOutBack),
      ),
    );

    _translate = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: widget.from, end: 60), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 60.0, end: 0.0), weight: 40),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1, curve: _easeOutBack),
      ),
    );
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

extension ZoomInDownExtension on Widget {
  Widget zoomInDown({
    Key? key,
    Duration duration = const Duration(milliseconds: 1200),
    Duration delay = Duration.zero,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = -1000,
  }) {
    return ZoomInDown(
      key: key,
      duration: duration,
      delay: delay,
      animate: animate,
      manualTrigger: manualTrigger,
      controller: controller,
      onFinish: onFinish,
      from: from,
      child: this,
    );
  }
}
