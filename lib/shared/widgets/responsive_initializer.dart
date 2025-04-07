import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nil/nil.dart' show nil;

/// A widget that initializes responsive scaling for its child widget.
///
/// This widget uses [ScreenUtil] to enable responsive scaling based on
/// the screen size or a provided design size. It handles the initialization
/// of screen metrics to ensure consistent UI across different device sizes.
///
/// Usage:
/// ```dart
/// ResponsiveInitializer(
///   builder: (context) => YourWidget(),
///   designSize: const Size(375, 812), // Optional design size (iPhone X dimensions)
/// )
/// ```
class ResponsiveInitializer extends StatelessWidget {
  /// Creates a ResponsiveInitializer widget.
  ///
  /// The [builder] parameter is required and is used to build the child widget
  /// after responsive scaling has been initialized.
  ///
  /// The optional [designSize] parameter specifies the reference design size.
  /// If not provided, the current constraints of the layout will be used.
  const ResponsiveInitializer({
    required this.builder,
    super.key,
    this.designSize,
  });

  /// Function to build the child widget after initialization.
  final Widget Function(BuildContext context) builder;

  /// Optional design size reference for responsive scaling.
  final Size? designSize;

  @override
  Widget build(BuildContext context) => MediaQuery(
        data: MediaQueryData.fromView(View.of(context)),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth != 0) {
              // Initialize ScreenUtil with the current constraints or provided
              // design size
              ScreenUtil.init(
                context,
                designSize: Size(
                  designSize?.width ?? constraints.maxWidth,
                  designSize?.height ?? constraints.maxHeight,
                ),
              );

              return builder(context);
            }

            // Return an empty container if constraints are not valid
            return nil;
          },
        ),
      );
}
