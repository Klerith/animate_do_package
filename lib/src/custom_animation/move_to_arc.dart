import 'dart:math' show pi, sin, cos;

import 'package:flutter/widgets.dart';

import '../types/animate_do_base.dart';
import '../types/animate_do_typedefs.dart';

/// Translates the [child] along an arc using a quarter-circle path.
///
/// The radius is taken from [bottom] (preferred) or [top]. Setting [upward]
/// to `true` produces a sine-based arc; the default is a `(1 - cos)` arc.
/// Horizontal displacement is interpolated linearly from [left] / [right].
class MoveToArc extends AnimateDoBaseWidget {
  const MoveToArc({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 800),
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

    final double radius = widget.bottom > 0 ? widget.bottom : widget.top;
    double offsetY;

    if (widget.upward) {
      offsetY = -radius * sin(angle);
    } else {
      offsetY = radius * (1 - cos(angle));
      if (widget.top > 0) {
        offsetY = -offsetY;
      }
    }

    double offsetX = 0;
    if (widget.left > 0) {
      offsetX = -widget.left * t;
    } else if (widget.right > 0) {
      offsetX = widget.right * t;
    }

    return Transform.translate(
      offset: Offset(offsetX, offsetY),
      child: child,
    );
  }
}

extension MoveArcExtension on Widget {
  Widget moveToArc({
    Key? key,
    Duration duration = const Duration(milliseconds: 800),
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
