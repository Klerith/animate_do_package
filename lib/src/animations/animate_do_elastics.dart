import 'package:flutter/material.dart';

import '../types/animate_do_mixins.dart';
import '../types/animate_do_types.dart';

/// Class [ElasticIn]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class ElasticIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;

  ElasticIn(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1500),
      this.delay = Duration.zero,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.onFinish})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  ElasticInState createState() => ElasticInState();
}

/// StateClass, where the magic happens
class ElasticInState extends State<ElasticIn>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late AnimationController controller;
  bool disposed = false;
  late Animation<double> bouncing;
  late Animation<double> opacity;
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

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.45)));

    bouncing = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    /// Provided by the mixing [AnimateDoState] class
    configAnimation(
      controller: controller,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      delay: widget.delay,
      disposed: disposed,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Provided by the mixing [AnimateDoState] class
    buildAnimation(
      controller: controller,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      delay: widget.delay,
      disposed: disposed,
    );

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: bouncing.value,
            child: Opacity(
              opacity: opacity.value,
              child: widget.child,
            ),
          );
        });
  }
}

/// Class [ElasticInDown]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class ElasticInDown extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final double from;
  final double to;

  ElasticInDown(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1500),
      this.delay = Duration.zero,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 200,
      this.to = 100,
      this.onFinish})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  ElasticInDownState createState() => ElasticInDownState();
}

/// StateClass, where the magic happens
class ElasticInDownState extends State<ElasticInDown>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late AnimationController controller;
  bool disposed = false;
  late Animation<double> bouncing;
  late Animation<double> falling;
  late Animation<double> opacity;
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

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.45)));

    falling = Tween<double>(begin: widget.from * -1, end: widget.to * -1)
        .animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.30, curve: Curves.linear)));

    bouncing = Tween<double>(begin: widget.to * -1, end: 0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.30, 1, curve: Curves.elasticOut)));

    /// Provided by the mixing [AnimateDoState] class
    configAnimation(
      controller: controller,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      delay: widget.delay,
      disposed: disposed,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Provided by the mixing [AnimateDoState] class
    buildAnimation(
      controller: controller,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      delay: widget.delay,
      disposed: disposed,
    );

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(
                  0,
                  (falling.value == (widget.to * -1))
                      ? bouncing.value
                      : falling.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

/// Class [ElasticInUp]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class ElasticInUp extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final double from;

  ElasticInUp(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1500),
      this.delay = Duration.zero,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 200,
      this.onFinish})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => ElasticInDown(
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
        to: 100,
        onFinish: onFinish,
        child: child,
      );
}

/// Class [ElasticInLeft]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class ElasticInLeft extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final double from;
  final double to;

  ElasticInLeft(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1500),
      this.delay = Duration.zero,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 200,
      this.to = 100,
      this.onFinish})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  ElasticInLeftState createState() => ElasticInLeftState();
}

/// StateClass, where the magic happens
class ElasticInLeftState extends State<ElasticInLeft>
    with SingleTickerProviderStateMixin, AnimateDoState {
  late AnimationController controller;
  bool disposed = false;
  late Animation<double> bouncing;
  late Animation<double> falling;
  late Animation<double> opacity;
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

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.45)));

    falling = Tween<double>(begin: widget.from * -1, end: widget.to * -1)
        .animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.30, curve: Curves.linear)));

    bouncing = Tween<double>(begin: widget.to * -1, end: 0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.30, 1, curve: Curves.elasticOut)));

    /// Provided by the mixing [AnimateDoState] class
    configAnimation(
      controller: controller,
      onFinish: widget.onFinish,
      controllerCallback: widget.controller,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      delay: widget.delay,
      disposed: disposed,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Provided by the mixing [AnimateDoState] class
    buildAnimation(
      controller: controller,
      animate: widget.animate,
      manualTrigger: widget.manualTrigger,
      delay: widget.delay,
      disposed: disposed,
    );

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(
                  (falling.value == (widget.to * -1))
                      ? bouncing.value
                      : falling.value,
                  0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

/// Class [ElasticInRight]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class ElasticInRight extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final Function(AnimateDoDirection direction)? onFinish;
  final double from;

  ElasticInRight(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1500),
      this.delay = Duration.zero,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 200,
      this.onFinish})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => ElasticInLeft(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from * -1,
      to: -100,
      onFinish: onFinish,
      child: child);
}
