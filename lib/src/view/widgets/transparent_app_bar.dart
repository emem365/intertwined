import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/view/widgets/user_avatar.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  TransparentAppBar({this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: (title != null)
          ? Text(title!, style: TextStyle(color: MainColors.richBlackFogra))
          : null,
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
