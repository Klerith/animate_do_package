import 'dart:math' show pi, sin, cos;

import 'package:flutter/widgets.dart';

import '../types/animate_do_base.dart';
import '../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 800);

/// Translates the [child] along an arc using a quarter-circle path.
///
/// The vertical radius is `bottom - top`: a positive value arcs downward
/// and a negative value arcs upward. Setting [upward] to `true` forces a
/// sine-based arc that always opens upward regardless of sign; otherwise
/// a `(1 - cos)` arc is used. The horizontal displacement is interpolated
/// linearly as `right - left` (negative values are accepted).
class MoveToArc extends AnimateDoBaseWidget {
  const MoveToArc({
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
    this.upward = false,
  });

  final double top;
  final double bottom;
  final double left;
  final double right;
  final bool upward;

  @override
  State<MoveToArc> createState() => MoveToArcState();
}

class MoveToArcState extends AnimateDoBaseState<MoveToArc> {
  late Animation<double> _progress;

  @override
  void createTweens() {
    _progress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    final double t = _progress.value;
    final double angle = t * pi / 2;

    final double verticalRadius = widget.bottom - widget.top;
    final double horizontalDelta = widget.right - widget.left;

    final double offsetY = widget.upward
        ? -verticalRadius.abs() * sin(angle)
        : verticalRadius * (1 - cos(angle));

    final double offsetX = horizontalDelta * t;

    return Transform.translate(
      offset: Offset(offsetX, offsetY),
      child: child,
    );
  }
}

extension MoveArcExtension on Widget {
  Widget moveToArc({
    Key? key,
    Duration duration = _defaultDuration,
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    bool upward = false,
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) {
    return MoveToArc(
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
      upward: upward,
      child: this,
    );
  }
}
