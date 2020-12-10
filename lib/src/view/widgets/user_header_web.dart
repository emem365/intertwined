import 'package:flutter/material.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/view/widgets/user_avatar.dart';
import 'package:provider/provider.dart';

class UserHeaderWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    var currentUser = authService.currentUser;
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UserAvatar(radius: 36),
          SizedBox(height: 24),
          Text(
            currentUser.displayName ?? 'User',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

