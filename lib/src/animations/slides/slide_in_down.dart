import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Slides the [child] from above to its final position, without changing its
/// opacity.
class SlideInDown extends AnimateDoBaseWidget {
  const SlideInDown({
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
  State<SlideInDown> createState() => SlideInDownState();
}

class SlideInDownState extends AnimateDoBaseState<SlideInDown> {
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
      offset: Offset(0, _translate.value),
      child: child,
    );
  }
}

extension SlideDownExtension on Widget {
  Widget slideDown({
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
    return SlideInDown(
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
