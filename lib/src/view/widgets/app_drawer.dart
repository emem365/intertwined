import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/view/pages/auth/sign_in.dart';
import 'package:intertwined/src/view/widgets/user_avatar.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _AppDrawerHeader(),
          ListTile(
            leading: Icon(Icons.history),
            title: Text(
              'History',
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(
              'About',
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
            ),
            onTap: () {
              final authService =
                  Provider.of<AuthService>(context, listen: false);
              authService.signOut().then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                    (route) => false);
              });
            },
          ),
        ],
      ),
    );
  }
}

class _AppDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    var currentUser = authService.currentUser;
    assert(currentUser != null);
    return DrawerHeader(
      decoration: BoxDecoration(color: MainColors.lavendarBlush),
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

