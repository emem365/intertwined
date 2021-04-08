import 'dart:math';

import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final EdgeInsets padding;
  final String? text;
  TextDivider({
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
    this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Divider(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: min(padding.left, padding.right)),
            child: Text(text ?? ''),
          ),
          Expanded(
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
