import 'package:flutter/widgets.dart';

import '../../types/animate_do_base.dart';
import '../../types/animate_do_typedefs.dart';

/// Combines a small scale-down/scale-up with several rotation flicks,
/// mimicking the `tada` animation from Animate.css.
class Tada extends AnimateDoBaseWidget {
  const Tada({
    super.key,
    required super.child,
    super.duration = const Duration(milliseconds: 1000),
    super.delay,
    super.curve = Curves.easeInOut,
    super.animate,
    super.infinite,
    super.manualTrigger,
    super.loopDelay,
    super.controller,
    super.onFinish,
    super.onLoop,
  });

  @override
  State<Tada> createState() => TadaState();
}

class TadaState extends AnimateDoBaseState<Tada> {
  late Animation<double> _scale;
  late Animation<double> _rotation;

  @override
  void createTweens() {
    final CurvedAnimation curved =
        CurvedAnimation(parent: controller, curve: widget.curve);

    _scale = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.9), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.1), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.1), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 30),
    ]).animate(curved);

    _rotation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -0.0523599),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.0523599, end: 0.0523599),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.0523599, end: -0.0523599),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.0523599, end: 0.0523599),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.0523599, end: -0.0523599),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -0.0523599, end: 0.0523599),
        weight: 15,
      ),
      TweenSequenceItem(tween: Tween(begin: 0.0523599, end: 0.0), weight: 15),
    ]).animate(curved);
  }

  @override
  Widget buildAnimatedChild(BuildContext context, Widget child) {
    return Transform(
      transform: Matrix4.identity()
        ..scaleByDouble(_scale.value, _scale.value, 1, 1)
        ..rotateZ(_rotation.value),
      alignment: Alignment.center,
      child: child,
    );
  }
}

extension TadaExtension on Widget {
  Widget tada({
    Key? key,
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = Duration.zero,
    Curve curve = Curves.easeOut,
    bool animate = true,
    bool infinite = false,
    bool manualTrigger = false,
    Duration loopDelay = Duration.zero,
    AnimateDoControllerCallback? controller,
    AnimateDoFinishCallback? onFinish,
    AnimateDoLoopCallback? onLoop,
  }) {
    return Tada(
      key: key,
      duration: duration,
      delay: delay,
      curve: curve,
      animate: animate,
      infinite: infinite,
      manualTrigger: manualTrigger,
      loopDelay: loopDelay,
      controller: controller,
      onFinish: onFinish,
      onLoop: onLoop,
      child: this,
    );
  }
}
