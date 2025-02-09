import 'package:flutter/material.dart';

import '../../animate_do.dart';

extension AnimateDoBounceExtension on Widget {
  /// Applies a bounce-in animation with customizable options
  Widget bounceIn({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.bounceOut,
  }) {
    return BounceIn(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      onFinish: onFinish,
      curve: curve,
      child: this,
    );
  }

  /// Applies a bounce-in-down animation with customizable options
  Widget bounceInDown({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    double from = 75,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.bounceOut,
  }) {
    return BounceInDown(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from,
      onFinish: onFinish,
      curve: curve,
      child: this,
    );
  }

  /// Applies a bounce-in-up animation with customizable options
  Widget bounceInUp({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    double from = 75,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.bounceOut,
  }) {
    return BounceInUp(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from,
      onFinish: onFinish,
      curve: curve,
      child: this,
    );
  }

  /// Applies a bounce-in-right animation with customizable options
  Widget bounceInRight({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    double from = 75,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.bounceOut,
  }) {
    return BounceInRight(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from,
      onFinish: onFinish,
      curve: curve,
      child: this,
    );
  }

  /// Applies a bounce-in-left animation with customizable options
  Widget bounceInLeft({
    Duration duration = const Duration(milliseconds: 1000),
    Duration delay = const Duration(milliseconds: 0),
    Function(AnimationController)? controller,
    bool manualTrigger = false,
    bool animate = true,
    double from = 75,
    Function(AnimateDoDirection direction)? onFinish,
    Curve curve = Curves.bounceOut,
  }) {
    return BounceInLeft(
      duration: duration,
      delay: delay,
      controller: controller,
      manualTrigger: manualTrigger,
      animate: animate,
      from: from,
      onFinish: onFinish,
      curve: curve,
      child: this,
    );
  }
}
