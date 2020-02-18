import 'package:flutter/material.dart';

// ====================================
//              Begin Fades
// ====================================
// ============= FadeIn
class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeIn({this.child, this.duration = const Duration(milliseconds: 300)});

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();
    animation = CurvedAnimation(curve: Curves.linear, parent: controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: widget.child,
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// ============= FadeInDown
class FadeInDown extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeInDown({this.child, this.duration = const Duration(milliseconds: 800)});

  @override
  _FadeInDownState createState() => _FadeInDownState();
}

class _FadeInDownState extends State<FadeInDown>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();

    animation = Tween<double>(begin: -160.0, end: 0).animate(controller);
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              // offset: Offset( 0, animation.value * 50 ),
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

// ============= FadeInDownBig
class FadeInDownBig extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeInDownBig(
      {this.child, this.duration = const Duration(milliseconds: 1300)});

  @override
  _FadeInDownBigState createState() => _FadeInDownBigState();
}

class _FadeInDownBigState extends State<FadeInDownBig>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();
    animation = Tween<double>(begin: -600.0, end: 0).animate(controller);
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              // offset: Offset( 0, animation.value * 50 ),
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

// ============= FadeInUp
class FadeInUp extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeInUp({this.child, this.duration = const Duration(milliseconds: 800)});

  @override
  _FadeInUpState createState() => _FadeInUpState();
}

class _FadeInUpState extends State<FadeInUp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();
    animation = Tween<double>(begin: 160.0, end: 0).animate(controller);
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              // offset: Offset( 0, animation.value * 50 ),
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

// ============= FadeInUpBig
class FadeInUpBig extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeInUpBig({this.child, this.duration = const Duration(milliseconds: 1300)});

  @override
  _FadeInUpBigState createState() => _FadeInUpBigState();
}

class _FadeInUpBigState extends State<FadeInUpBig>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();
    animation = Tween<double>(begin: 600.0, end: 0).animate(controller);
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              // offset: Offset( 0, animation.value * 50 ),
              offset: Offset(0, animation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

// ============= FadeInLeft
class FadeInLeft extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeInLeft({this.child, this.duration = const Duration(milliseconds: 800)});

  @override
  _FadeInLeftState createState() => _FadeInLeftState();
}

class _FadeInLeftState extends State<FadeInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();
    animation = Tween<double>(begin: -160.0, end: 0).animate(controller);
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              // offset: Offset( 0, animation.value * 50 ),
              offset: Offset(animation.value, 0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

// ============= FadeInLeftBig
class FadeInLeftBig extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeInLeftBig(
      {this.child, this.duration = const Duration(milliseconds: 1300)});

  @override
  _FadeInLeftBigState createState() => _FadeInLeftBigState();
}

class _FadeInLeftBigState extends State<FadeInLeftBig>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();
    animation = Tween<double>(begin: -600.0, end: 0).animate(controller);
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              // offset: Offset( 0, animation.value * 50 ),
              offset: Offset(animation.value, 0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

// ============= FadeInRight
class FadeInRight extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeInRight({this.child, this.duration = const Duration(milliseconds: 800)});

  @override
  _FadeInRightState createState() => _FadeInRightState();
}

class _FadeInRightState extends State<FadeInRight>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();
    animation = Tween<double>(begin: 160.0, end: 0).animate(controller);
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));
  }

  @override
  Widget build(BuildContext context) {
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

// ============= FadeInRightBig
class FadeInRightBig extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeInRightBig(
      {this.child, this.duration = const Duration(milliseconds: 1200)});

  @override
  _FadeInRightBigState createState() => _FadeInRightBigState();
}

class _FadeInRightBigState extends State<FadeInRightBig>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();
    animation = Tween<double>(begin: 600.0, end: 0).animate(controller);
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              // offset: Offset( 0, animation.value * 50 ),
              offset: Offset(animation.value, 0),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}

// ====================================
//              End Fades
// ====================================

// ====================================
//              Begin Bounce
// ====================================
// ============= BounceInDown
class BounceInDown extends StatefulWidget {
  final Widget child;
  final Duration duration;

  BounceInDown(
      {this.child, this.duration = const Duration(milliseconds: 1300)});

  @override
  _BounceInDownState createState() => _BounceInDownState();
}

class _BounceInDownState extends State<BounceInDown>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();

    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    animation = Tween<double>(begin: -400.0, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(0, animation.value),
              child: Opacity(opacity: opacity.value, child: widget.child));
        });
  }
}

// ============= BounceInUp
class BounceInUp extends StatefulWidget {
  final Widget child;
  final Duration duration;

  BounceInUp({this.child, this.duration = const Duration(milliseconds: 1300)});

  @override
  _BounceInUpState createState() => _BounceInUpState();
}

class _BounceInUpState extends State<BounceInUp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    animation = Tween<double>(begin: 400.0, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            return Transform.translate(
                offset: Offset(0, animation.value),
                child: Opacity(
                  opacity: opacity.value,
                  child: widget.child,
                ));
          }),
    );
  }
}

// ============= BounceInLeft
class BounceInLeft extends StatefulWidget {
  final Widget child;
  final Duration duration;

  BounceInLeft(
      {this.child, this.duration = const Duration(milliseconds: 1300)});

  @override
  _BounceInLeftState createState() => _BounceInLeftState();
}

class _BounceInLeftState extends State<BounceInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    animation = Tween<double>(begin: -400.0, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            return Transform.translate(
                offset: Offset(animation.value, 0),
                child: Opacity(
                  opacity: opacity.value,
                  child: widget.child,
                ));
          }),
    );
  }
}

// ============= BounceInRight
class BounceInRight extends StatefulWidget {
  final Widget child;
  final Duration duration;

  BounceInRight(
      {this.child, this.duration = const Duration(milliseconds: 1300)});

  @override
  _BounceInRightState createState() => _BounceInRightState();
}

class _BounceInRightState extends State<BounceInRight>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.65)));

    animation = Tween<double>(begin: 400.0, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            return Transform.translate(
                offset: Offset(animation.value, 0),
                child: Opacity(
                  opacity: opacity.value,
                  child: widget.child,
                ));
          }),
    );
  }
}
// ====================================
//              End Bounce
// ====================================

// ====================================
//       Begin Attention Seekers
// ====================================
// ============= Bounce
class Bounce extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool infinite;

  Bounce({
    this.child,
    this.duration = const Duration(milliseconds: 1300),
    this.infinite = false,
  });

  @override
  _BounceState createState() => _BounceState();
}

class _BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationBounce;

  Animation<double> animationUp;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();

    animationUp = Tween<double>(begin: 0, end: -50).animate(CurvedAnimation(
        curve: Interval(0, 0.35, curve: Curves.easeInOut), parent: controller));

    animationBounce = Tween<double>(begin: -50.0, end: 0).animate(
        CurvedAnimation(
            curve: Interval(0.35, 1, curve: Curves.bounceOut),
            parent: controller));

    if (widget.infinite) {
      controller
        ..stop()
        ..repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(
                  0,
                  (animationUp.value == -50)
                      ? animationBounce.value
                      : animationUp.value),
              child: widget.child);
        });
  }
}

// ============= Flash
class Flash extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool infinite;

  Flash({
    this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.infinite = false,
  });

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
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();

    opacityOut1 = Tween<double>(begin: 1, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.25)));
    opacityIn1 = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.25, 0.5)));
    opacityOut2 = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.5, 0.75)));
    opacityIn2 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.75, 1)));

    if (widget.infinite) {
      controller
        ..stop()
        ..repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
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

// ============= Pulse
class Pulse extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool infinite;

  Pulse({
    this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.infinite = false,
  });

  @override
  _PulseState createState() => _PulseState();
}

class _PulseState extends State<Pulse> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationInc;
  Animation<double> animationDec;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this)
      ..forward();

    animationInc = Tween<double>(begin: 1, end: 1.5).animate(CurvedAnimation(
        parent: controller, curve: Interval(0, 0.5, curve: Curves.easeOut)));

    animationDec = Tween<double>(begin: 1.5, end: 1).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.5, 1, curve: Curves.easeIn)));

    if (widget.infinite) {
      controller
        ..stop()
        ..repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
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

// ====================================
//       End Attention Seekers
// ====================================
