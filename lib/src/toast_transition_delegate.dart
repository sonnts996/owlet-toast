/*
 Created by Thanh Son on 11/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/widgets.dart';

import '../_internal.dart';
import 'owlet_toast.dart';

/// Make the toast transforms transition when appears and dismiss.
/// The [direction] should be the same as toast alignment. Follow by [direction]:
/// - The toast transforms from the top, if the direction is [Alignment.topCenter],
/// and transform from the bottom in case [Alignment.bottomCenter]
/// - Otherwise, if the direction is started on the left, the transitions will be transformed from the left edge. And from the right if the direction is started on the right.
/// - In the other direction, the toast stands in its original position.
class TranslateTransitionDelegate with ToastTransitionDelegate {
  /// The [TranslateTransitionDelegate]'s constructor.
  /// In default, the transition will start at 200 from the original position by the [direction].
  const TranslateTransitionDelegate({required this.direction, this.destination = 0, this.start = 200});

  /// The transform's direction
  final Alignment direction;
  /// The finish offset of the transform transition position
  final double destination;

  /// The start offset of the transform transition position
  final double start;

  @override
  Offset transition(AnimationStatus animationStatus, double animationValue) {
    if (direction == Alignment.bottomCenter) {
      return Offset(0, start * (1 - animationValue) + animationValue * destination);
    } else if (direction == Alignment.topCenter) {
      return Offset(0, start * (animationValue - 1) + animationValue * destination);
    } else if (direction.x == -1) {
      return Offset(start * (animationValue - 1) + animationValue * destination, 0);
    } else if (direction.x == 1) {
      return Offset(start * (1 - animationValue) + animationValue * destination, 0);
    }
    return const Offset(0, 0);
  }
}

/// Make the toast fade when appears and dismiss.
class FadeTransitionDelegate with ToastTransitionDelegate {
  /// The [FadeTransitionDelegate]'s constructor
  const FadeTransitionDelegate();

  @override
  Offset transition(AnimationStatus animationStatus, double animationValue) => const Offset(0, 0);
}

/// Make the toast shake on appear and fade on dismissed.
class ShakeTransitionDelegate with ToastTransitionDelegate {
  /// In default, the shake's effect is [Curves.bounceOut.
  const ShakeTransitionDelegate({this.scale = 50, this.shakeCurve = Curves.bounceOut});

  /// The shake's effect
  final Curve shakeCurve;

  /// shake amplitude can be multiplied by [scale].
  final double scale;

  @override
  Offset transition(AnimationStatus animationStatus, double animationValue) {
    if (animationStatus == AnimationStatus.forward) {
      final shake = 2 * (0.5 - (0.5 - shakeCurve.transform(animationValue)).abs());
      return Offset(scale * shake, 0);
    }
    return const Offset(0, 0);
  }

  @override
  double opacity(AnimationStatus animationStatus, double animationValue) => switch (animationStatus) {
        AnimationStatus.dismissed => 0,
        AnimationStatus.forward => 1,
        AnimationStatus.reverse => limitIn(0, animationValue, 1),
        AnimationStatus.completed => 1,
      };
}
