import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color color;
  final double bevel;
  final Offset blurOffset;
  final Widget child;

  NeumorphicContainer({
    Key key,
    this.width,
    this.height,
    this.child,
    this.bevel = 48.0,
    this.color,
    this.backgroundColor,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        this.backgroundColor ?? Theme.of(context).backgroundColor;
    final color = this.color ?? Theme.of(context).backgroundColor;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(bevel),
        boxShadow: [
          BoxShadow(
            blurRadius: bevel,
            offset: -blurOffset,
            color: Color.lerp(backgroundColor, Colors.white, 0.6),
          ),
          BoxShadow(
            blurRadius: bevel,
            offset: blurOffset,
            color: Color.lerp(backgroundColor, Colors.black, 0.3),
          )
        ],
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.lerp(color, Colors.white, 0.2),
              color,
              color,
              Color.lerp(color, Colors.black, 0.1),
            ],
            stops: [
              0,
              0.15,
              0.85,
              1.0
            ]),
      ),
      child: child,
    );
  }
}