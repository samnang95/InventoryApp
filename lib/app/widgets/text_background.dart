import 'package:flutter/material.dart';

class TextBackground extends StatelessWidget {
  final String text;
  final Color? backgroundColor;   // ⬅️ optional now
  final Color? textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final double fontSize;
  final FontWeight fontWeight;

  const TextBackground({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    this.fontSize = 12,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Theme.of(context).colorScheme.primary,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}