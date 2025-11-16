import 'package:flutter/material.dart';

extension ColorAlphaFraction on Color {
  Color withAlphaFraction(double fraction) {
    final clamped = fraction.clamp(0.0, 1.0);
    return withValues(alpha: clamped);
  }
}

