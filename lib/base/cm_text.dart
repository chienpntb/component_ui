import 'package:flutter/material.dart';

class CmText extends StatelessWidget {
  const CmText({super.key,
    required this.text,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.textStyle,
    this.padding = const EdgeInsets.all(0)
  });

  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? textStyle;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: textStyle
      ),
    );
  }
}