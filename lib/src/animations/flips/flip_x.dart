import 'dart:math' show pi;

import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

const Duration _defaultDuration = Duration(milliseconds: 800);
const double _defaultPerspective = 400.0;

/// Performs a single full rotation of the [child] around the Y axis.
///
/// Note: despite the name, this rotates around Y. Kept for backwards
/// compatibility with previous versions of the package.
class FlipX extends AnimateDoBaseWidget {
  const FlipX({
    super.key,
    required super.child,
    super.duration = _defaultDuration,
    super.delay,
    super.curve,
    super.animate,
    super.manualTrigger,
    super.controller,
    super.onFinish,
    this.perspective = _defaultPerspective,
  }) : assert(perspective > 0, 'perspective must be greater than 0');

  /// Distance (in logical pixels) from the camera to the rotation plane.
  /// Lower values exaggerate the 3D effect; higher values flatten it.
  final double perspective;

  @override
  State<FlipX> createState() => FlipXState();
}

class FlipXState extends AnimateDoBaseState<FlipX> {
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
      transform: Matrix4.identity()
        ..setEntry(3, 2, 1 / widget.perspective)
        ..rotateY(_rotation.value),
      child: child,
    );
  }
}

extension FlipXExtension on Widget {
  Widget flipX({
    Key? key,
    Duration duration = _defaultDuration,
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool manualTrigger = false,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    double perspective = _defaultPerspective,
  }) {
    return FlipX(
      key: key,
      duration: duration,
      delay: delay,
      curve: curve,
      animate: animate,
      manualTrigger: manualTrigger,
      controller: controller,
      onFinish: onFinish,
      perspective: perspective,
      child: this,
    );
  }
}
