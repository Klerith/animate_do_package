/// Marker mixin applied to animation states whose visible position must be
/// reset (instead of reversed) when [AnimateDoBaseWidget.animate] flips from
/// `true` to `false`.
///
/// Animations that loop or oscillate (RubberBand, Bounce, HeartBeat, Swing,
/// Wobble, Jello, ...) usually look better being snapped back to their
/// initial value rather than playing the inverse animation, since their
/// `Tween` sequences are not symmetric.
///
/// Mix this in on the corresponding `State` class to opt into that behavior.
mixin ResetOnReverseAnimation {}
