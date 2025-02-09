import 'package:flutter/material.dart';

import '../../animate_do.dart';


extension AnimateDoExtension on Widget {
  /// Aplica una animación fade-in con opciones personalizables
  Widget fadeIn({
    Duration duration = const Duration(milliseconds: 500),
    Duration delay = const Duration(milliseconds: 0),
    Curve curve = Curves.easeOut,
  }) {
    return FadeIn(
      duration: duration,
      delay: delay,
      curve: curve,
      child: this,
    );
  }

  /// Aplica una animación fade-out
  Widget fadeOut({
    Duration duration = const Duration(milliseconds: 500),
    Duration delay = const Duration(milliseconds: 0),
    Curve curve = Curves.easeOut,
  }) {
    return FadeOut(
      duration: duration,
      delay: delay,
      curve: curve,
      child: this,
    );
  }

  /// Aplica una animación de rebote
  Widget bounceIn({
    Duration duration = const Duration(milliseconds: 500),
    Duration delay = const Duration(milliseconds: 0),
    Curve curve = Curves.easeOut,
  }) {
    return BounceIn(
      duration: duration,
      delay: delay,
      curve: curve,
      child: this,
    );
  }

  /// Aplica una animación de desvanecimiento hacia abajo
  Widget fadeOutDown({
    Duration duration = const Duration(milliseconds: 800),
    Duration delay = const Duration(milliseconds: 0),
    double from = 100,
    Curve curve = Curves.easeOut,
  }) {
    return FadeOutDown(
      duration: duration,
      delay: delay,
      from: from,
      curve: curve,
      child: this,
    );
  }

  /// Más efectos personalizados...
}