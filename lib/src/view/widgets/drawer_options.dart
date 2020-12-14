import 'package:flutter/material.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/view/pages/about.dart';
import 'package:intertwined/src/view/pages/auth/sign_in.dart';
import 'package:provider/provider.dart';

class DrawerOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ListTile(
        //   leading: Icon(Icons.history),
        //   title: Text(
        //     'History',
        //   ),
        // ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text(
            'About',  
          ),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AboutApp()));
          },
        ),
        // ListTile(
        //   leading: Icon(Icons.settings),
        //   title: Text(
        //     'Settings',
        //   ),
        // ),
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
    );
  }
}
//TODO: Add HISTORY and SETTINGS