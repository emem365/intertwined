import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/assets.dart';
import 'package:intertwined/src/view/widgets/illustration_with_title.dart';

class FilesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: IllustrationWithTitle(
            Assets.illustrations.comingSoon2, 'Feature Coming Soon...'));
  }
}
