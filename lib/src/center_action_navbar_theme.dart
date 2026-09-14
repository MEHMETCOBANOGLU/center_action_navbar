import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Visual configuration for [CenterActionNavbar].
///
/// Defaults match the original pill-shaped navbar with an orange accent and a
/// floating circular center action button.
@immutable
class CenterActionNavbarTheme {
  /// Creates a theme for [CenterActionNavbar].
  const CenterActionNavbarTheme({
    this.backgroundColor = const Color(0xFFFEFEFE),
    this.selectedColor = const Color.fromARGB(255, 255, 145, 0),
    this.unselectedColor = const Color.fromARGB(255, 128, 128, 128),
    this.borderColor = const Color(0xFFE5E5E5),
    this.height = 62,
    this.width,
    this.borderRadius = 28,
    this.padding = const EdgeInsets.symmetric(horizontal: 6),
    this.margin = const EdgeInsets.fromLTRB(14, 0, 14, 10),
    this.iconSize = 22,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 2),
    this.itemSpacing = 0,
    this.animationDuration = const Duration(milliseconds: 340),
    this.animationCurve = Curves.easeOutCubic,
    this.boxShadow,
    this.elevation,
    this.focusInsetVertical = 6,
    this.focusInsetHorizontal = 3,
    this.focusBorderRadius = 16,
    this.centerActionSize = 45,
    this.centerActionBackgroundColor,
    this.centerActionForegroundColor = Colors.white,
    this.centerActionElevation = 0,
    this.centerActionBorderRadius,
    this.centerActionShadow,
    this.centerActionOffset = 12,
    this.centerActionIconSize = 30,
    this.notchGap = 4,
    this.centerGapExtra = 8,
    this.showSelectedLabel = true,
    this.showUnselectedLabel = false,
    this.safeArea = true,
  })  : assert(height > 0),
        assert(iconSize > 0),
        assert(centerActionSize > 0),
        assert(centerActionIconSize > 0),
        assert(centerActionOffset >= 0),
        assert(notchGap >= 0),
        assert(borderRadius >= 0),
        assert(width == null || width > 0);

  /// Navbar container background color.
  final Color backgroundColor;

  /// Color used for the selected item icon, label, and focus highlight.
  final Color selectedColor;

  /// Color used for unselected item icons.
  final Color unselectedColor;

  /// Stroke color of the notched pill border.
  final Color borderColor;

  /// Height of the navbar pill (excluding the floating center action).
  final double height;

  /// Optional fixed width. When null, the navbar expands to available width.
  final double? width;

  /// Corner radius of the pill container.
  final double borderRadius;

  /// Inner padding of the navbar pill.
  final EdgeInsetsGeometry padding;

  /// Outer margin around the navbar (typically applied with [SafeArea]).
  final EdgeInsetsGeometry margin;

  /// Default icon size for navigation items.
  final double iconSize;

  /// Text style for the selected item label.
  ///
  /// When null, a compact bold style using [selectedColor] is applied.
  final TextStyle? selectedTextStyle;

  /// Text style for unselected labels when [showUnselectedLabel] is true.
  final TextStyle? unselectedTextStyle;

  /// Padding inside each navigation item slot.
  final EdgeInsetsGeometry itemPadding;

  /// Extra horizontal spacing between items (in addition to the center gap).
  final double itemSpacing;

  /// Duration for selection and focus animations.
  final Duration animationDuration;

  /// Curve for the sliding focus indicator.
  final Curve animationCurve;

  /// Shadow behind the navbar pill. When null, a soft default shadow is used.
  final List<BoxShadow>? boxShadow;

  /// Optional Material elevation for the navbar container.
  ///
  /// Prefer [boxShadow] for the default look. Elevation is applied only when
  /// non-null and greater than zero.
  final double? elevation;

  /// Vertical inset of the sliding focus highlight.
  final double focusInsetVertical;

  /// Horizontal inset of the sliding focus highlight.
  final double focusInsetHorizontal;

  /// Corner radius of the sliding focus highlight.
  final double focusBorderRadius;

  /// Diameter of the floating center action button.
  final double centerActionSize;

  /// Background color of the center action.
  ///
  /// When null, a subtle gradient based on [selectedColor] is used.
  final Color? centerActionBackgroundColor;

  /// Foreground/icon color of the center action.
  final Color centerActionForegroundColor;

  /// Material elevation of the center action button.
  final double centerActionElevation;

  /// Border radius of the center action. When null, a circle is used.
  final BorderRadius? centerActionBorderRadius;

  /// Optional shadow drawn behind the center action.
  final List<BoxShadow>? centerActionShadow;

  /// How far the center of the action sits above the top edge of the navbar.
  final double centerActionOffset;

  /// Icon size inside the center action when the child is an [Icon].
  final double centerActionIconSize;

  /// Gap between the center action edge and the notch path.
  final double notchGap;

  /// Extra width added to the reserved center gap in the item row.
  final double centerGapExtra;

  /// Whether to show the label for the selected item.
  final bool showSelectedLabel;

  /// Whether to show labels for unselected items.
  final bool showUnselectedLabel;

  /// Whether to wrap the navbar in a [SafeArea].
  final bool safeArea;

  /// Horizontal space reserved for the floating center action in the item row.
  double get centerGap =>
      (centerActionSize / 2 + notchGap) * 2 + centerGapExtra;

  /// Total widget height including the protruding center action.
  double get totalHeight => height + centerActionSize / 2 - centerActionOffset;

  /// Creates a copy with the given fields replaced.
  CenterActionNavbarTheme copyWith({
    Color? backgroundColor,
    Color? selectedColor,
    Color? unselectedColor,
    Color? borderColor,
    double? height,
    double? width,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? iconSize,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    EdgeInsetsGeometry? itemPadding,
    double? itemSpacing,
    Duration? animationDuration,
    Curve? animationCurve,
    List<BoxShadow>? boxShadow,
    double? elevation,
    double? focusInsetVertical,
    double? focusInsetHorizontal,
    double? focusBorderRadius,
    double? centerActionSize,
    Color? centerActionBackgroundColor,
    Color? centerActionForegroundColor,
    double? centerActionElevation,
    BorderRadius? centerActionBorderRadius,
    List<BoxShadow>? centerActionShadow,
    double? centerActionOffset,
    double? centerActionIconSize,
    double? notchGap,
    double? centerGapExtra,
    bool? showSelectedLabel,
    bool? showUnselectedLabel,
    bool? safeArea,
  }) {
    return CenterActionNavbarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      borderColor: borderColor ?? this.borderColor,
      height: height ?? this.height,
      width: width ?? this.width,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      iconSize: iconSize ?? this.iconSize,
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
      itemPadding: itemPadding ?? this.itemPadding,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      boxShadow: boxShadow ?? this.boxShadow,
      elevation: elevation ?? this.elevation,
      focusInsetVertical: focusInsetVertical ?? this.focusInsetVertical,
      focusInsetHorizontal: focusInsetHorizontal ?? this.focusInsetHorizontal,
      focusBorderRadius: focusBorderRadius ?? this.focusBorderRadius,
      centerActionSize: centerActionSize ?? this.centerActionSize,
      centerActionBackgroundColor:
          centerActionBackgroundColor ?? this.centerActionBackgroundColor,
      centerActionForegroundColor:
          centerActionForegroundColor ?? this.centerActionForegroundColor,
      centerActionElevation:
          centerActionElevation ?? this.centerActionElevation,
      centerActionBorderRadius:
          centerActionBorderRadius ?? this.centerActionBorderRadius,
      centerActionShadow: centerActionShadow ?? this.centerActionShadow,
      centerActionOffset: centerActionOffset ?? this.centerActionOffset,
      centerActionIconSize: centerActionIconSize ?? this.centerActionIconSize,
      notchGap: notchGap ?? this.notchGap,
      centerGapExtra: centerGapExtra ?? this.centerGapExtra,
      showSelectedLabel: showSelectedLabel ?? this.showSelectedLabel,
      showUnselectedLabel: showUnselectedLabel ?? this.showUnselectedLabel,
      safeArea: safeArea ?? this.safeArea,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CenterActionNavbarTheme &&
        other.backgroundColor == backgroundColor &&
        other.selectedColor == selectedColor &&
        other.unselectedColor == unselectedColor &&
        other.borderColor == borderColor &&
        other.height == height &&
        other.width == width &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.margin == margin &&
        other.iconSize == iconSize &&
        other.selectedTextStyle == selectedTextStyle &&
        other.unselectedTextStyle == unselectedTextStyle &&
        other.itemPadding == itemPadding &&
        other.itemSpacing == itemSpacing &&
        other.animationDuration == animationDuration &&
        other.animationCurve == animationCurve &&
        listEquals(other.boxShadow, boxShadow) &&
        other.elevation == elevation &&
        other.focusInsetVertical == focusInsetVertical &&
        other.focusInsetHorizontal == focusInsetHorizontal &&
        other.focusBorderRadius == focusBorderRadius &&
        other.centerActionSize == centerActionSize &&
        other.centerActionBackgroundColor == centerActionBackgroundColor &&
        other.centerActionForegroundColor == centerActionForegroundColor &&
        other.centerActionElevation == centerActionElevation &&
        other.centerActionBorderRadius == centerActionBorderRadius &&
        listEquals(other.centerActionShadow, centerActionShadow) &&
        other.centerActionOffset == centerActionOffset &&
        other.centerActionIconSize == centerActionIconSize &&
        other.notchGap == notchGap &&
        other.centerGapExtra == centerGapExtra &&
        other.showSelectedLabel == showSelectedLabel &&
        other.showUnselectedLabel == showUnselectedLabel &&
        other.safeArea == safeArea;
  }

  @override
  int get hashCode => Object.hashAll([
        backgroundColor,
        selectedColor,
        unselectedColor,
        borderColor,
        height,
        width,
        borderRadius,
        padding,
        margin,
        iconSize,
        selectedTextStyle,
        unselectedTextStyle,
        itemPadding,
        itemSpacing,
        animationDuration,
        animationCurve,
        boxShadow,
        elevation,
        focusInsetVertical,
        focusInsetHorizontal,
        focusBorderRadius,
        centerActionSize,
        centerActionBackgroundColor,
        centerActionForegroundColor,
        centerActionElevation,
        centerActionBorderRadius,
        centerActionShadow,
        centerActionOffset,
        centerActionIconSize,
        notchGap,
        centerGapExtra,
        showSelectedLabel,
        showUnselectedLabel,
        safeArea,
      ]);
}
