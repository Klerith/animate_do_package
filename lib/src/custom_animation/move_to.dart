import 'package:flutter/material.dart';
import '../types/animate_do_mixins.dart';
import '../types/animate_do_types.dart';


class MoveTo extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  /// Movement parameters (relative displacement)
  final double top;
  final double bottom;
  final double left;
  final double right;

  MoveTo({
    key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.delay = const Duration(milliseconds: 0),
    this.controller,
    this.manualTrigger = false,
    this.animate = false,
    this.onFinish,
    this.curve = Curves.easeOut,
    this.top = 0.0,
    this.bottom = 0.0,
    this.left = 0.0,
    this.right = 0.0,
  }) : super(key: key) {
    // If manualTrigger is enabled, controller must be provided
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you use manualTrigger: true, \n\n'
          'you must provide the controller property like this:\n\n'
          ' (controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _MoveToState createState() => _MoveToState();
}

class _MoveToState extends State<MoveTo>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> animationX;
  late Animation<double> animationY;

  @override
  void dispose() {
    disposed = true;
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    // Create animations for X and Y based on relative movement
    animationX = Tween<double>(
      begin: 0.0, // Start at the original position
      end: widget.left != 0.0 ? -widget.left : widget.right,
    ).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    animationY = Tween<double>(
      begin: 0.0, // Start at the original position
      end: widget.top != 0.0 ? -widget.top : widget.bottom,
    ).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    // Configure animation using AnimateDoState
    configAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      infinite: false,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build animation with AnimateDoState
    buildAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      infinite: false,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(animationX.value, animationY.value),
          child: widget.child,
        );
      },
    );
  }
}

extension MoveExtension on Widget {
  Widget moveTo({
    Key? key,
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    bool infinite = false,
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.easeOut,
  }) {


    return MoveTo(
      key: key,
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      onFinish: onFinish,
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      curve: curve,
      child: this,
    );
  }
}
