import 'package:flutter/material.dart';

/// Rounded pill border with a soft circular notch for the center action.
class NotchedNavBorder extends ShapeBorder {
  /// Creates a notched navbar border.
  const NotchedNavBorder({
    required this.borderColor,
    required this.notchCenterY,
    required this.notchRadius,
    this.cornerRadius = 28,
    this.strokeWidth = 1,
  });

  /// Border stroke color.
  final Color borderColor;

  /// Vertical offset of the notch center relative to the top of the bar.
  ///
  /// Positive values place the notch center above the top edge.
  final double notchCenterY;

  /// Radius of the circular notch.
  final double notchRadius;

  /// Corner radius of the pill.
  final double cornerRadius;

  /// Border stroke width.
  final double strokeWidth;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final guest = Rect.fromCircle(
      center: Offset(rect.center.dx, rect.top + notchCenterY),
      radius: notchRadius,
    );
    final notched = const CircularNotchedRectangle().getOuterPath(rect, guest);
    final rounded = Path()
      ..addRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius)),
      );
    return Path.combine(PathOperation.intersect, notched, rounded);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    canvas.drawPath(
      getOuterPath(rect),
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
  }

  @override
  ShapeBorder scale(double t) => NotchedNavBorder(
        borderColor: borderColor,
        notchCenterY: notchCenterY * t,
        notchRadius: notchRadius * t,
        cornerRadius: cornerRadius * t,
        strokeWidth: strokeWidth * t,
      );

  @override
  bool operator ==(Object other) =>
      other is NotchedNavBorder &&
      other.borderColor == borderColor &&
      other.notchCenterY == notchCenterY &&
      other.notchRadius == notchRadius &&
      other.cornerRadius == cornerRadius &&
      other.strokeWidth == strokeWidth;

  @override
  int get hashCode => Object.hash(
        borderColor,
        notchCenterY,
        notchRadius,
        cornerRadius,
        strokeWidth,
      );
}
