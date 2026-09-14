import 'package:flutter/material.dart';

import 'center_action_navbar_item.dart';
import 'center_action_navbar_theme.dart';

/// A single tappable destination inside [CenterActionNavbar].
class NavItemButton extends StatelessWidget {
  /// Creates a navigation item button.
  const NavItemButton({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
    required this.theme,
  });

  /// Item model describing icon, label, and badge.
  final CenterActionNavbarItem item;

  /// Whether this item is currently selected.
  final bool selected;

  /// Called when the item is tapped.
  final VoidCallback onTap;

  /// Visual configuration.
  final CenterActionNavbarTheme theme;

  @override
  Widget build(BuildContext context) {
    final selectedStyle = theme.selectedTextStyle ??
        TextStyle(
          color: theme.selectedColor,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          height: 1.1,
        );
    final unselectedStyle = theme.unselectedTextStyle ??
        TextStyle(
          color: theme.unselectedColor,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          height: 1.1,
        );

    final showLabel =
        selected ? theme.showSelectedLabel : theme.showUnselectedLabel;

    final semantic = item.semanticLabel ?? item.label;
    final button = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: theme.focusInsetVertical,
          horizontal: theme.focusInsetHorizontal,
        ),
        padding: theme.itemPadding,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedScale(
                  scale: selected ? 1.08 : 1,
                  duration: theme.animationDuration,
                  curve: Curves.easeOutBack,
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      end: selected
                          ? theme.selectedColor
                          : theme.unselectedColor,
                    ),
                    duration: theme.animationDuration,
                    curve: Curves.easeOut,
                    builder: (context, color, _) => Icon(
                      selected ? item.resolvedActiveIcon : item.icon,
                      color: color,
                      size: theme.iconSize,
                    ),
                  ),
                ),
                if (item.badge > 0)
                  Positioned(
                    right: -8,
                    top: -6,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: theme.selectedColor,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        item.badge > 99 ? '99+' : '${item.badge}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (theme.showSelectedLabel || theme.showUnselectedLabel)
              TweenAnimationBuilder<double>(
                tween: Tween(end: showLabel ? 1 : 0),
                duration: theme.animationDuration,
                curve: Curves.easeOutCubic,
                builder: (context, t, child) => ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: t,
                    child: Opacity(opacity: t, child: child),
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    item.label,
                    maxLines: 1,
                    softWrap: false,
                    style: selected ? selectedStyle : unselectedStyle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    final themed = item.tooltip == null
        ? button
        : Tooltip(message: item.tooltip!, child: button);

    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: semantic,
        child: themed,
      ),
    );
  }
}
