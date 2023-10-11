/*
 Created by Thanh Son on 11/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:overlay_manager/overlay_manager.dart';

import '../_internal.dart';
import 'toast_transition_delegate.dart';
import 'toast_widget.dart';

/// The [OwletToast.buildToast] parameters.
/// The [OverlayManager] will create a new [OverlayManagerEntry] to control this toast, [OwletToast] wrap it into ToastEntry.
///
/// The [ToastEntry.close] provides a method to force close this entry.
/// Data used for building the toast widget contains the message's [type] and message's [data].
class ToastEntry<T extends Object, E extends Object?> {
  /// Create a new [ToastEntry].
  const ToastEntry(this._entry, {required this.type, required this.data});

  /// The overlay entry control this toast
  final OverlayManagerEntry _entry;

  /// The type of this toast should be an enum:
  /// Example:
  ///
  /// ```
  /// enum ToastType {
  ///   information, error, waring, develop;
  /// }
  /// ```
  final T type;

  /// The data to build this toast.
  final E? data;

  /// Call to force close this toast.
  ///
  /// No animation if call it. The [value] will be returned in [OwletToast.show] method.
  void close([Object? value]) => _entry.close(value);
}

/// Define how the toast's appearance (or dismission) is animated.
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
  double opacity(AnimationStatus animationStatus, double animationValue) => limitIn(0, animationValue, 1);
}

/// Using [OverlayManager] to show and manage the overlay widget as toast.
///
/// The [ToastWidget] provides a animation builder with [ToastTransitionDelegate] as transition behavior when the toast appear (or dismiss).
///
/// The [OwletToast] does not define your toast appearance, Overrides [OwletToast.buildToast] to return your toast's UI.
abstract class OwletToast<T extends Object, E extends Object?> {

  /// Using [OverlayManager] to manage your toast.
  /// Using [GlobalOverlayManager] to create a global toast
  /// or [ContextOverlayManager] for a definitions context toast.
  OwletToast({required this.overlayManager});

  /// The toast's overlay manager
  final OverlayManager overlayManager;

  /// Returns your toast's widget to display in the application.
  Widget buildToast(BuildContext context, ToastEntry<T, E> entry);

  /// Call to show your toast. This method can await the result (if your toast has the returned resulting action).
  /// In default, if the toast closes automatically (such as end of the time), the result is returned null.
  ///
  /// The [type] and [data] will be transferred to [buildToast] to build the toast's widget.
  /// The [type] lets you know which type of the toast (such as information, error, waring), and the [data] is the toast's user data.
  ///
  /// The [transitionDuration] is the duration the toast appears (or is dismissed) in animation;
  ///  And [holdDuration] lets you know how long this toast showing on screen. (exclude animations)
  ///
  /// The zero position (Offset(0,0)) of this toast on the screen is decided by [alignment].
  ///
  /// Default of [transitionDelegate] is [LinearTransitionDelegate].
  Future<R?> show<R extends Object>({
    required T type,
    E? data,
    Duration transitionDuration = const Duration(milliseconds: 350),
    Duration holdDuration = const Duration(seconds: 1),
    Alignment alignment = Alignment.bottomCenter,
    ToastTransitionDelegate? transitionDelegate,
  }) {
    final completer = Completer<R?>();

    overlayManager.show<R?>(
      builder: (context, entry) => ToastWidget(
        transitionDuration: transitionDuration,
        holdDuration: holdDuration,
        child: buildToast(context, ToastEntry<T, E>(entry, type: type, data: data)),
        entry: entry,
        transitionDelegate: transitionDelegate ?? LinearTransitionDelegate(direction: alignment),
        alignment: alignment,
      ),
      mode: OverlayMode.transparent,
      onDismiss: completer.complete,
    );
    return completer.future;
  }
}
