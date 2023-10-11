/*
 Created by Thanh Son on 11/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:overlay_manager/overlay_manager.dart';

import 'owlet_toast.dart';

/// Provides the animation builder to show the toast on UI.
/// At the same time, the toast has two animations, position translation, and opacity animation.
class ToastWidget extends StatefulWidget {
  /// The [ToastWidget]'s constructor.
  const ToastWidget({
    super.key,
    required this.holdDuration,
    required this.transitionDuration,
    required this.child,
    required this.entry,
    this.alignment = Alignment.bottomCenter,
    required this.transitionDelegate,
  });

  /// The [transitionDuration] is the duration the toast appears (or is dismissed) in animation;
  final Duration transitionDuration;

  ///  The [holdDuration] lets you know how long this toast showing on screen.
  final Duration holdDuration;

  /// The toast's ui widget.
  final Widget child;

  /// The  [OverlayManagerEntry] is to close the toast at the end of the time.
  final OverlayManagerEntry entry;

  /// Alignment of [child] on screen.  Bounds inside MediaQuery.viewInsetsOf(context)
  final Alignment alignment;

  /// The position translation and opacity animations delegated.
  final ToastTransitionDelegate transitionDelegate;

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: widget.transitionDuration);
  late final Animation<double> _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller
      ..addStatusListener(_onAnimateDone)
      ..forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.removeStatusListener(_onAnimateDone);
    _controller.dispose();
    super.dispose();
  }

  void _onAnimateDone(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _timer = Timer(widget.holdDuration, () {
        _controller.reverse();
      });
    } else if (status == AnimationStatus.dismissed) {
      widget.entry.close(null);
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _animation,
        child: widget.child,
        builder: (context, child) => Transform.translate(
          child: Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: Align(
                alignment: widget.alignment,
                child: Opacity(
                  opacity: widget.transitionDelegate.opacity(_controller.status, _controller.value),
                  child: child!,
                )),
          ),
          offset: widget.transitionDelegate.transition(_controller.status, _controller.value),
        ),
      );
}
