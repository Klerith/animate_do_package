import 'package:flutter/material.dart';

/// Class [FadeOut]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class FadeOut extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;

  FadeOut(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 500),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FadeOutState createState() => _FadeOutState();
}

/// State class, where the magic happens
class _FadeOutState extends State<FadeOut> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool disposed = false;
  late Animation<double> animation;

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
    animation = Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: controller));

    /// Manual trigger false and animate = true
    /// No delay in place, then start the animation
    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller.forward();
          print('controller ' + controller.value.toString());
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller.forward();
    }

    /// If FALSE, animate everything back to original
    if (!widget.animate) {
      controller.animateBack(0);
    }

    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: animation.value,
            child: widget.child,
          );
        });
  }
}

/// Class [FadeOutDown]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class FadeOutDown extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutDown(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 800),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FadeOutDownState createState() => _FadeOutDownState();
}

/// State class, where the magic happens
class _FadeOutDownState extends State<FadeOutDown>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;
  late Animation<double> opacity;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: 0, end: widget.from)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: controller!, curve: const Interval(0, 0.65)));

    /// Manual trigger false and animate = true
    /// No delay in place, then start the animation
    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    /// If FALSE, animate everything back to original
    if (!widget.animate) {
      controller?.animateBack(0);
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

/// Class [FadeOutDownBig]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class FadeOutDownBig extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutDownBig(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1300),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 600})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => FadeOutDown(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from,
      );
}

/// Class [FadeOutUp]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class FadeOutUp extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutUp(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 800),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FadeOutUpState createState() => _FadeOutUpState();
}

/// State class, where the magic happens
class _FadeOutUpState extends State<FadeOutUp>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;
  late Animation<double> opacity;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: 0.0, end: widget.from * -1)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: controller!, curve: const Interval(0, 0.65)));

    /// Manual trigger false and animate = true
    /// No delay in place, then start the animation
    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    /// If FALSE, animate everything back to original
    if (!widget.animate) {
      controller?.animateBack(0);
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

/// Class [FadeOutUpBig]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class FadeOutUpBig extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutUpBig(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1300),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 600})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => FadeOutUp(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from,
      );
}

/// Class [FadeOutLeft]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class FadeOutLeft extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutLeft(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 800),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FadeOutLeftState createState() => _FadeOutLeftState();
}

/// State class, where the magic happens
class _FadeOutLeftState extends State<FadeOutLeft>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;
  late Animation<double> opacity;
  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: 0, end: widget.from * -1)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: controller!, curve: const Interval(0, 0.65)));

    /// Manual trigger false and animate = true
    /// No delay in place, then start the animation
    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    /// If FALSE, animate everything back to original
    if (!widget.animate) {
      controller?.animateBack(0);
    }

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
              offset: Offset(animation.value, 0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

/// Class [FadeOutLeftBig]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class FadeOutLeftBig extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutLeftBig(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1300),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 600})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => FadeOutLeft(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from,
      );
}

/// Class [FadeOutRight]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class FadeOutRight extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutRight(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 800),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => FadeOutLeft(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
      );
}

/// Class [FadeOutRightBig]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class FadeOutRightBig extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutRightBig(
      {key,
      required this.child,
      this.duration = const Duration(milliseconds: 1200),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 600})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => FadeOutLeft(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
      );
}
