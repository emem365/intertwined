import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intertwined/src/constants/app_theme.dart';

class IllustrationWithTitle extends StatelessWidget {
  final String illustrationPath;
  final String title;
  IllustrationWithTitle(this.illustrationPath, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      // margin: EdgeInsets.only(top: 36),
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              illustrationPath,
              semanticsLabel: 'Forgot Password',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w900,
                      color: MainColors.richBlackFogra,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}