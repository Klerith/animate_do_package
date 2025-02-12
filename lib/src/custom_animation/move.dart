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
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Function(AnimateDoDirection direction)? onFinish;
  final Curve curve;

  MoveTo({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.delay = Duration.zero,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.onFinish,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.curve = Curves.easeOut,
  }) : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'You must provide the controller property, which is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  MoveToState createState() => MoveToState();
}

class MoveToState extends State<MoveTo>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late Animation<double> moveAnimation;

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

    moveAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: widget.curve));

    configAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      onFinish: widget.onFinish,
      infinite: false,
      controllerCallback: widget.controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    buildAnimation(
      delay: widget.delay,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      onFinish: widget.onFinish,
      infinite: false,
      controllerCallback: widget.controller,
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          top: widget.top != null ? widget.top! * moveAnimation.value : null,
          bottom: widget.bottom != null ? widget.bottom! * moveAnimation.value : null,
          left: widget.left != null ? widget.left! * moveAnimation.value : null,
          right: widget.right != null ? widget.right! * moveAnimation.value : null,
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
    double? top,
    double? bottom,
    double? left,
    double? right,
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
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      curve: curve,
      child: this,
    );
  }
}
