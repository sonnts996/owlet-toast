/*
 Created by Thanh Son on 11/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'dart:ui';

extension ColorX on Color {
  Color get textColor =>
      isLight ? const Color(0xFF000000) : const Color(0xFFFFFFFF);

  bool get isLight => computeLuminance() > 0.5;
}
