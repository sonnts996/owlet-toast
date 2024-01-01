/*
 Created by Thanh Son on 11/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of '../owlet_toast.dart';

/// Using [OverlayManager] for show and manage the overlay widget as toast.
///
/// The [ToastWidget] provides a animation builder with [ToastTransitionDelegate] as transition behavior when the toast appear (or dismiss).
///
/// The [OwletToast] does not define your toast appearance, Overrides [OwletToast.buildToast] to return your toast's UI.
class OwletToast {
  /// Using [OverlayManager] to manage your toast.
  /// Using [GlobalOverlayManager] to create a global toast
  /// or [ContextOverlayManager] for a definitions context toast.
  const OwletToast({
    required this.overlayManager,
    this.defaultDelegate = const FadeTransitionDelegate(),
    this.defaultAlignment = Alignment.bottomCenter,
    this.defaultHoldDuration = const Duration(seconds: 1),
    this.defaultTransitionDuration = const Duration(milliseconds: 350),
  });

  /// Create global [OwletToast] with [navigatorKey]
  factory OwletToast.global(
    GlobalKey<NavigatorState> navigatorKey, {
    ToastTransitionDelegate defaultDelegate = const FadeTransitionDelegate(),
    Duration defaultTransitionDuration = const Duration(milliseconds: 350),
    Duration defaultHoldDuration = const Duration(seconds: 1),
    Alignment defaultAlignment = Alignment.bottomCenter,
  }) {
    final overlayManager = GlobalOverlayManager(navigatorKey: navigatorKey);
    return OwletToast(
      overlayManager: overlayManager,
      defaultAlignment: defaultAlignment,
      defaultDelegate: defaultDelegate,
      defaultHoldDuration: defaultHoldDuration,
      defaultTransitionDuration: defaultTransitionDuration,
    );
  }

  /// Create [OwletToast] with [context]
  factory OwletToast.of(
    BuildContext context, {
    ToastTransitionDelegate defaultDelegate = const FadeTransitionDelegate(),
    Duration defaultTransitionDuration = const Duration(milliseconds: 350),
    Duration defaultHoldDuration = const Duration(seconds: 1),
    Alignment defaultAlignment = Alignment.bottomCenter,
  }) {
    final overlayManager = ContextOverlayManager(context: context);
    return OwletToast(
      overlayManager: overlayManager,
      defaultAlignment: defaultAlignment,
      defaultDelegate: defaultDelegate,
      defaultHoldDuration: defaultHoldDuration,
      defaultTransitionDuration: defaultTransitionDuration,
    );
  }

  /// The toast's overlay manager
  final OverlayManager overlayManager;

  /// Default value of show.transitionDelegate
  final ToastTransitionDelegate defaultDelegate;

  /// Default value of show.transitionDuration
  final Duration defaultTransitionDuration;

  /// Default value of show.holdDuration
  final Duration defaultHoldDuration;

  /// Default value of show.alignment
  final Alignment defaultAlignment;

  /// Returns your toast's widget to display in the application.
  Widget buildToast(BuildContext context, ToastEntry entry, Widget? child) =>
      child!;

  /// Call to show your toast. This method can await the result (if your toast has the returned resulting action).
  /// In default, if the toast closes automatically (such as end of the time), the result is returned null.
  ///
  /// The [transitionDuration] is the duration for the toast appears (or is dismissed) in animation;
  /// And [holdDuration] lets you know how long this toast showing on screen.
  ///
  /// The zero position (Offset(0,0)) of this toast on the screen is decided by [alignment].
  ///
  /// Default of [transitionDelegate] is [TranslateTransitionDelegate].
  Future<R?> show<R extends Object?>({
    Duration? transitionDuration,
    Duration? holdDuration,
    Alignment? alignment,
    ToastTransitionDelegate? transitionDelegate,
    ToastBuilder? builder,
    Widget? child,
    double elevation = 0,
  }) {
    assert(child != null || builder != null,
        'Toast child or builder must be special!');
    final completer = Completer<R?>();

    overlayManager.show<R?>(
      builder: (context, entry) => ToastWidget<R?>(
        transitionDuration: transitionDuration ?? defaultTransitionDuration,
        holdDuration: holdDuration ?? defaultHoldDuration,
        builder: builder ?? buildToast,
        entry: entry,
        transitionDelegate: transitionDelegate ?? defaultDelegate,
        alignment: alignment ?? defaultAlignment,
        child: child,
      ),
      mode: OverlayMode.transparent,
      onDismiss: completer.complete,
      elevation: elevation,
    );
    return completer.future;
  }
}
