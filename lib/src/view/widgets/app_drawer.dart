import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/view/pages/auth/sign_in.dart';
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
              final authService = Provider.of<AuthService>(context);
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
    return DrawerHeader(
      decoration: BoxDecoration(color: MainColors.lavendarBlush),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'drawer-profile-pic',
            child: CircleAvatar(
              radius: 36,
              backgroundColor: MainColors.zomp,
              child: Icon(
                Icons.person,
                color: Colors.white70,
                size: 36,
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Username',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
