import 'package:flutter/material.dart';

import 'center_action_navbar_theme.dart';

/// Sliding rounded highlight behind the selected navigation item.
class NavFocusIndicator extends StatelessWidget {
  /// Creates a focus indicator for [slotCount] evenly spaced slots.
  const NavFocusIndicator({
    super.key,
    required this.index,
    required this.slotCount,
    required this.centerGap,
    required this.color,
    required this.theme,
  });

  /// Currently selected slot index.
  final int index;

  /// Total number of navigation item slots.
  final int slotCount;

  /// Reserved middle gap width for the center action.
  final double centerGap;

  /// Accent color for the highlight fill and border.
  final Color color;

  /// Theme providing insets, radius, and animation settings.
  final CenterActionNavbarTheme theme;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final slot = (constraints.maxWidth - centerGap) / slotCount;
          final left = index * slot + (index >= slotCount ~/ 2 ? centerGap : 0);
          return Stack(
            children: [
              AnimatedPositioned(
                duration: theme.animationDuration,
                curve: theme.animationCurve,
                left: left + theme.focusInsetHorizontal,
                width: slot - theme.focusInsetHorizontal * 2,
                top: theme.focusInsetVertical,
                bottom: theme.focusInsetVertical,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(theme.focusBorderRadius),
                    border: Border.all(
                      color: color.withValues(alpha: 0.15),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
