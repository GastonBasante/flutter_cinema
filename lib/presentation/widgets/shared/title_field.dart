import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  final String title;
  const TitleField({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          title,

          style: textStyle.titleLarge,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
