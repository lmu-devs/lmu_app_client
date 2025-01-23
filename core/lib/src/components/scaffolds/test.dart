import 'package:flutter/widgets.dart';

/// Scroll physics that behaves as [ClampingScrollPhysics] at the top of the scroll
/// and as the default [ScrollPhysics] on the bottom.
///
/// This means that on iOS it will behave like [ClampingScrollPhysics] at the top and [BouncingScrollPhysics] at the bottom.
/// And on Android, it will behave like [ClampingScrollPhysics] at the top and at the bottom of the scroll.
///
/// See also:
///
///  * [BouncingScrollPhysics], which is the analogous physics for iOS' bouncing behavior.
///  * [ClampingScrollPhysics], which is the analogous physics for Android's clamping behavior.
///  * [ScrollPhysics], for more examples of combining [ScrollPhysics] objects of different types to get the desired scroll physics.
class BottomSheetScrollPhysics extends ScrollPhysics {
  /// Creates scroll physics that behaves as [ClampingScrollPhysics] at the top of the scroll
  /// and as the default [ScrollPhysics] on the bottom.
  const BottomSheetScrollPhysics({super.parent});

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BottomSheetScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // Prevents scrolling over the top of the scroll
    if (value < position.pixels && position.pixels <= position.minScrollExtent) {
      // Underscroll
      return value - position.pixels;
    } else if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) {
      // Hit top edge
      return value - position.minScrollExtent;
    }

    return super.applyBoundaryConditions(position, value);
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    // It doesn't create a simulation when scrolling over the top of the scroll
    if (position.pixels <= position.minScrollExtent && velocity < 0.0) {
      return null;
    }

    return super.createBallisticSimulation(position, velocity);
  }
}
