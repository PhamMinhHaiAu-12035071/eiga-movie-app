import 'package:flutter/material.dart';
import 'package:ksk_app/utils/context_x.dart';

/// Widget for the next button or completion button in onboarding
class OnboardingNextButton extends StatelessWidget {
  /// Constructor
  const OnboardingNextButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Text displayed on the button
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.sizes.h40),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.sizes.borderRadiusMd),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.colors.onboardingGradientStart,
              context.colors.onboardingGradientEnd,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(64),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: context.colors.white,
            backgroundColor: context.colors.transparent,
            shadowColor: context.colors.transparent,
            minimumSize: Size(double.infinity, context.sizes.v56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.sizes.borderRadiusMd),
            ),
          ),
          child: Text(
            text,
            style: context.textStyles.heading(
              color: context.colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
