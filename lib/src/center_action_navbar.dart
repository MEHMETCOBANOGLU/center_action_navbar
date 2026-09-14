import 'package:flutter/material.dart';

import 'center_action_navbar_item.dart';
import 'center_action_navbar_theme.dart';
import 'nav_focus_indicator.dart';
import 'nav_item_button.dart';
import 'notched_nav_border.dart';

/// A customizable bottom navigation bar with a floating center action button.
///
/// Place this widget in [Scaffold.bottomNavigationBar] (or any overlay). The
/// package does not perform routing — use [onTap] and [onCenterActionTap] to
/// update your own state.
///
/// Items are split evenly around the center action: the first half appear on
/// the left, the second half on the right. An even [items] length is
/// recommended when [showCenterAction] is true.
class CenterActionNavbar extends StatelessWidget {
  /// Creates a center-action bottom navigation bar.
  const CenterActionNavbar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.centerAction,
    this.onCenterActionTap,
    this.centerActionTooltip,
    this.centerActionSemanticLabel,
    this.showCenterAction = true,
    this.theme = const CenterActionNavbarTheme(),
  })  : assert(items.length >= 2, 'Provide at least 2 navigation items.'),
        assert(currentIndex >= 0, 'currentIndex must be >= 0.');

  /// Index of the currently selected item in [items].
  final int currentIndex;

  /// Navigation destinations displayed around the center action.
  final List<CenterActionNavbarItem> items;

  /// Called when a navigation item is tapped with its index in [items].
  final ValueChanged<int> onTap;

  /// Widget shown inside the floating center action button.
  ///
  /// Defaults to a white rounded `+` icon when null.
  final Widget? centerAction;

  /// Called when the floating center action is tapped.
  final VoidCallback? onCenterActionTap;

  /// Tooltip for the center action button.
  final String? centerActionTooltip;

  /// Semantic label for the center action button.
  final String? centerActionSemanticLabel;

  /// Whether to show the floating center action and the matching notch.
  final bool showCenterAction;

  /// Visual configuration. Defaults preserve the original design.
  final CenterActionNavbarTheme theme;

  @override
  Widget build(BuildContext context) {
    assert(
      currentIndex < items.length,
      'currentIndex ($currentIndex) is out of range for ${items.length} items.',
    );
    assert(
      !showCenterAction || items.length.isEven,
      'Use an even number of items so the center action sits between equal sides.',
    );

    final resolvedTheme = theme;
    final mid = items.length ~/ 2;
    final leftItems = items.sublist(0, mid);
    final rightItems = items.sublist(mid);
    final centerGap = showCenterAction ? resolvedTheme.centerGap : 0.0;
    final safeIndex = currentIndex.clamp(0, items.length - 1);

    Widget bar = SizedBox(
      width: resolvedTheme.width,
      height:
          showCenterAction ? resolvedTheme.totalHeight : resolvedTheme.height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _NavbarPill(
              theme: resolvedTheme,
              currentIndex: safeIndex,
              items: items,
              leftItems: leftItems,
              rightItems: rightItems,
              centerGap: centerGap,
              showCenter: showCenterAction,
              onTap: onTap,
            ),
          ),
          if (showCenterAction)
            Positioned(
              top: 0,
              child: _CenterActionButton(
                theme: resolvedTheme,
                onTap: onCenterActionTap,
                tooltip: centerActionTooltip,
                semanticLabel: centerActionSemanticLabel,
                child: centerAction,
              ),
            ),
        ],
      ),
    );

    if (resolvedTheme.safeArea) {
      bar = SafeArea(
        minimum: resolvedTheme.margin.resolve(Directionality.of(context)),
        child: bar,
      );
    } else {
      bar = Padding(padding: resolvedTheme.margin, child: bar);
    }

    return Material(
      type: MaterialType.transparency,
      child: bar,
    );
  }
}

class _NavbarPill extends StatelessWidget {
  const _NavbarPill({
    required this.theme,
    required this.currentIndex,
    required this.items,
    required this.leftItems,
    required this.rightItems,
    required this.centerGap,
    required this.showCenter,
    required this.onTap,
  });

  final CenterActionNavbarTheme theme;
  final int currentIndex;
  final List<CenterActionNavbarItem> items;
  final List<CenterActionNavbarItem> leftItems;
  final List<CenterActionNavbarItem> rightItems;
  final double centerGap;
  final bool showCenter;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final shadows = theme.boxShadow ??
        [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ];

    final ShapeBorder shape = showCenter
        ? NotchedNavBorder(
            borderColor: theme.borderColor,
            notchCenterY: theme.centerActionOffset,
            notchRadius: theme.centerActionSize / 2 + theme.notchGap,
            cornerRadius: theme.borderRadius,
          )
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.borderRadius),
            side: BorderSide(color: theme.borderColor),
          );

    return Material(
      elevation: theme.elevation ?? 0,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Container(
        height: theme.height,
        padding: theme.padding,
        decoration: ShapeDecoration(
          color: theme.backgroundColor,
          shape: shape,
          shadows: shadows,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            NavFocusIndicator(
              index: currentIndex,
              slotCount: items.length,
              centerGap: centerGap,
              color: theme.selectedColor,
              theme: theme,
            ),
            Row(
              children: [
                for (var i = 0; i < leftItems.length; i++) ...[
                  if (i > 0 && theme.itemSpacing > 0)
                    SizedBox(width: theme.itemSpacing),
                  NavItemButton(
                    item: leftItems[i],
                    selected: currentIndex == i,
                    onTap: () => onTap(i),
                    theme: theme,
                  ),
                ],
                if (showCenter) SizedBox(width: centerGap),
                for (var i = 0; i < rightItems.length; i++) ...[
                  if (i > 0 && theme.itemSpacing > 0)
                    SizedBox(width: theme.itemSpacing),
                  NavItemButton(
                    item: rightItems[i],
                    selected: currentIndex == leftItems.length + i,
                    onTap: () => onTap(leftItems.length + i),
                    theme: theme,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterActionButton extends StatelessWidget {
  const _CenterActionButton({
    required this.theme,
    required this.onTap,
    required this.tooltip,
    required this.semanticLabel,
    required this.child,
  });

  final CenterActionNavbarTheme theme;
  final VoidCallback? onTap;
  final String? tooltip;
  final String? semanticLabel;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bg = theme.centerActionBackgroundColor;
    final radius = theme.centerActionBorderRadius;
    final isCircle = radius == null;
    final shape = isCircle
        ? const CircleBorder()
        : RoundedRectangleBorder(borderRadius: radius);

    final decoration = BoxDecoration(
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: isCircle ? null : radius,
      color: bg,
      gradient: bg == null
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(theme.selectedColor, Colors.white, 0.14)!,
                theme.selectedColor,
              ],
            )
          : null,
      boxShadow: theme.centerActionShadow,
    );

    Widget button = Material(
      type: MaterialType.transparency,
      elevation: theme.centerActionElevation,
      shadowColor: Colors.black26,
      shape: shape,
      child: Ink(
        width: theme.centerActionSize,
        height: theme.centerActionSize,
        decoration: decoration,
        child: InkWell(
          onTap: onTap,
          customBorder: shape,
          splashColor: Colors.white.withValues(alpha: 0.18),
          highlightColor: Colors.white.withValues(alpha: 0.08),
          child: IconTheme(
            data: IconThemeData(
              color: theme.centerActionForegroundColor,
              size: theme.centerActionIconSize,
            ),
            child: Center(
              child: child ??
                  Icon(
                    Icons.add_rounded,
                    color: theme.centerActionForegroundColor,
                    size: theme.centerActionIconSize,
                  ),
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return Semantics(
      button: true,
      label: semanticLabel ?? tooltip ?? 'Center action',
      child: button,
    );
  }
}
