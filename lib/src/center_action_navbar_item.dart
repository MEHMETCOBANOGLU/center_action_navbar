import 'package:flutter/material.dart';

/// A single destination in a [CenterActionNavbar].
@immutable
class CenterActionNavbarItem {
  /// Creates a navigation item.
  ///
  /// Prefer providing both [icon] and [activeIcon] for a polished selected
  /// state. When [activeIcon] is null, [icon] is used for both states.
  const CenterActionNavbarItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.badge = 0,
    this.tooltip,
    this.semanticLabel,
  }) : assert(badge >= 0);

  /// Icon shown when the item is not selected.
  final IconData icon;

  /// Icon shown when the item is selected. Defaults to [icon].
  final IconData? activeIcon;

  /// Short label displayed under the icon when selected (by default).
  final String label;

  /// Optional numeric badge shown on the icon. Values above 99 render as `99+`.
  final int badge;

  /// Optional tooltip for long-press / accessibility hints.
  final String? tooltip;

  /// Optional semantic label for screen readers. Defaults to [label].
  final String? semanticLabel;

  /// Icon used for the selected state.
  IconData get resolvedActiveIcon => activeIcon ?? icon;

  /// Creates a copy with the given fields replaced.
  CenterActionNavbarItem copyWith({
    IconData? icon,
    IconData? activeIcon,
    String? label,
    int? badge,
    String? tooltip,
    String? semanticLabel,
  }) {
    return CenterActionNavbarItem(
      icon: icon ?? this.icon,
      activeIcon: activeIcon ?? this.activeIcon,
      label: label ?? this.label,
      badge: badge ?? this.badge,
      tooltip: tooltip ?? this.tooltip,
      semanticLabel: semanticLabel ?? this.semanticLabel,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CenterActionNavbarItem &&
        other.icon == icon &&
        other.activeIcon == activeIcon &&
        other.label == label &&
        other.badge == badge &&
        other.tooltip == tooltip &&
        other.semanticLabel == semanticLabel;
  }

  @override
  int get hashCode => Object.hash(
        icon,
        activeIcon,
        label,
        badge,
        tooltip,
        semanticLabel,
      );
}
