import 'package:flutter/material.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/view/widgets/app_version.dart';
import 'package:intertwined/src/view/widgets/drawer_options.dart';
import 'package:intertwined/src/view/widgets/home_page_tabs_web.dart';
import 'package:intertwined/src/view/widgets/neumorphic_container.dart';
import 'package:intertwined/src/view/widgets/user_header_web.dart';

class WebMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: NeumorphicContainer(
        backgroundColor: Colors.white,
        width: 300,
        color: MainColors.lavendarBlush,
        child: SizedBox.expand(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    UserHeaderWeb(),
                    SizedBox(height: 48),
                    HomePageTabsWeb(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8.0),
                      child: DrawerOptions(),
                    ),
                  ],
                ),
              ),
              AppVersion(),  
            ],
          ),
        ),
      ),
    );
  }
}
