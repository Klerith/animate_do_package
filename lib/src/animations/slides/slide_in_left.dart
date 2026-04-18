import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Slides the [child] from the left to its final position, without changing
/// its opacity.
class SlideInLeft extends AnimateDoBaseWidget {
  const SlideInLeft({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 600),
    super.delay,
    super.curve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
    this.from = 100,
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
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double from = 100,
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
