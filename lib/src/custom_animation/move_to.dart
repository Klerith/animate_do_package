import 'package:flutter/widgets.dart';

import '../types/animate_do_base.dart';
import '../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 300);

/// Translates the [child] by a relative offset specified through any
/// combination of [top], [bottom], [left] and [right] (in pixels).
///
/// Opposing axes are composed: the final horizontal offset is
/// `right - left` and the vertical one is `bottom - top`. Negative values
/// are accepted and behave as their opposite (e.g. `left: -50` is the same
/// as `right: 50`).
class MoveTo extends AnimateDoBaseWidget {
  const MoveTo({
    super.key,
    required super.child,
    super.duration = _defaultDuration,
    super.delay,
    super.curve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
    this.top = 0.0,
    this.bottom = 0.0,
    this.left = 0.0,
    this.right = 0.0,
  });

  final double top;
  final double bottom;
  final double left;
  final double right;

  @override
  State<MoveTo> createState() => MoveToState();
}

class MoveToState extends AnimateDoBaseState<MoveTo> {
  late Animation<double> _translateX;
  late Animation<double> _translateY;

  @override
  void createTweens() {
    final CurvedAnimation curved =
        CurvedAnimation(parent: controller, curve: widget.curve);

    _translateX = Tween<double>(
      begin: 0,
      end: widget.right - widget.left,
    ).animate(curved);

    _translateY = Tween<double>(
      begin: 0,
      end: widget.bottom - widget.top,
    ).animate(curved);
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform.translate(
      offset: Offset(_translateX.value, _translateY.value),
      child: child,
    );
  }
}

extension MoveExtension on Widget {
  Widget moveTo({
    Key? key,
    Duration duration = _defaultDuration,
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) {
    return MoveTo(
      key: key,
      duration: duration,
      delay: delay,
      curve: curve,
      animate: animate,
      manualTrigger: manualTrigger,
      controller: controller,
      onFinish: onFinish,
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: this,
    );
  }
}
