import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 600);
const double _defaultFrom = 100;

/// Slides the [child] from the right to its final position, without changing
/// its opacity.
class SlideInRight extends AnimateDoBaseWidget {
  const SlideInRight({
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

  final double from;

  @override
  State<SlideInRight> createState() => SlideInRightState();
}

class SlideInRightState extends AnimateDoBaseState<SlideInRight> {
  late Animation<double> _translate;

  @override
  void createTweens() {
    _translate = Tween<double>(begin: widget.from, end: 0).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.translate(
      offset: Offset(_translate.value, 0),
      child: child,
    );
  }
}

extension SlideInRightExtension on Widget {
  Widget slideInRight({
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
    return SlideInRight(
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
