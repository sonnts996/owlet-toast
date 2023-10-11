/*
 Created by Thanh Son on 11/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'dart:math' as math;

/// Returns [value] if value in ranges [min] - [max]
/// If the value is smaller than [min], returns [min], otherwise, if the value is larger than [max], the [max] is returned.
T limitIn<T extends num>(T min, T value, T max) => math.min(max, math.max(min, value));
