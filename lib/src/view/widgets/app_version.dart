import 'package:flutter/material.dart';

class AppVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Text('Version : 0.0.1-alpha',
          style: Theme.of(context).textTheme.caption),
    );
  }
}
