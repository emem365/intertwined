import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:provider/provider.dart';

class UserAvatar extends StatelessWidget {
  UserAvatar({
    this.radius,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    var currentUser = authService.currentUser;
    assert(currentUser != null);

    const _personIcon = Icon(
      Icons.person,
      color: Colors.white70,
      size: 36,
    );

    return CircleAvatar(
      radius: 36,
      backgroundColor: MainColors.zomp,
      child: (currentUser.photoURL == null || currentUser.photoURL == '')
          ? _personIcon
          : ClipOval(
              child: CachedNetworkImage(
                imageUrl: currentUser.photoURL ?? '',
                progressIndicatorBuilder: (_, __, progress) =>
                    CircularProgressIndicator(value: progress.progress),
                errorWidget: (_, __, ___) => _personIcon,
              ),
            ),
    );
  }
}
