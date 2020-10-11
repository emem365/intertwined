import 'package:flutter/material.dart';

class TapableCircleAvatar extends StatelessWidget {
  final Widget child;
  final void Function() onTap;
  final Color backgroundColor;
  final double radius;

  TapableCircleAvatar({
    this.child,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.radius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: backgroundColor,
          radius: radius,
          child: child,
        ),
      ),
    );
  }
}