import 'package:flutter/material.dart';

class CustomNavBarWrapper extends StatelessWidget {
  final Color? color;
  final BorderRadius borderRadius;
  final BottomNavigationBar navBar;

  CustomNavBarWrapper({
    this.color,
    required this.borderRadius,
    required this.navBar,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 0,
          bottom: 16,
        ),
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          elevation: 6.0,
          color: color ?? Theme.of(context).primaryColorDark,
          child: ClipRRect(borderRadius: borderRadius, child: navBar),
        ),
      ),
    );
  }
}
