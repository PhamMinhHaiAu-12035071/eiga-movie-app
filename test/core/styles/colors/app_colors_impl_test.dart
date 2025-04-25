import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ksk_app/core/styles/colors/app_colors_impl.dart';

void main() {
  late AppColorsImpl colors;

  setUp(() {
    colors = const AppColorsImpl();
  });

  test('AppColorsImpl returns correct MaterialColors and Colors', () {
    expect(colors.primary, isA<MaterialColor>());
    expect(colors.secondary, isA<MaterialColor>());
    expect(colors.black, isA<MaterialColor>());
    expect(colors.white, isA<MaterialColor>());
    expect(colors.grey, isA<MaterialColor>());
    expect(colors.onboardingBlue, isA<MaterialColor>());

    expect(colors.bgMain, const Color(0xFFFFFFFF));
    expect(colors.accent, const Color(0xFFE0E7FF));
    expect(colors.textPrimary, const Color(0xFF1E293B));
    expect(colors.textSecondary, const Color(0xFF64748B));
    expect(colors.slateBlue, const Color(0xFF607395));
    expect(colors.onboardingBackground, const Color(0xFFE9F0F2));
    expect(colors.onboardingGradientStart, const Color(0xFF00B3C6));
    expect(colors.onboardingGradientEnd, const Color(0xFF5D84B4));
    expect(colors.bgMainDark, const Color(0xFF121212));
    expect(colors.primaryDark, const Color(0xFF3B82F6));
    expect(colors.secondaryDark, const Color(0xFF6366F1));
    expect(colors.accentDark, const Color(0xFF1E293B));
    expect(colors.textPrimaryDark, const Color(0xFFF1F5F9));
    expect(colors.textSecondaryDark, const Color(0xFFCBD5E1));
    expect(colors.transparent, Colors.transparent);
  });
}
