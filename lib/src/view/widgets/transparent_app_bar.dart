import 'package:flutter/material.dart';
import 'package:intertwined/src/view/widgets/user_avatar.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) => Padding(
            padding: EdgeInsets.only(left: 8),
            child: InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: UserAvatar(),
              ),
            ),
          ),
        ),
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}