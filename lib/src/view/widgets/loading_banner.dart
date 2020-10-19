import 'package:flutter/material.dart';

class LoadingBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Material(
        color: Colors.black26,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
