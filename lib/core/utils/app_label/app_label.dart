import 'package:flutter/material.dart';

class AppLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? fontSize;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? height;
  final Gradient? gradient;
  const AppLabel({
    super.key,
    required this.text,
    this.style,
    this.color,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      style:
          style?.copyWith(color: color) ??
          TextStyle(
            color: color ?? Colors.black,
            fontWeight: fontWeight,
            fontSize: fontSize,
            fontStyle: fontStyle,
            decoration: decoration,
            letterSpacing: letterSpacing,
            height: height,
          ),
    );
  }
}
