import 'dart:math' show pi;

import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Performs a single full rotation of the [child] around the X axis.
///
/// Note: despite the name, this rotates around X. Kept for backwards
/// compatibility with previous versions of the package.
class FlipY extends AnimateDoBaseWidget {
  const FlipY({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 800),
    super.delay,
    super.curve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
    this.perspective = 400.0,
  });

  /// Currently unused. Kept for API backwards compatibility.
  final double perspective;

  @override
  State<FlipY> createState() => FlipYState();
}

class FlipYState extends AnimateDoBaseState<FlipY> {
  late Animation<double> _rotation;

  @override
  void createTweens() {
    _rotation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()..rotateX(_rotation.value),
      child: child,
    );
  }
}

extension FlipYExtension on Widget {
  Widget flipY({
    Key? key,
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
  }) {
    return FlipY(
      key: key,
      duration: duration,
      delay: delay,
      curve: curve,
      animate: animate,
      manualTrigger: manualTrigger,
      controller: controller,
      onFinish: onFinish,
      child: this,
    );
  }
}
