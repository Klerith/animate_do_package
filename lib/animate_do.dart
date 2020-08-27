import 'package:flutter/material.dart';

/// Author: Fernando Herrera
/// website: fernando-herrera.com

/// General information
/// All the widgets are stateful that tracks the state and everything happends there.
/// The Widget definition contains the properties and the state the animation itself.
///
/// [key] is the widget key for references
/// [child] is the widget to animate
/// [duration] is the duration that you want for the animation
/// [delay] is the delay that you want before the animation starts
/// [manualTrigger] will help you to prevent any animation until you call it via the
/// animation controller, [controller] is a normal AnimationController class that
/// contains the forward, repeat and everything else to control the animation.
/// [animate] is a boolean property that will trigger the animation when is set to true,
/// this is very useful if you use StatefulWidgets with setState or other State Management system.

/// Some Animations contains special properties
/// [from] will help you to change how far the animation should start or end
/// [spins] is related to the number of spins that you want for certain animation
/// [infinite] gives you the power to never stop the animation

/// ===================================
///              [Fades]
/// ===================================
///
/// [FadeIn] Widget definition and its properties
class FadeIn extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;

  FadeIn(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 300),
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
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = CurvedAnimation(curve: Curves.easeOut, parent: controller);

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: widget.child,
          );
        });
  }
}

///
/// [FadeInDown] Widget definition and its properties
class FadeInDown extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInDown(
      {this.key,
      this.child,
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
  _FadeInDownState createState() => _FadeInDownState();
}

class _FadeInDownState extends State<FadeInDown>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

///
/// [FadeInDownBig] Widget definition and its properties
class FadeInDownBig extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInDownBig(
      {this.key,
      this.child,
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
  Widget build(BuildContext context) => FadeInDown(
      child: child,
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from);
}

///
/// [FadeInUp] Widget definition and its properties
class FadeInUp extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInUp(
      {this.key,
      this.child,
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
  _FadeInUpState createState() => _FadeInUpState();
}

class _FadeInUpState extends State<FadeInUp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

///
/// [FadeInUpBig] Widget definition and its properties
class FadeInUpBig extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInUpBig(
      {this.key,
      this.child,
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
  Widget build(BuildContext context) => FadeInUp(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from,
      );
}

///
/// [FadeInLeft] Widget definition and its properties
class FadeInLeft extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInLeft(
      {this.key,
      this.child,
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
  _FadeInLeftState createState() => _FadeInLeftState();
}

class _FadeInLeftState extends State<FadeInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(animation.value, 0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

///
/// [FadeInLeftBig] Widget definition and its properties
class FadeInLeftBig extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInLeftBig(
      {this.key,
      this.child,
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
  Widget build(BuildContext context) => FadeInLeft(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from,
      );
}

///
/// [FadeInRight] Widget definition and its properties
class FadeInRight extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInRight(
      {this.key,
      this.child,
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
  _FadeInRightState createState() => _FadeInRightState();
}

class _FadeInRightState extends State<FadeInRight>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(animation.value, 0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

///
/// [FadeInRightBig] Widget definition and its properties
class FadeInRightBig extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeInRightBig(
      {this.key,
      this.child,
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
  Widget build(BuildContext context) => FadeInRight(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from,
      );
}

/// ===================================
///         [END of Fades]
/// ===================================

/// ===================================
///              [Bounce]
/// ===================================

///
/// [BounceInDown] Widget definition and its properties
class BounceInDown extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  BounceInDown(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 75})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _BounceInDownState createState() => _BounceInDownState();
}

class _BounceInDownState extends State<BounceInDown>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(0, animation.value),
              child: Opacity(opacity: opacity.value, child: widget.child));
        });
  }
}

///
///[BounceInUp]
class BounceInUp extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  BounceInUp(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 75})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => BounceInDown(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
      );
}

///
/// [BounceInLeft] Widget definition and its properties
class BounceInLeft extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  BounceInLeft(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 75})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _BounceInLeftState createState() => _BounceInLeftState();
}

class _BounceInLeftState extends State<BounceInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(animation.value, 0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

///
/// [BounceInRight] Widget definition and its properties
class BounceInRight extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  BounceInRight(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 75})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => BounceInLeft(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
      );
}

/// ===================================
///            [End Bounce]
/// ===================================

/// ===================================
///             [Elastics]
/// ===================================

///
/// [ElasticIn] Widget definition and its properties
class ElasticIn extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;

  ElasticIn(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
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
  _ElasticInState createState() => _ElasticInState();
}

class _ElasticInState extends State<ElasticIn>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> bouncing;
  Animation<double> opacity;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.45)));

    bouncing = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
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

///
/// [ElasticInDown] Widget definition and its properties
class ElasticInDown extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final double to;

  ElasticInDown(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 200,
      this.to = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _ElasticInDownState createState() => _ElasticInDownState();
}

class _ElasticInDownState extends State<ElasticInDown>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> bouncing;
  Animation<double> falling;
  Animation<double> opacity;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.45)));

    falling = Tween<double>(begin: widget.from * -1, end: widget.to * -1)
        .animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.30, curve: Curves.linear)));

    bouncing = Tween<double>(begin: widget.to * -1, end: 0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.30, 1, curve: Curves.elasticOut)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
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

///
/// [ElasticInUp] Widget definition and its properties
class ElasticInUp extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  ElasticInUp(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 200})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => ElasticInDown(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
        to: 100,
      );
}

///
/// [ElasticInLeft] Widget definition and its properties
class ElasticInLeft extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final double to;

  ElasticInLeft(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 200,
      this.to = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _ElasticInLeftState createState() => _ElasticInLeftState();
}

class _ElasticInLeftState extends State<ElasticInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> bouncing;
  Animation<double> falling;
  Animation<double> opacity;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.45)));

    falling = Tween<double>(begin: widget.from * -1, end: widget.to * -1)
        .animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.30, curve: Curves.linear)));

    bouncing = Tween<double>(begin: widget.to * -1, end: 0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.30, 1, curve: Curves.elasticOut)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
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

///
/// [ElasticInRight] Widget definition and its properties
class ElasticInRight extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  ElasticInRight(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 200})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => ElasticInLeft(
      child: child,
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from * -1,
      to: -100);
}

/// ====================================
///           [End Elastics]
/// ====================================

/// ====================================
///               [Flips]
/// ====================================

///
/// [FlipInX] Widget definition and its properties
class FlipInX extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;

  FlipInX(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 800),
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
  _FlipInXState createState() => _FlipInXState();
}

class _FlipInXState extends State<FlipInX> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> rotation;
  Animation<double> opacity;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    rotation = Tween<double>(begin: 1.5, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()..rotateX(rotation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

///
/// [FlipInY] Widget definition and its properties
class FlipInY extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;

  FlipInY(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 800),
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
  _FlipInYState createState() => _FlipInYState();
}

class _FlipInYState extends State<FlipInY> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> rotation;
  Animation<double> opacity;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    rotation = Tween<double>(begin: 1.5, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()..rotateY(rotation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

/// ====================================
///            [End Flips]
/// ====================================

/// ====================================
///             [SlideIns]
/// ====================================

///
/// [SlideInUp] Widget definition and its properties
class SlideInUp extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  SlideInUp(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 600),
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
  _SlideInUpState createState() => _SlideInUpState();
}

class _SlideInUpState extends State<SlideInUp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(0, animation.value), child: widget.child);
        });
  }
}

///
/// [SlideInDown] Widget definition and its properties
class SlideInDown extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  SlideInDown(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 600),
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
  Widget build(BuildContext context) => SlideInUp(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
      );
}

///
/// [SlideInLeft] Widget definition and its properties
class SlideInLeft extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  SlideInLeft(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 600),
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
  _SlideInLeftState createState() => _SlideInLeftState();
}

class _SlideInLeftState extends State<SlideInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(animation.value, 0), child: widget.child);
        });
  }
}

///
/// [SlideInRight] Widget definition and its properties
class SlideInRight extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  SlideInRight(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 600),
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
  Widget build(BuildContext context) => SlideInLeft(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
      );
}

/// ====================================
///            [End SlideIns]
/// ====================================

/// ====================================
///          [Special Ins]
/// ====================================

///
/// [JelloIn] Widget definition and its properties
class JelloIn extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;

  JelloIn(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 800),
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
  _JelloInState createState() => _JelloInState();
}

class _JelloInState extends State<JelloIn> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> rotation;
  Animation<double> opacity;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    rotation = Tween<double>(begin: 1.5, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(0, 0, rotation.value + 1)
                ..rotateX(rotation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

/// ====================================
///          [End Special Ins]
/// ====================================

/// ====================================
///         [Attention Seekers]
/// ====================================

///
/// [Bounce] Widget definition and its properties
class Bounce extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  Bounce(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1300),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 50})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _BounceState createState() => _BounceState();
}

class _BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationBounce;

  Animation<double> animationUp;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animationUp = Tween<double>(begin: 0, end: widget.from * -1).animate(
        CurvedAnimation(
            curve: Interval(0, 0.35, curve: Curves.easeInOut),
            parent: controller));

    animationBounce = Tween<double>(begin: widget.from * -1, end: 0.0).animate(
        CurvedAnimation(
            curve: Interval(0.35, 1, curve: Curves.bounceOut),
            parent: controller));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        (widget.infinite) ? controller.repeat() : controller?.forward();
      });
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(
                  0,
                  (animationUp.value == (widget.from * -1))
                      ? animationBounce.value
                      : animationUp.value),
              child: widget.child);
        });
  }
}

///
/// [Flash] Widget definition and its properties
class Flash extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;

  Flash(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
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
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityOut1;
  Animation<double> opacityIn1;
  Animation<double> opacityOut2;
  Animation<double> opacityIn2;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    opacityOut1 = Tween<double>(begin: 1, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.25)));
    opacityIn1 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.25, 0.5)));
    opacityOut2 = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.5, 0.75)));
    opacityIn2 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.75, 1)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        (widget.infinite) ? controller.repeat() : controller?.forward();
      });
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Opacity(
              opacity: (controller.value < 0.25)
                  ? opacityOut1.value
                  : (controller.value < 0.5)
                      ? opacityIn1.value
                      : (controller.value < 0.75)
                          ? opacityOut2.value
                          : opacityIn2.value,
              child: widget.child);
        });
  }
}

///
/// [Pulse] Widget definition and its properties
class Pulse extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;

  Pulse(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
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
  _PulseState createState() => _PulseState();
}

class _PulseState extends State<Pulse> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationInc;
  Animation<double> animationDec;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animationInc = Tween<double>(begin: 1, end: 1.5).animate(CurvedAnimation(
        parent: controller, curve: Interval(0, 0.5, curve: Curves.easeOut)));

    animationDec = Tween<double>(begin: 1.5, end: 1).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.5, 1, curve: Curves.easeIn)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        (widget.infinite) ? controller.repeat() : controller?.forward();
      });
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.scale(
            scale: (controller.value < 0.5)
                ? animationInc.value
                : animationDec.value,
            child: widget.child,
          );
        });
  }
}

///
/// [Swing] Widget definition and its properties
class Swing extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;

  Swing(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
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
  _SwingState createState() => _SwingState();
}

class _SwingState extends State<Swing> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationRotation1;
  Animation<double> animationRotation2;
  Animation<double> animationRotation3;
  Animation<double> animationRotation4;
  Animation<double> animationRotation5;
  Animation<double> animationRotation6;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animationRotation1 = Tween<double>(begin: 0, end: -0.5).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.1666, curve: Curves.easeOut)));

    animationRotation2 = Tween<double>(begin: -0.5, end: 0.5).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.1666, 0.3333, curve: Curves.easeInOut)));

    animationRotation3 = Tween<double>(begin: 0.5, end: -0.5).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.3333, 0.4999, curve: Curves.easeInOut)));

    animationRotation4 = Tween<double>(begin: -0.5, end: 0.4).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.4999, 0.6666, curve: Curves.easeInOut)));

    animationRotation5 = Tween<double>(begin: 0.4, end: -0.4).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.6666, 0.8333, curve: Curves.easeInOut)));

    animationRotation6 = Tween<double>(begin: -0.4, end: 0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.8333, 1, curve: Curves.easeOut)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        (widget.infinite) ? controller.repeat() : controller?.forward();
      });
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          double angle = (animationRotation1.value != -0.5)
              ? animationRotation1.value
              : (animationRotation2.value != 0.5)
                  ? animationRotation2.value
                  : (animationRotation3.value != -0.5)
                      ? animationRotation3.value
                      : (animationRotation4.value != 0.4)
                          ? animationRotation4.value
                          : (animationRotation5.value != -0.4)
                              ? animationRotation5.value
                              : animationRotation6.value;

          return Transform.rotate(
            angle: angle,
            child: widget.child,
          );
        });
  }
}

///
/// [Spin] Widget definition and its properties
class Spin extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double spins;

  Spin(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.spins = 1})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _SpinState createState() => _SpinState();
}

class _SpinState extends State<Spin> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> spin;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    spin = Tween<double>(begin: 0, end: widget.spins * 2)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        (widget.infinite) ? controller.repeat() : controller?.forward();
      });
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            angle: spin.value * 3.1415926535,
            child: widget.child,
          );
        });
  }
}

///
/// [SpinPerfect] Widget definition and its properties
class SpinPerfect extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double spins;

  SpinPerfect(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.spins = 1})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _SpinPerfectState createState() => _SpinPerfectState();
}

class _SpinPerfectState extends State<SpinPerfect>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> spin;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    spin = Tween<double>(begin: 0, end: widget.spins * 2)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        (widget.infinite) ? controller.repeat() : controller?.forward();
      });
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            angle: spin.value * 3.141516,
            child: widget.child,
          );
        });
  }
}

///
/// [Dance] Widget definition and its properties
class Dance extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;

  Dance(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1000),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
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
  _DanceState createState() => _DanceState();
}

class _DanceState extends State<Dance> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> step1;
  Animation<double> step2;
  Animation<double> step3;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    step1 = Tween<double>(begin: 0, end: -0.2).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0, 0.3333, curve: Curves.bounceOut)));

    step2 = Tween<double>(begin: -0.2, end: 0.2).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.3333, 0.6666, curve: Curves.bounceOut)));

    step3 = Tween<double>(begin: 0.2, end: 0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.6666, 1, curve: Curves.bounceOut)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        (widget.infinite) ? controller.repeat() : controller?.forward();
      });
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          final animation = (step1.value != -0.2)
              ? step1.value
              : (step2.value != 0.2) ? step2.value : step3.value;

          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.skew(0, animation),
              child: widget.child);
        });
  }
}

///
/// [Roulette] Widget definition and its properties
class Roulette extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double spins;

  Roulette(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 3500),
      this.delay = const Duration(milliseconds: 0),
      this.infinite = false,
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.spins = 2})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _RouletteState createState() => _RouletteState();
}

class _RouletteState extends State<Roulette>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> spin;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    spin = Tween<double>(begin: 0, end: widget.spins * 2)
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        (widget.infinite) ? controller.repeat() : controller?.forward();
      });
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            angle: spin.value * 3.141516,
            child: widget.child,
          );
        });
  }
}

/// ====================================
///        [End Attention Seekers]
/// ====================================

/// ====================================
///              [FadeOuts]
/// ====================================

///
/// [FadeOut] Widget definition and its properties
class FadeOut extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;

  FadeOut(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 300),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = false})
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

class _FadeOutState extends State<FadeOut> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: controller));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: widget.child,
          );
        });
  }
}

///
/// [FadeOutDown] Widget definition and its properties
class FadeOutDown extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutDown(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 800),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = false,
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

class _FadeOutDownState extends State<FadeOutDown>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: 0, end: widget.from)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    opacity = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

///
/// [FadeOutDownBig] Widget definition and its properties
class FadeOutDownBig extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutDownBig(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1300),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = false,
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

///
/// [FadeOutUp] Widget definition and its properties
class FadeOutUp extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutUp(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 800),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = false,
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

class _FadeOutUpState extends State<FadeOutUp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: 0.0, end: widget.from * -1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

///
/// [FadeOutUpBig] Widget definition and its properties
class FadeOutUpBig extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutUpBig(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1300),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = false,
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

///
/// [FadeOutLeft] Widget definition and its properties
class FadeOutLeft extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutLeft(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 800),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = false,
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

class _FadeOutLeftState extends State<FadeOutLeft>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation = Tween<double>(begin: 0, end: widget.from * -1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    opacity = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(animation.value, 0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

///
/// [FadeOutLeftBig] Widget definition and its properties
class FadeOutLeftBig extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutLeftBig(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1300),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = false,
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

///
/// [FadeOutRight] Widget definition and its properties
class FadeOutRight extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutRight(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 800),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = false,
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

///
/// [FadeOutRightBig] Widget definition and its properties
class FadeOutRightBig extends StatelessWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  FadeOutRightBig(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 1200),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = false,
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

/// ====================================
///          [End FadeOuts]
/// ====================================

/// ====================================
///      [ZoomIn/out Animations]
/// ====================================

///
/// [ZoomIn] Widget definition and its properties
class ZoomIn extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  ZoomIn(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 500),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 1.0})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _ZoomInState createState() => _ZoomInState();
}

class _ZoomInState extends State<ZoomIn> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> fade;
  Animation<double> opacity;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    fade = Tween(begin: 0.0, end: widget.from)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: controller));

    opacity = Tween<double>(begin: 0.0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: fade,
        builder: (BuildContext context, Widget child) {
          return Transform.scale(
            scale: fade.value,
            child: Opacity(
              opacity: opacity.value,
              child: widget.child,
            ),
          );
        });
  }
}

///
/// [ZoomOut] Widget definition and its properties
class ZoomOut extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  ZoomOut(
      {this.key,
      this.child,
      this.duration = const Duration(milliseconds: 500),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 0.0})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _ZoomOutState createState() => _ZoomOutState();
}

class _ZoomOutState extends State<ZoomOut> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> zoom;
  Animation<double> opacity;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    zoom = Tween(begin: 1.0, end: widget.from)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: controller));

    opacity = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () => controller?.forward());
    }

    if (widget.controller is Function) {
      widget.controller(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.scale(
            scale: zoom.value,
            child: Opacity(
              opacity: opacity.value,
              child: widget.child,
            ),
          );
        });
  }
}

/// ====================================
///    [End ZoomIn/out Animations]
/// ====================================
