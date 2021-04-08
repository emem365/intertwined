import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/constants/assets.dart';
import 'package:intertwined/src/view/widgets/illustration_with_title.dart';

class ImagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IllustrationWithTitle(
          (kIsWeb)
              ? Assets.illustrations.comingSoon1Png
              : Assets.illustrations.comingSoon1,
          '',
        ),
        SizedBox(height: 12),
        Text(
          'Feature Coming Soon...',
          style: Theme.of(context).textTheme.headline5?.copyWith(
                fontWeight: FontWeight.w900,
                color: MainColors.richBlackFogra,
              ),
        )
      ],
    ));
  }
}
