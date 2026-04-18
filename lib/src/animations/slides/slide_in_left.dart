import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 600);
const double _defaultFrom = 100;

/// Slides the [child] from the left to its final position, without changing
/// its opacity.
class SlideInLeft extends AnimateDoBaseWidget {
  const SlideInLeft({
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
  State<SlideInLeft> createState() => SlideInLeftState();
}

class SlideInLeftState extends AnimateDoBaseState<SlideInLeft> {
  late Animation<double> _translate;

  @override
  void createTweens() {
    _translate = Tween<double>(begin: widget.from * -1, end: 0).animate(
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

extension SlideInLeftExtension on Widget {
  Widget slideInLeft({
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
    return SlideInLeft(
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
