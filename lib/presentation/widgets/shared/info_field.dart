import 'package:flutter/material.dart';

class InfoField extends StatelessWidget {
  final String label;
  final String value;
  final double spacing;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const InfoField({
    super.key,
    required this.label,
    required this.value,
    this.spacing = 8,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultLabelStyle =
        labelStyle ??
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

    final defaultValueStyle = valueStyle ?? const TextStyle(fontSize: 16);

    return Padding(
      padding: EdgeInsets.only(bottom: spacing),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(text: '$label:\n', style: defaultLabelStyle),
            TextSpan(text: value, style: defaultValueStyle),
          ],
        ),
      ),
    );
  }
}
