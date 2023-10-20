/*
 Created by Thanh Son on 11/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_toast;

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
/// The shake value is the result of f(x) = amplitude * e^(-scale * t) * sin(frequency * t * pi)
/// with the t's speed is controlled by the [curve].
class ShakeTransitionDelegate with ToastTransitionDelegate {
  /// In default, the shake's effect is [Curves.bounceIn].
  const ShakeTransitionDelegate({
    this.amplitude = 50,
    this.curve = Curves.elasticOut,
    this.frequency = 3,
    this.dampingCoefficient = 3,
  });

  /// The shake's effect
  final Curve curve;

  /// Shake amplitude.
  final double amplitude;

  /// Shake frequency
  final double frequency;

  /// Shake damping coefficient.
  final double dampingCoefficient;

  @override
  Offset transition(AnimationStatus animationStatus, double animationValue) {
    if (animationStatus == AnimationStatus.forward) {
      return dampedOscillation(animationValue);
    }
    return const Offset(0, 0);
  }

  /// The shake value is the result of f(x) = amplitude * e^(-3t) * sin(frequency * t * pi)
  /// with the t's speed is controlled by the [curve].
  Offset dampedOscillation(double animationValue) {
    final shake = amplitude *
        math.exp(-dampingCoefficient * animationValue) *
        math.sin(frequency * curve.transform(animationValue).abs() * math.pi);
    return Offset(shake, 0);
  }

  /// The shake value is the result of f(x) = amplitude * sin(frequency * t * pi)
  /// with the t's speed is controlled by the [curve].
  // Offset harmonicOscillation(double animationValue) {
  //   final shake = amplitude * math.sin(frequency * curve.transform(animationValue).abs() * math.pi);
  //   return Offset(shake, 0);
  // }

  @override
  double opacity(AnimationStatus animationStatus, double animationValue) => switch (animationStatus) {
        AnimationStatus.dismissed => 0,
        AnimationStatus.forward => 1,
        AnimationStatus.reverse => limitIn(0, animationValue, 1),
        AnimationStatus.completed => 1,
      };
}
