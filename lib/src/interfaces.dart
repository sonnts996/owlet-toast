/*
 Created by Thanh Son on 12/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of '../owlet_toast.dart';

/// Build and return the toast's UI widget with updated animation.
typedef ToastBuilder = Widget Function(
  BuildContext context,
  ToastEntry entry,
  Widget? child,
);

/// The OwletToast.buildToast parameters.
/// The [OverlayManager] will create a new [OverlayManagerEntry] to control this toast, [OwletToast] wraps it into [ToastEntry].
///
/// The [ToastEntry.close] provides a method to force close this entry.
class ToastEntry {
  /// Create a new [ToastEntry].
  const ToastEntry(
    this._entry, {
    this.status = AnimationStatus.dismissed,
    this.value = 0,
  });

  /// The overlay entry control this toast
  final OverlayManagerEntry _entry;

  /// The updated animation status
  final AnimationStatus status;

  /// The updated animation value
  final double value;

  /// Call to force close this toast.
  ///
  /// No animation if call it. The [value] will be returned in [OwletToast.show] method.
  void close([Object? value]) => _entry.close(value);
}

/// Define the animation which is how the toast appears (or is dismissed)..
mixin ToastTransitionDelegate {
  /// Call every when animation updates to calculate the position of toast widget on screen.
  /// The original offset is Offset(0, 0).
  ///
  /// The [animationValue] is in the range [0...1]
  /// The [animationStatus] gives the animation that happens (forward or reverse).
  Offset transition(AnimationStatus animationStatus, double animationValue);

  /// Call every when animation updates to calculate the opacity of toast widget on screen.
  /// Note that the opacity value must be in the range [0...1]
  ///
  /// The [animationValue] is in the range [0...1]
  /// The [animationStatus] gives the animation that happens (forward or reverse).
  double opacity(AnimationStatus animationStatus, double animationValue) =>
      animationValue.clamp(0, 1);
}
