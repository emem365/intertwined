import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/assets.dart';

class AppVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Assets.logos.appLogo, width: 50,),
          Text('Version : 0.0.1-alpha',
              style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }
}
